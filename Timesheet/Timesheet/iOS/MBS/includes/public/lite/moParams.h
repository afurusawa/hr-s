/******************************************************************************
*    Copyright 2001 - 2003 Extended Systems
*    Source File            : moParams.h
*    Platform Dependencies  :
*    Description            : Header file for CmoParams class.
*
*    Notes                  : This class should not be used directly by MO
*                             applications. It is used by the interface classes
*                             produced by MO CIE.
******************************************************************************/
#ifndef CmoParams_H_INCLUDED
#define CmoParams_H_INCLUDED

#define DEFAULT_PRECISION    4

#include "moOS.h"
#include "moCommon.h"
#include "moList.h"
#include "moString.h"
#include "moStringList.h"
#include "moRecordset.h"
#include "MoCommon.h"
#include "moBinary.h"

#ifdef MO_SERVER
#include "resource.h"
#include <atlbase.h>
#include <atlcom.h>
#include <atlsafe.h>
#include <comdef.h>
#include <winerror.h>

//#include "\Common\ScriptEditor\CommonCOM.h"
#include "msado15.tlh"
#endif

#if defined( USE_MOBILE_OBJECTS ) // iMO team - do not ever define this. Everyone else must define it
   #if !defined( ECMemoryFile )
      #define ECMemoryFile void
   #endif
   #if !defined( ECFile )
      #define ECFile void
   #endif
   #if !defined( ECStream )
      #define ECStream void
   #endif
#endif

#define MO_RECORD_START _T( '~' )
#define MO_RECORDS_ALL_FINISHED _T( '$' )

#define D2S_STREAM_FRAGMENT_SIZE  128*1024 // arbitrary object size for D2S streaming fragments.

namespace mo
{

//*********************************************************
class CmoParamList;
class CmoParam;
class CmoConnection;

//******************************************************************************
class CmoParamList
{
public:
   CmoParamList( I16 sFloatPrecision = DEFAULT_PRECISION );
   ~CmoParamList();

   static void OnClear( void* pData );

   CmoParam* Add() ;

   void Delete( UI32 ulPos );

   void Delete( const TCHAR* pcName );

   I32 Count( bool bReturnCountOnly );

   CmoParam* ItemAtPos( UI32 ulPos );

   CmoParam* ParamByName( const TCHAR* pcName, bool bThrowException = true);

   void Clear();

   UI32 getBPParamDataSize( bool bByRefOnly = false );

   UI32 getBPParamHeaderTotalSize( bool bByRefOnly );

   I32 getOutParamCount();

   I16 getPrecision(){ return m_sPrecision;}
   void setPrecision( I16 sValue ){ m_sPrecision = sValue;}

   CmoParam* getReturnParam(){ return m_pReturnParam;}
   void setReturnParam( CmoParam* pParam );
   CmoParam* getObjectNameParam(){ return m_pObjectNameParam;}
   void setObjectNameParam( CmoParam* pParam );
   CmoParam* getMethodNameParam(){ return m_pMethodNameParam;}
   void setMethodNameParam( CmoParam* pParam );
   CmoParam* getRequestIDParam(){ return m_pRequestIDParam;}
   void setRequestIDParam( CmoParam* pParam );
#ifndef MO_SERVER
   void StreamParamsToFile( CmoString csStreamFileName,
                            MO_STREAM_DIRECTION eDirection );
#endif
   void StreamParamsToBinary( CmoBinary &oBinary,
                              MO_STREAM_DIRECTION eDirection );
   void StreamParams( void *pvWrite, MO_STREAM_DIRECTION eDirection );
   void ParseStreamFromBinary( CmoBinary  &oBinaryStream,
                               I32        lParamCount,
                               MO_COMMAND eCommand );
#if defined MO_SERVER
   void ParseStreamFromBinary( ECByteArray      &oBAStream, 
                               I32              lParamCount,
                               MO_COMMAND       eCommand );
#endif
   void ParseStreamFromFile( CmoString  csStreamFileName,
                             I32              lParamCount,
                             MO_COMMAND       eCommand );
   void ParseStream( void *pvRead, I32 lParamCount, MO_COMMAND eCommand );

   void MoveFirstParam( CmoParamList *poFromParams );

   void setAssociatedDeviceId( const CmoString& sAssociatedDeviceId ) { m_sAssociatedDeviceId = sAssociatedDeviceId; }
   CmoString getAssociatedDeviceId() { return m_sAssociatedDeviceId; }

   void setAssociatedRequestId( I32 iAssociatedRequestId ) { m_iAssociatedRequestId = iAssociatedRequestId; }
   I32 getAssociatedRequestId() { return m_iAssociatedRequestId; }

   void setAssociatedConnection( CmoConnection* poAssociatedConnection ) { m_poAssociatedConnection = poAssociatedConnection; }
   CmoConnection* getAssociatedConnection() { return m_poAssociatedConnection; }

private:
   CmoList* m_pList;

   CmoParam* m_pReturnParam;
   CmoParam* m_pRequestIDParam;
   CmoParam* m_pObjectNameParam;
   CmoParam* m_pMethodNameParam;

   I16 m_sPrecision;

   CmoString m_sAssociatedDeviceId;
   I32 m_iAssociatedRequestId;
   CmoConnection* m_poAssociatedConnection;

};// CmoParamList



//******************************************************************************

class CmoParam
{

public:
   CmoParam( CmoParamList* pOwner );
   ~CmoParam();

   CmoString& getName(){ return m_strName;}
   void setName( const TCHAR* pcValue ){ m_strName = pcValue;}

   MO_DATATYPE getDataType(){ return m_eDataType;}
   void setDataType( MO_DATATYPE eValue ){ m_eDataType = eValue;}

   MO_PASSTYPE getPassType(){ return m_ePassType;}
   void setPassType( MO_PASSTYPE eValue ){ m_ePassType = eValue;}

   I16 getPrecision(){ return m_sPrecision;}
   void setPrecision( I16 sValue ){ m_sPrecision = sValue;}

   UI8* getBPData(){ return m_pucBPData;}

   void InitSetBPData( UI32 ulDataSize );

   void setBPData( const void* pValue,
                   UI32 ulDataSize );

   void setBPDataFromList( CmoList *poBufferList,
                           UI32    ulOffset,
                           UI32    ulDataSize );

   UI32 getBPDataSize(){ return m_ulBPValueSize;}

   void setOutDataPtr( void* pData );
   UI8* getOutDataPtr(){ return m_pucOutData;}


   CmoParamList* getOwner(){ return m_pOwner;}

   I32 WriteToStream( void           *poStream,
                      STREAM_STATE   *peState );

   I32 ReadFromStream( void              *pvStream,
                       void              *pvParamHeader,
                       TCHAR             *pcParamName,
                       TCHAR             *pcDeviceId = NULL );

   void ConvertToADORecordset();

   I32 WriteADODataToStream( void *pvStream, void* pADORecordset );
   void WriteStringElementToStream(void  *pvStream, void* pObject);
   void WriteADODataArrayToStream( void * pvStream);
   void WriteStringArrayToStream( void * pvStream);
   void ReadADODataFromStream( void *pvStream, void** ppADORecordset, bool bNotSetParamType);
   void ReadObjectElementFromStream(void *pvStream, void** ppObjectElement);
   void ReadDataTableArrayFromStream( void *pvStream);
   void ReadObjectArrayFromStream(void *pvStream);

   void GetString( CmoString* pstrResult );
   void GetString( TCHAR ** ppcResult );
   void SetString( const TCHAR* pcValue );
   void SetString( CmoString* pstrValue );
   void SetDateTime( CmoDateTime* pValue );
   void GetDateTime( CmoDateTime* pResult );
   void SetBoolean( bool bValue );
   void SetBooleanElementValue(bool bValue, I32 iIndex);
   void SetSingle( R4 fValue );
   void SetDouble( R8 dValue );
   void SetCurrency( I64 cyValue );
   void SetLong( I32 lValue );
   void SetShort( I16 sValue );
   void SetULong( UI32 ulValue );
  void SetLongElementValue(I32 lValue, I32 iIndex );//just set the value, no memory allocation
   I32  GetLongElementValue(I32 iIndex);
   void SetUShort( UI16 usValue );
   void SetInt64( I64 cyValue);
  // void SetUInt64( I64 cyValue);
   void SetByte(UI8 byteValue);
   void SetSByte(I8 charValue);


   bool GetBoolean();
   bool GetBooleanElementValue(I32 iIndex);
   UI8 GetByte();
   I8 GetSByte();
   R4 GetSingle();
   R8 GetDouble();
   I64 GetCurrency();
   I64 GetInt64();
//   I64 GetUInt64();  //uint64 is not a type in com,
   I32 GetLong();
   I16 GetShort();
   UI32 GetULong();
   UI16 GetUShort();


   UI8* GetBinary( UI32* pulDataSize );
   void GetBinary( CmoBinary* pBinary );
   void SetBinary( ECMemoryFile *poStream );

#ifdef _WIN32
   void SetBinary( SAFEARRAY* pArray );
   void SetBinary( SAFEARRAY* pArray, MO_DATATYPE baseType );
   UI8* GetElementVarFromBuffer(const UI8* pucData, int iIndex, int iElementSize);
   DECIMAL GetDecimal();
   void SetDecimal(DECIMAL dcValue);
   void SetADORecordsetArray( SAFEARRAY* pArray);
   void SetStringArray( SAFEARRAY* pArray);
#endif


   bool IsBinaryStreamed();
   void SetBinary( const UI8* pucData,
                   UI32 ulDataSize );
   void GetDataset( CmoRecordset* pDataset );
   CmoRecordset *GetDataset() { return mpoRecordset;}
#ifdef MO_SERVER
   CComPtr <_Recordset> &GetADORecordset() { return mspADORecordset;}
   void SetADORecordset( CComPtr <_Recordset> spRS );
#endif
   void *GetADORecordsetArrayElement(int iIndex){return mppADORecordsetArray[iIndex];}
   void *GetObjectArrayElement(int iIndex) { return mppObjectArray[iIndex];}
   void SetDataset( CmoRecordset* pDataset,
                    bool bChangeByteOrder,
                    CmoStringList<CmoString>* pExcludeList = NULL );

   void SetADODataset( void * pRecordset,
                       bool bNotSetParamType,
                       CmoStringList<CmoString>* pExcludeList,
                  void** poADORecordset);

   void ClearBPData();
   UI32 DetermineBPSize( MO_DATATYPE eDataType );
   void ReleaseObjectArray();
#ifdef MO_CLIENT
   void SetFragmentGuid( const TCHAR* pcGuid );
   void SetD2sBinaryStreamObject( MoBinaryStreamReader* pD2sStream );
   MoBinaryStreamReader* GetD2sStreamReader();
#endif

#if !defined( MOCLIENT_IPHONE ) 
#if !defined( USE_MOBILE_OBJECTS )
   void SetADORecordsetArrayElement(IDispatch* piADORecordset, int iIndex);
   void ReleaseADORecordsetArray();
#endif
#endif

   void setAssociatedDeviceId( const CmoString& sAssociatedDeviceId ) { m_sAssociatedDeviceId = sAssociatedDeviceId; }
   CmoString getAssociatedDeviceId() { return m_sAssociatedDeviceId; }

   void setAssociatedRequestId( I32 iAssociatedRequestId ) { m_iAssociatedRequestId = iAssociatedRequestId; }
   I32 getAssociatedRequestId() { return m_iAssociatedRequestId; }

   void setAssociatedConnection( CmoConnection* poAssociatedConnection ) { m_poAssociatedConnection = poAssociatedConnection; }
   CmoConnection* getAssociatedConnection() { return m_poAssociatedConnection; }

   ECStream* getNetStream() { return m_poNetStream; }

private:

   I16            m_sPrecision;
   CmoString      m_strName;
   MO_DATATYPE    m_eDataType;
   MO_PASSTYPE    m_ePassType;
   UI8            *m_pucBPData;
   UI32           m_ulBPValueSize;
   CmoRecordset   *mpoRecordset;
   void           **mppADORecordsetArray;  //hold a array of IDispatch pointer
   void           **mppObjectArray; //the element in this array buffer is stored as raw data,
                                    //it uses new&delete to allocate and free the buffer
   ECMemoryFile   *mpoBinaryStream;

#ifdef MO_CLIENT
   MoBinaryStreamReader *m_pD2sReader;        // For streamed D2s
#endif

#ifdef MOCLIENT_IPHONE
   char           *m_pStreamReadBuffer; // Read buffer for streamed D2s
#else
   void           *m_pStreamReadBuffer; // Read buffer for streamed D2s
#endif

   CmoString m_sAssociatedDeviceId;
   I32 m_iAssociatedRequestId;
   CmoConnection* m_poAssociatedConnection;

   CmoString m_sBinaryCookie;

   ECStream* m_poNetStream;

#if defined( MO_SERVER)
   CComPtr <_Recordset> mspADORecordset;
#endif
   bool           mbFreeRecordset;
   UI8            *m_pucOutData;
   CmoParamList   *m_pOwner;
};// CmoParam

} // namespace mo

#endif// CmoParams_H_INCLUDED
