/******************************************************************************
*    Copyright 2001 - 2003 Extended Systems
*    Source File            : CmoError.h
*    Platform Dependencies  :
*    Notes                  :
******************************************************************************/

#ifndef CmoError_H_INCLUDED
#define CmoError_H_INCLUDED

class CmoError;

#include "moOS.h"
#include "moString.h"
#include "moTypes.h"

using namespace mo;

typedef CmoError CmoErr;

#define SOURCE_LOCATION             _T(__FILE__), __LINE__

#define NO_ERROR_LINE_NUM        -1

#define OBJECT_BEGIN_TAG        _T("<object>")
#define OBJECT_END_TAG          _T("</object>")
#define METHOD_BEGIN_TAG        _T("<method>")
#define METHOD_END_TAG          _T("</method>")
#define DESC_BEGIN_TAG          _T("<desc>")
#define DESC_END_TAG            _T("</desc>")

CmoErr* GetLastErr();
TCHAR* GetErrMsg( I32 lErr );
const TCHAR* GetDefaultDetail( I32 lErrorCode );

void SetLastErr( I32          lm_ErrorCode,
                 const TCHAR* pcFileName,
                 I32          lLineNo,
                 const TCHAR* pcDetail = 0,
                 I32          lNativem_ErrorCode = 0,
                 bool         bThrowError = true,
                 const TCHAR* pcMessage= 0);

#if defined( MO_SERVER )
void CheckCOMErr( HRESULT hr,
                  TCHAR* pcFile,
                  I32 lLineNo,
                  I32 lErrorCode,
                  TCHAR *pcObjectName,
                  TCHAR *pcMethodName=0,
                  IUnknown* pThis=0);

#include "\Pioneer\Platform\WIN32\ETrace.h"
void SetLastErrTrace( TraceLevel level, 
                   I32          lm_ErrorCode,
                   const TCHAR* pcFileName,
                   I32          lLineNo,
                   const TCHAR* pcDetail = 0,
                   I32          lNativem_ErrorCode = 0,
                   bool         bThrowError = true,
                   const TCHAR* pcMessage= 0);
#endif /* MO_SERVER */

class CmoError
{
public:
   CmoError();
   CmoError(CmoError& rhs);
   CmoError(long nCode);
   ~CmoError();

   void Clear();
   long Init(bool bNoAlloc = false);
   bool Display( const TCHAR* pcTitle = 0 );

   void setSource( const TCHAR* pcFileName,
                   long lLineNo );
   void Raise( bool bShowLastOSErr = false );
   void PopulateMessage( bool bShowLastOSErr );

   void GetString( CmoString* pstrResult );
   TCHAR* GetString( TCHAR*& pstrResult );
   TCHAR* SetString(TCHAR*& szDest, const TCHAR* szSrc);
   TCHAR* MakeDisplayString(TCHAR*& pszDisplay, bool bIsForDisplay = false);

   CmoError& operator =( CmoError& RHValue );
   void SetErrorCode(long nCode){m_ErrorCode = nCode;}
   void SetNativeErrorCode(long nCode){m_NativeErrorCode = nCode;}
   long ErrorCode(){return m_ErrorCode;}
   long NativeErrorCode(){return m_NativeErrorCode;}

   TCHAR* SetSource(const TCHAR* szVal){return SetString(m_szSource, szVal);}
   TCHAR* SetMessage(const TCHAR* szVal){return SetString(m_szMessage, szVal);}
   TCHAR* SetDetail(const TCHAR* szVal){return SetString(m_szDetail, szVal);}
   TCHAR* SetDetail(long lVal);
   TCHAR* Message(){return m_szMessage;}
   TCHAR* Source(){return m_szSource;}
   TCHAR* Detail(){return m_szDetail;}
#if defined ( MO_SERVER)
   void SetTraceAndNotLog(){ m_bTraceOnly = true; }
   void ClearTrace(){ m_bTraceOnly = false; }
   void SetTraceLevel( TraceLevel level ){ m_eTraceLevel = level; }
   bool m_bTraceOnly;
   TraceLevel m_eTraceLevel;
#endif

   TCHAR* m_szMessage;
   TCHAR* m_szSource;
   TCHAR* m_szDetail;
   long m_ErrorCode;
   long m_NativeErrorCode;
};


#endif// CmoError_H_INCLUDED
