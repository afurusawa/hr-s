/******************************************************************************
*    Copyright 2001 - 2003 Extended Systems
*    Source File            : moBinary.h
*    Platform Dependencies  :
*    Description            : Header file for CmoBinary class.
*
*    Notes                  : CmoBinary class represents a container for binary
                              data, typically used as an argument type in MO
                              client applications.
******************************************************************************/
#ifndef CmoBinary_H_INCLUDED
#define CmoBinary_H_INCLUDED



#include "moOS.h"
#include "moTypes.h"
#include "moList.h"
#include "moString.h"

#if defined( USE_MOBILE_OBJECTS ) // iMO team - do not ever define this. Everyone else must define it
   #if !defined( ECMemoryFile )
      #define ECMemoryFile void
   #endif
   #if !defined( ECFile )
      #define ECFile void
   #endif
   #if defined( MOCLIENT_IPHONE) 
      Do not define MOCLIENT_IPHONE and USE_MOBILE_OBJECTS
      the iMO team must define MOCLIENT_IPHONE but not USE_MOBILE_OBJECTS.
      the SUP team must define USE_MOBILE_OBJECTS and not MOCLIENT_IPHONE
   #endif
#endif

#if !defined( USE_MOBILE_OBJECTS ) // iMO team - do not ever define this. Everyone else must define it
#include "efile.h"
#endif
#include "moMemUtils.h"
#include <string>

#ifdef _WIN32
   #include <OAIDL.h>  // for SAFEARRAY
#endif

// for friend declarations below
namespace mo
{
   class CmocaProcessServerQueue;
   class CmocaProcessClientQueue;
   class CmoConnection;
   class CmoParam;
}



// Stream reader class for D2S streaming.
// Override the class to implement a streamed param.
class MoBinaryStreamReader
{
   public:
      MoBinaryStreamReader(){}
      virtual I32 Read( void *pBuffer, I32 nBytes ) = 0;
};

/******************************************************************************
*    Name       :  class CmoBinary
*    Desc       :  Class wrapper for raw, unformatted data buffer.
*
******************************************************************************/
class CmoBinary
{
public:
   CmoBinary();

   ~CmoBinary();

   CmoBinary( void* pData,
              UI32 ulDataSize,
              bool bAutoFree = false,
              bool bOkToFree = true );
#if ( defined( MO_CLIENT ) || defined( USE_MOBILE_OBJECTS ) )
   // S2D streaming
   CmoBinary( const CmoString& sCookie, long lOffset, mo::CmoConnection& oMoConnection );
   void SetCookieMode( const CmoString& sCookie, UI32 ulSize, long lOffset, mo::CmoConnection& oMoConnection, bool bCloneConnection );
   
   void SetCookieMode( const CmoString& sClientCookie, UI32 ulDataSize, 
                       long lOffset, 
                       // connection settings
                       const CmoString& sServerID,
                       UI16 iServerPort,
                       const CmoString& sCompanyID,
                       const CmoString& sValCode,
                       const CmoString& sAccountName,
                       const CmoString& sPassword
                      );

    // D2S streaming
    CmoBinary( MoBinaryStreamReader* pD2sReader );
    MoBinaryStreamReader* GetD2sStreamReaderPtr();

#endif
#ifdef _WIN32
   CmoBinary( SAFEARRAY* pArray );
#endif

   void* Detach();
   UI32 GetSize();
   void* GetData();

   void SetData( const void* pData,
                 UI32 ulDataSize,
                 bool bAutoFree = false,
                 bool bOkToFree = true );

   void FreeData();

   bool operator ==( CmoBinary& oRH );

   bool operator !=( CmoBinary& oRH );
  
   

   void SetStreamMode();
   bool IsStreamMode();

   UI32 CurrentOffset();
   void Append( void *pData, UI32 ulDataSize );
   void ReadStream( void *pData, UI32 *pulDataSize );
   ECMemoryFile *DetachStream();

#if defined( MO_CLIENT ) || defined( MOCLIENT_IPHONE ) || defined( USE_MOBILE_OBJECTS )
   bool IsMaterialized()
   {
      return m_bMaterialized;
   }

   void Materialize();
   void ReleaseCookie();
   CmoString GetCookie();

   static CmoString GetMaterializeFileFolder();
   static CmoString GetMaterializeFileNamePrefix();
   CmoString MakeMaterializeFileName();
   static void CleanOldFiles();
#endif


   void AttachStream( ECMemoryFile *poStream );
   void AttachFileStream( ECFile *poFileStream, const TCHAR* pszFileName );

   void RewindStream();

private:
   ECMemoryFile *mpoStream;
   UI32 mulCurrentOffset;

#ifdef MO_CLIENT
   CmoString MakeClientCookie();
   void ParseClientCookie( const CmoString& sClientCookie );
#endif

   MoBinaryStreamReader* m_pD2sReader;

   char* m_pData;
   UI32 m_ulDataSize;
   bool m_bAutoFree;
   bool m_bOkToFree;
   void Init();
   bool m_bMaterialized;
   CmoString m_sMaterializedFileName;

   CmoString m_sServerCookie;
   CmoConnection* m_poMoConnection;
   CmoConnection* m_poClonedMoConnection;
  
   friend class mo::CmocaProcessServerQueue;    // for access to RewindStream
   friend class mo::CmocaProcessClientQueue;    // for access to RewindStream


   // the following are used for internal streaming implementation
   void StartNetworkStream();
   void ReadNetworkStream( void *pData, UI32& ulDataSize );
   UI32 m_iCurNetworkStreamEndIdx;
   bool m_bNetworkStreamActive;

#ifdef UNIT_TEST
   friend class CTestAsyncServerCall3;          // for access to RewindStream
   friend class CmocaTestCallbackObject2;       // for access to RewindStream
   friend class CmoParam;                       // for SetCookieMode
   friend class CmoParams2_Test;                // for access to RewindStream
public:
   bool m_bInterruptMaterialize;                // simulates a network error during materialize
#endif 

};// CmoBinary



#endif// CmoBinary_H_INCLUDED
