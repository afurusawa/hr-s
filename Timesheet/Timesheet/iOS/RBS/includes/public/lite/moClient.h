/******************************************************************************
*    Copyright 2001 - 2002 Extended Systems
*    Source File            : CmoClient.h
*    Platform Dependencies  :
*    Description            : Header file for CmoClient class.
*
*    Notes                  : This class should not be used directly by MO
*                             applications. It is used by the interface classes
*                             produced by MO CIE.
******************************************************************************/
#ifndef CmoClient_H_INCLUDED
#define CmoClient_H_INCLUDED

#include "moOS.h"
#include "tchar.h"

#include "moParams.h"
#include "moOS.h"
#include "moTypes.h"
#include "moUtils.h"
#include "moRecordset.h"
#include "moString.h"
#include "moCommon.h"
#include "moThreadSafe.h"
#include "mo_bin_protocol.h"
#include <string>
#include <set>

#include "moBinary.h"
#include "moDateTime.h"
#include "moDBCommon.h"
#include "moErrCodes.h"
#include "moError.h"
#include "moList.h"
#include "moMemUtils.h"
#include "moStringList.h"

extern bool gbMO_DEBUG;

using namespace mo;
using namespace std;

#if defined _WIN32
#include "dbClientQueue.h"
#endif

// This is a representation of the profile database record.
typedef struct INT_PROF
{
   TCHAR *pcAccountName;
   TCHAR *pcServerID;
   UI16 usServerPort;
   UI8 *pucServerPubKey;
   UI16 usServerPubKeySize;
   TCHAR *pcPassword;
   TCHAR *pcCompanyID;
   TCHAR *pcDeviceID;
   TCHAR *pcConnectionID;
   TCHAR *pcValCode;
   TCHAR *pcDeviceIDSuffix;
   TCHAR *pcDeviceIDWithSuffix;
}INT_PROF;

#define DEFAULT_CLIENT_TIMEOUT          0
#define MO_UNICODE                      1
#define MO_ANSI                         0

// Field names of the columns in the ConnectionMethods record set.
#define CM_FLDNAME_CONN_NAME         _T("ConnName")     // Name of the connection as configured in the device.
#define CM_FLDNAME_PRIORITY           _T("Priority")     // Priority to try when attempting to connect


// the default CmocaAsyncResponse::RetryRequest value
#define DO_NOT_RETRY_REQUEST  0xFFFFFFFF 
#define MAX_RETRY_REQUEST_DELAY 60*60



namespace mo
{

   /******************************************************************************
   *  Description: This function must be called prior to any other usage of Mobile Objects
   ******************************************************************************/
   void MOInitialize();

   class CmoObject;
   class CmoConnection;
   class CmoRequestOptions;
   class CmocaClient;

   typedef struct INT_PROF* PINT_PROF;

   enum eConnectionStatus
   {
      eConnected = 1,                     // iParam is ignored
      eDisconnected = 2,                  // iParam is ignored
      eDeviceInFlightMode = 3,            // iParam indicates timeout (in seconds) before attempting to connect again
      eDeviceOutOfNetworkCoverage = 4,    // iParam indicates timeout (in seconds) before attempting to connect again
      eWaitingToConnect = 5,              // iParam indicates timeout (in seconds) before attempting to connect again
      eDeviceRoaming = 6,                 // iParam indicates timeout (in seconds) before attempting to connect again
      eDeviceLowStorageStop = 7           // iParam indicates timeout (in seconds) before attempting to connect again
   };

   // list of URLs to iterate through when connection to the server or proxy.
   // These URLs are used in the HTTP header
   #define TMURI_REVERSE_PROXY           _T("/tm/?cid=%cid%")
   #define TMURI_RELAY_SERVER_APACHE     _T("/cli/iarelayserver" )
   #define TMURI_RELAY_SERVER_IIS        _T("/ias_relay_server/client/rs_client.dll")
   #define TMURI_SUFFIX                  _T("/%cid%/tm")

   enum eTMURI
   {
      eURL_CONFIGURED_URL,                // use the URL that is configured -- once one is configured, no others will be tried
      eURL_REVERSE_PROXY,                 // use TMURI_REVERSE_PROXY
      eURL_APACHE,                        // use TMURI_RELAY_SERVER_APACHE
      eURL_IIS,                           // use TMURI_RELAY_SERVER_IIS
      eURL_FINISHED                       // done enumerating this list
   };
   inline
      eTMURI &operator++(eTMURI &d)
   {
      return d = eTMURI(d + 1);
   }


   // CmoConnection
   //*****************************************************************************
   class CmoConnection
   {
   public:
      CmoConnection( const TCHAR *pcServerID,
                     UI16 usServerPort,
                     const TCHAR *pcCompanyID,
                     const void *pvUnused,         // disregard parameter
                     const TCHAR *pcValCode,
                     const TCHAR *pcAccountName,
                     const TCHAR *pcPassword,
                     bool bUnused1,
                     bool bUnused2,
                     bool bUnused3 = false );

      CmoConnection();
      ~CmoConnection();

      void Init( const TCHAR *pcServerID,
                 UI16 usServerPort,
                 const TCHAR *pcCompanyID,
                 const TCHAR *pcValCode,
                 const TCHAR *pcAccountName,
                 const TCHAR *pcPassword,
                 bool bUnused1,
                 bool bUnused2,
                 bool bUnused3 );

      virtual I32  Connect();
      void Disconnect();
      virtual bool IsConnected();

      void Trace( I32 lTraceNum,
                  const TCHAR *pcTraceText );

      void SetConnectionID( const TCHAR *pcConnectionID );

      // Set the traveller https global
      static void SetHttpsEnabled( I32 bEnabled );
      static I32 GetHttpsEnabled();
      static void SetSslValidateCallback( void* pfn );

      const TCHAR *getServerID();
      UI16 getServerPort();
      const TCHAR *getAccountName();
      const TCHAR *getPassword();
      const TCHAR *getDBUserName();
      const TCHAR *getDBPassword();
      const TCHAR *getCompanyID();
      const TCHAR *getDeviceID();
      const TCHAR *getConnectionID();
      const TCHAR *getValCode();
      PINT_PROF GetActiveProfile();

#if defined (MO_CLIENT ) 
      I32 GetTMUrl( enum eTMURI eWhichURI, ECString &csTmURL, ECString &csFixedUpTmURL );
#endif

      UI16 getDeviceType();

      UI16 getCodePage()
      {
         return musOverrideCP;
      }
      void setCodePage( UI16 usValue )
      {
         musOverrideCP = usValue;
      }

      bool getShowDebugMsgs()
      {
         return gbMO_DEBUG;
      }
      void setShowDebugMsgs( bool bValue )
      {
         gbMO_DEBUG = bValue;
      }
      bool isConnected()
      {
         return mbConnected;
      }

      void SetDeviceID( const TCHAR* pcDeviceID );
      void SetDeviceIDSuffix( const TCHAR *pcDeviceIDSuffix );
      const TCHAR* GetDeviceIDSuffix() { return mpstActiveProfile->pcDeviceIDSuffix; }
      I32 SendRequest( const TCHAR *pcSrcURL, const TCHAR *pcDestURL, void* pfnReadFunction, void *pReadHandle, bool bIsNoAuthRequest );
      I32 ReadResponse( void *pBuf, long nFubLen, long *plBytesRead );
      I32 CommAdvance( bool *pbIsResponseAvail );
      I32 WaitForResponse();
      I32 CancelRequest();
      void StopOutstandingRequest();
#if defined MO_CLIENT
      ECString MORegistryValuePerConnectionCriteria( ECString csName );
      static ECString FormatMORegistryValuePerConnection( const TCHAR* pName, 
                                                          const TCHAR* pServer, 
                                                          DWORD dwPort, 
                                                          const TCHAR* pCompanyId );
#endif

   private:
#if defined( UNIT_TEST )      
      public:
#endif
      UI32 mulRequestStartTime;
      UI16 musClientTimeout;
      UI16 musOverrideCP;
      bool mbInitialized;
      bool mbConnected;
      bool mbCryptoInitialized;
      bool mbConnMgrInitialized;
      bool mbUserCancelled;
      bool mbDeviceAwake;

      PINT_PROF      mpstActiveProfile;

      void *mvpCMCtx;
      void *mvpTLCtx;
      void *mvpCryptFunctions;

      void InternalInit();

      void InternalInitProfile( const TCHAR *pcServerID,
                                UI16 usServerPort,
                                const TCHAR *pcCompanyID,
                                const TCHAR *pcValCode,
                                const TCHAR *pcAccountName,
                                const TCHAR *pcPassword,
                                bool bCachePassword,
                                bool bUseEncryption,
                                bool bUseSerialUSB );


      I32 CheckDeviceIDChange();
      void SetArchivedDeviceID();
      void SetConnectionName();
      void MakeConnectionNameAvailable();
      wstring GetDeviceIDArchivedKeyName();
  
      I32 GetMOErrorFromTLError( I32 lTLStatus );

      // Do not use connection method recordset for iPhone client
      // iPhone client always uses single connection method

#if defined( UNIT_TEST )
   public:
#endif

      CmoString *mpcsConnectionNameFromList;
      static CmoCriticalSection moCriticalSectionAvailableConnectionNames;

      static set<CmoString*> msetAvailableConnectionNames;
      friend class CmoObject;
      friend class ServerVersionInfo;
   };// CmoConnection
   //*****************************************************************************



   // CmoObject
   //*****************************************************************************
   class CmoObject
   {
   public:
      CmoObject( CmoConnection* pConnection );
      virtual ~CmoObject();

      CmoParam* CreateParam( const TCHAR *pucParamName,
                             MO_DATATYPE eDataType,
                             bool bByRef,
                             void* pData,
                             UI32 ulDataSize );

      void ClearParams()
      {
         mpoParams->Clear();
      }

      void Connect();

      void Execute( CmoRequestOptions* pRequestOptions,
                    const TCHAR *pcObjectName,
                    const TCHAR *pcMethodName );

      void Disconnect();

      CmoParam* GetParam( const TCHAR *pcParamName )
      {
         return mpoParams->ParamByName( pcParamName );
      }
      CmoParam* GetParamByIndex( UI32 ulIndex )
      {
         return mpoParams->ItemAtPos( ulIndex );
      }
      CmoParam* GetReturnParam()
      {
         return mpoParams->getReturnParam();
      }
      CmoParam* GetRequestIDParam()
      {
         return mpoParams->getRequestIDParam();
      }
      I32 GetParamCount( bool bReturnCountOnly )
      {
         return mpoParams->Count( bReturnCountOnly );
      }

      void UpdateConn( CmoConnection* pConn );

      void ParseStreamedResponse
         (
         CmoRequestOptions    *poRequestOptions, // (I) request options
         MO_COMMAND           *peCommand         // (O) the command type returned
         );

      bool MoreBatchedCommands();

      virtual bool LoadUpNextBatchedCommand()
      {
         return false;
      }

      CmoParamList * GetParamList()
      {
         return mpoParams;
      }

      void ClearObjectHandle();
      CmoConnection  *mpoConnection;

   protected:
#if defined( UNIT_TEST )
      public:
#endif
         
#if defined (MO_CLIENT ) 
      void HandleD2sStreaming( CmoRequestOptions* poRequestOptions );
#endif
      void Initialize( CmoConnection* pConnection );
      CmoObject( const TCHAR *pcServerID,
                 UI16 usServerPort,
                 const TCHAR *pcCompanyID,
                 const TCHAR *pcValCode,
                 const TCHAR *pcAccountName );
      bool mbDeleteConnection;
      CmoParamList   *mpoParams;
      MO_RESPONSE    mstResponse;
      I32            mlParamsParsed;
      I32            mlParamCountForAwaitRequest;

   private:
#if defined( UNIT_TEST )
      public:
#endif

      UI32           mlPendingRetrieveAck;
      UI8            *mpucObjectHandle;
      bool           mbObjectHandleSet;

      void HandleAsyncInvoke( CmoRequestOptions* pRequestOptions,
                              const TCHAR *pcObjectName,
                              const TCHAR *pcMethodName );

      I32 StreamHeader
         (
         void                 *pvStream,        // (I) stream to write all values to
         INT_PROF*            pstProfile,       // (I) profile information
         CmoRequestOptions    *poRequestOptions,// (I) request options
         const TCHAR          *pcClassName,     // (I) class containing method to invoke
         const TCHAR          *pcMethodName     // (I) method to invoke
         );

      void DoRetrieveAck( I32 lRequestID );
      void DeletePendingRequest( CmoRequestOptions* pRequestOptions );
      void AddPendingRequest( CmoRequestOptions* pRequestOptions );
      UI16 GetCharEncoding();
   }; // CmoObject
   //*****************************************************************************


   // CmoRequestOptions
   //*****************************************************************************
   class CmoRequestOptions
   {
   public:
      CmoRequestOptions();
      ~CmoRequestOptions();

      UI16 getClientTimeout()
      {
         return musClientTimeout;
      }
      void setClientTimeout( UI16 usSeconds )
      {
         musClientTimeout = usSeconds;
      }

      I32 getRequestHandle()
      {
         return mlRequestHandle;
      }
      void setRequestHandle( I32 lValue )
      {
         mlRequestHandle = lValue;
      }
      MO_COMMAND getCommand()
      {
         return meCommand;
      }
      void setCommand( MO_COMMAND eValue )
      {
         meCommand = eValue;
      }

      void setAsyncObjectName( const TCHAR *pcName )
      {
         mstrCallbackName = pcName;
      }

      CmoString& getAsyncObjectName()
      {
         return mstrCallbackName;
      }

      void setMocaClient( CmocaClient *poMocaClient )
      {
         mpoMocaClient = poMocaClient;
      }

      CmocaClient *getMocaClient()
      {
         return mpoMocaClient;
      }

      void setNoAuthRequest( bool bSet )
      {
         mbNoAuthRequest = bSet;
      }
      
      bool isNoAuthRequest()
      {
         return mbNoAuthRequest;
      }

      /**
       * set the SupRequestId, which is a value that is added to logs 
       * throughout the system so that the independant logs can be 
       * correlated.
       * (do not confuse this with the MOCA Request ID stored in the requestHandle)
       * @param supRequestId
       */
      void setSupRequestId( const TCHAR *pcSupRequestID )
      {
         mstrSupRequestID = pcSupRequestID;
      }

      /**
       * 
       * @return return the SupRequestId, which is a value that is added to logs 
       *         throughout the system so that the independant logs can be
       *         correlated.
       */
      CmoString &getSupRequestId()
      {
         return mstrSupRequestID;
      }

      /**
       * 
       * @return true if a value is set in the SupRequestId
       */
      bool isSupRequestIdSet()
      {
         return (mstrSupRequestID.Length() > 0 );
      }


   private:
      MO_COMMAND meCommand;
      UI16 musClientTimeout;
      I32  mlRequestHandle;
      CmoString mstrCallbackName;
      CmocaClient *mpoMocaClient;
      bool mbNoAuthRequest;
      CmoString mstrSupRequestID;  

      friend class CmoObject;
   }; // CmoRequestOptions
   //*****************************************************************************


   // CmocaAsyncResponse
   //*****************************************************************************
   class CmocaAsyncResponse
   {
   public:
      CmocaAsyncResponse( const TCHAR *pcObjectName )
      {
         mstrObjectName = pcObjectName; mlRetryRequestDelay=0;
      };
      virtual void Response( I32 lRequestID,     // (I) the ID of the request
                             CmoError *poError,  // (I) NULL or the error object if an error occurred
                             const TCHAR *pcMethodName,  // (I) the method that ran
                             CmoParamList &oParams // (I) output params
                           ) = 0;
      const CmoString &getName()
      {
         return mstrObjectName;
      };
      void setRetryRequestDelay( I32 lDelay )
      {
         if ( lDelay > MAX_RETRY_REQUEST_DELAY )
            lDelay = MAX_RETRY_REQUEST_DELAY;
         mlRetryRequestDelay = lDelay; 
      };
      I32 getRetryRequestDelay()
      {
         return mlRetryRequestDelay;
      };

   private:
      CmoString mstrObjectName;
      I32       mlRetryRequestDelay;
   };  // CmocaAsyncResponse
   //*****************************************************************************



   // CmocaObject
   //*****************************************************************************
   class CmocaObject
   {
   public:
      CmocaObject( const TCHAR *pcObjectName )
      {
         mstrObjectName = pcObjectName;
      };
      virtual void Run( const TCHAR *pcMethodName, CmoParamList &oParams ) = 0;
      const CmoString &getName()
      {
         return mstrObjectName;
      };
   private:
      CmoString mstrObjectName;
   };  // CmocaObject
   //*****************************************************************************


   class CmocaProcessQueue;

   // CmocaClient
   //*****************************************************************************
   class CmocaClient
   {
      friend class CmocaProcessQueue;

   public:
      CmocaClient( const TCHAR *pcServerID,
                   UI16 usServerPort,
                   const TCHAR *pcCompanyID,
                   const TCHAR *pcAccountName,
                   const TCHAR *pcConnectionIDServerToDevice,  // connection id used for server to device
                   // requests (QUEUE ITEMS WITH THIS CONNECTION NAME)
                   const TCHAR *pcConnectionIDDeviceToServer,  // connection id used for device to server
                   const TCHAR *pcValCode
#ifdef ROBIE_LOAD_CLIENT
                   ,const TCHAR *pcMoDataFolder                // for robie load test client only
#endif
                 );
      virtual ~CmocaClient();

      void Start();
      virtual void Stop();
      bool IsStopped();


      eConnectionStatus GetConnectStatus()
      {
         return meConnectStatus;
      };
      void SetConnectStatus( eConnectionStatus eCS, 
                             I32 lDelay = 0, 
                       I32 lError = 0, 
                             const TCHAR *pcErrorMessage = NULL )
      {
         meConnectStatus = eCS;
         OnConnectStatus( meConnectStatus, lDelay, lError, pcErrorMessage );
      }
      void Register( CmocaObject *poObject );
      void Register( CmocaAsyncResponse *poObject );
      void DropConnections();

      I32 QueueAsyncInvoke( const TCHAR *pcObjectName,
                            const TCHAR *pcMethodName,
                            I32 lClientTimeout,
                            CmoParamList *poParams,
                            const TCHAR *pcAsyncObjectName );

      void SetAllowRoaming( bool bAllowRoaming );
      bool GetAllowRoaming();

      // setup worker threads for Server to Device calls.  The number of worker
      // threads is related to the number of requests that can be concurrently
      // handled.  The default is 0 and the regular thread used for communications
      // is the worker thread.
      // Note: This value must be set before Start is called
      void SetWorkerThreadCount( I32 lWorkerThreads );


      // If the application creates an ancestor class of CmocaClient and implements
      // the below methods, then they will be called when an event occurs

      // OnConnectError -- called any time a communication error occurs
      virtual void OnConnectError( CmoError *)
      {
      };

      // OnConnectStatus -- called when a connection condition changes
      virtual void OnConnectStatus( eConnectionStatus eStatus, UI32 iParam = 0,
                                    I32 lError = 0, const TCHAR *pcErrorMessage = NULL )
      {
      };

      // OnThreadStart -- called when the mocaclient creates a background thread
      // Note, there may be two or more threads
      virtual void OnThreadBegin()
      {
      };

      // OnThreadStart -- called when the mocaclient creates a background thread
      // Note, there may be two or more threads
      virtual void OnThreadExit()
      {
      };

#if defined WIN32 && !defined _WIN32_WCE
      // this is an internal override that can be used to force the moca client
      // to use a specified device id for the background connects - currently only here
      // for win32 load client testing.
      // Needs to be called before Start()
      void SetDeviceID( const TCHAR* pcDeviceID );
#endif
      void SetDeviceIDSuffix( const TCHAR* pcDeviceIDSuffix );

      // internal override to set a location for the moca data folder other than
      // the default.
      void SetMoDataFolder( const TCHAR* pcPath );


      // polls memory and drops connection if memory is low
      bool IsLowStorage();

      
      void ClearMocaQueues();

     void ResetBackoff();


#if defined WIN32 && !defined _WIN32_WCE
      void EnableBlackBerryPushMode();
      void DisableBlackBerryPushMode();
      bool IsBlackBerryPushModeEnabled();
      void ConnectNow();
      HANDLE            m_hReceivedPushNotification;
#endif

#if defined( MOCLIENT_IPHONE ) || defined( USE_MOBILE_OBJECTS )
      bool IsMOCAThreadId( pthread_t iPThreadID );
#endif



   private:
#if defined( UNIT_TEST )
      public:
#endif

#ifdef ROBIE_LOAD_CLIENT
      CmoString         mstrMoDataFolder;
#endif
#if defined WIN32 && !defined _WIN32_WCE
      bool              mbBlackBerryPushModeEnabled;
#endif
      

#if defined _WIN32
      dbClientQueue      moDbQueue;
#endif
      CmocaProcessQueue  *mpoProcessClientQueue;
      CmocaProcessQueue  *mpoProcessServerQueue;
      static I32         mlInstanceCount;
      eConnectionStatus  meConnectStatus;
   };  // CmocaClient
   //*****************************************************************************



}//namespace mo



#endif // CmoClient_H_INCLUDED


