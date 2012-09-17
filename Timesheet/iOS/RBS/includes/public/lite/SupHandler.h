/******************************************************************************
* Copyright 2009 iAnywhere Solutions, Inc.
* Source File            : SupHandler.h
* Created By             : Marc J
* Date Created           : 3/20/2009
* Platform Dependencies  : 
* Description            : Object to handle interface between SUP and 
*                          ClientEngine. Implements a singleton pattern.

            
******************************************************************************/

#pragma once
#include "SupInterface.h"
#include "moClient.h"
#include "CriticalSection.h"

/******************************************************************************
 * Name         : CSupHandlerMoca
 * Desc         : Simple MOCA object for receiving SUPObj calls from server.
 *****************************************************************************/
class CSupHandlerMoca : public CmocaObject
{
public:
   CSupHandlerMoca()
      : CmocaObject ( SUP_CLIENT_OBJ )
   {
   }

   // Process server request
   void Run( const char *pcMethodName, CmoParamList &oParams );
};


/******************************************************************************
* Name         : CSupHandlerMocaAsyncResponse
* Desc         : Simple MOCA object for receiving responses to async server calls
*****************************************************************************/
class CSupHandlerMocaAsyncResponse : public CmocaAsyncResponse
{
public:
   CSupHandlerMocaAsyncResponse()
      : CmocaAsyncResponse( SUP_CLIENT_ASYNC_RESPONSE )
   {
      mlDelayTime = 0;
   }


   // method called by MOCA when an async request of the server is completed
   virtual void Response( I32 lRequestID,     // (I) the ID of the request
                          CmoError *poError,  // (I) NULL or the error object if an error occurred
                          const TCHAR *pcMethodName,  // (I) the method that ran
                          CmoParamList &oParams // (I) output params
                        )
   {
      // an error was returned, set a delay time which causes MOCA to retry
      // use a maximum of 30 minutes
      if ( poError )
      {
         if ( mlDelayTime == 0 )
            mlDelayTime = 5;
         else
            mlDelayTime *= 2;

         if ( mlDelayTime > MAX_SUP_RETRY_DELAY )
            mlDelayTime = MAX_SUP_RETRY_DELAY;

         setRetryRequestDelay( mlDelayTime );
      }
      else
         mlDelayTime = 0; // reset the delay
   }

   int mlDelayTime; // seconds to delay prior to retrying
};


/******************************************************************************
 * Name         : CSupHandlerMo
 * Desc         : Simple MO object for sending SUPObj calls to server.
 *****************************************************************************/
class CSupHandlerMo : public CmoObject
{
public:
   CSupHandlerMo( CmoConnection* poConn )
      : CmoObject ( poConn )
   {
   }
   int SendMessageToServer( const char* pcHeader, const unsigned char* pbData, unsigned int uiByteCount  );
   void SendLogsToServer();
};


/******************************************************************************
 * Name         : CSupHandler
 * Desc         : Implementation of singleton object to manage the interface 
 *                between the SUPObj DLL and the OBEngine.
 *  
 *****************************************************************************/
class CSupHandler
{
public:
   // This object should not be created outside this class.
   // Returning reference to static object from within GetSupHandler() causes bug 31424.
   // To fix this bug created a global instance of the object which required constructor and destructor to be public (instead of private as before)
   // So making constructor and destructor public but this object should not be created anywhere except for global object in SupHandler.cpp
   // Access to this global object should through static fuction in this class GetSupHandler()
   CSupHandler(void);
   virtual ~CSupHandler(void);

   /***************************************************************************
    * Name         : CSupHandler::GetSupHandler
    * Desc         : Returns singleton instance of the CSupHandler object.
    *  
    **************************************************************************/
   static CSupHandler& GetSupHandler();

   /***************************************************************************
    * Name         : CSupHandler::Init
    * Desc         : Called by client App on startup to initialize the 
    *                SupHandler instance with the App's MO/MOCA state.
    *  
    **************************************************************************/
   void Init( CmoConnection* poConn, CmocaClient* poMocaClient );

   /***************************************************************************
    * Name         : CSupHandler::Uninit
    * Desc         : Called by client App on shutdown to clean up the
    *                SupHandler instance with the App's MO/MOCA state.
    *  
    **************************************************************************/
   void Uninit();

   /***************************************************************************
    * Name         : CSupHandler::ProcessCallFromServer
    * Desc         : Called by CSupHandlerMoca when it receives a message for
    *                the SUPObj DLL
    *  
    **************************************************************************/
   void ProcessCallFromServer( const char* pcHeader, const unsigned char* pbData, unsigned int uiByteCount  );

   /***************************************************************************
    * Name         : CSupHandler::ProcessRefreshAllData
    * Desc         : Called by CSyncAgent when it receives a an INIT message
    *  
    **************************************************************************/
   void ProcessRefreshAllData();

   /******************************************************************************
   * Name         : CSupHandler::ConnectionStateChanged
   * Desc         : Called when the Messaging client connects, disconnects, 
   *                loses connectivity, etc
   *****************************************************************************/
   void ConnectionStateChanged( int iConnectionStatus, int iConnectionType, int iError, const char *pcErrorMessage );
   
#ifdef UNIT_TEST
   friend class CSyncAgent_Test;
#endif

private:
   

   /***************************************************************************
    * Name         : CSupHandler::LogText
    * Desc         : Static method that is passed as a pointer to the 
    *                Initialize() method in the SUPObj DLL.  Calls the 
    *                LogTextImpl method of the singleton instance.
    *  
    **************************************************************************/
   static void LogText( int iLevel, const char* pcParam )
   {
      GetSupHandler().LogTextImpl( iLevel, pcParam );
   }

   /***************************************************************************
    * Name         : CSupHandler::QueueAsyncMethodCallForServer
    * Desc         : Static method that is passed as a pointer to the 
    *                Initialize() method in the SUPObj DLL.  Calls the 
    *                QueueAsyncMethodCallForServerImpl method of the singleton 
    *                instance.
    *  
    **************************************************************************/
   static int QueueAsyncMethodCallForServer( const char* pcHeader, 
                                             const unsigned char* pbData, 
                                             unsigned int uiByteCount  )
   {
      return GetSupHandler().QueueAsyncMethodCallForServerImpl( pcHeader, pbData, uiByteCount );
   }

   void HandleSUPObjException( int iError, const TCHAR *pcSUPMethod, const TCHAR *pcExceptionMessage );


   void LogTextImpl( int iLevel, const char* pcParam );

   int QueueAsyncMethodCallForServerImpl( const char* pcHeader, const unsigned char* pbData, unsigned int uiByteCount  );

   // privatized constructors, operators to prevent creation and copying
   // of individual CSupHandler objects
   CSupHandler( const CSupHandler& );
   CSupHandler& operator= ( const CSupHandler& );

   // function pointers into SUPObj DLL
   PFNInitialize                  m_pfnInitialize;
   PFNDispose                     m_pfnDispose;
   PFNAsyncMethodCallFromServer   m_pfnAsyncMethodCallFromServer;
   PFNRefreshAllData              m_pfnRefreshAllData;
   PFNConnectionStateChanged      m_pfnConnectionStateChanged;

   bool m_bInit;
   
   // MO/MOCA objects
   CSupHandlerMoca m_oMocaObj;
   CSupHandlerMocaAsyncResponse m_oMocaAsyncResp;
   CSupHandlerMo* m_poMoObj;

   // Critical section used to serialize calls to SUPObj
   CriticalSection m_cs;
};
