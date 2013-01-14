/******************************************************************************
*    Copyright 2001 - 2003 Extended Systems
*    Source File            : moUtils.h
*    Platform Dependencies  :
*    Description            : Header file for misc. util functions.
*
*    Notes                  :
******************************************************************************/

#ifndef mo_utils_H_INCLUDED
#define mo_utils_H_INCLUDED


#include "moString.h"
#include "mo_bin_protocol.h"

using namespace mo;


#define MAX_LONG_VALUE     2147483647


UI32 GetCRC( UI8 *pucData,
             UI32 ulDataLength );

void CombinedLCG( I32* plS1,
                  I32* plS2,
                  double* pdResult );

I32 moGetRandNum();

void MsgDlg( const TCHAR* pcTitle,
             const TCHAR* pcMessage );

void MoURLEncode( const TCHAR *pszURLIn, TCHAR **ppszURLOut );

void MOAssertFunc( const TCHAR* pcMsg,
                   const TCHAR* pcMsg2,
                   const TCHAR* pcFileName,
                   int lLineNumber );

void MOAssertFunc( TCHAR* pcMsg,
                   TCHAR* pcFileName,
                   int lLineNumber );


#ifdef ESI_PALM
   #include "moOS.h"
   #include "moTypes.h"

UI32 GetAvailableHeap( UI32* pMaxChunk );

UI32 GetCreatorID();

void Sleep( UI32 ulMSec );

#endif //ESI_PALM



#ifdef _WIN32

#include <winbase.h>

bool Launch( const TCHAR* pcFileName,
             const TCHAR* pcCmdLine );


class CmoApp
{
public:
   CmoString ExeName();
};// CmoApp


class CmoMath
{
public:
   static I32 Round( R8 dValue );
   static I32 Trunc( R8 dValue );
};// CmoMath

#endif


void SetBit( I8    *pcBits,
             I32   lBitNum,
             bool  bSetBit );

bool IsBitSet( I8    *pcBits,
               I32   lBitNum );

void InitTempFile();
void GetTempFile( CmoString *pcsTempFileName );
const TCHAR *GetTempFolder();
const TCHAR *GetDataFolder();
const TCHAR *GetMocaQFolder();

void CreateDirectoryStructure( const TCHAR *pcDirectory );

inline UI16 GetCharacterEncoding()
{
#if defined( MOCLIENT_IPHONE ) || defined( USE_MOBILE_OBJECTS )
   return 65001; // the value for CP_UTF8
#else
   return CHAR_ENCODING_UNICODE;
#endif
}

#endif // mo_utils_H_INCLUDED
