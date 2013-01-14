/******************************************************************************
*    Copyright 2001 - 2003 Extended Systems
*    Source File            : moDateTime.h
*    Platform Dependencies  :
*    Description            : Header file for CmoDateTime class.
*
*    Notes                  :
******************************************************************************/


#ifndef CmoDateTime_H_INCLUDED
#define CmoDateTime_H_INCLUDED

#include "moTypes.h"
#include "moString.h"
#ifdef ESI_PALM
#elif defined ( _WIN32_WCE )
   #include <oleauto.h>
#elif defined ( _WIN32 )
#endif

using namespace mo;


typedef enum MOTimeFormat
{
   tf12Hour,
   tfMilitary
}MOTimeFormat;

// YYMDhms
#define DATETIME_COMPRESSED_LEN  7
#define DATETIME_ZERO            '!'   /* char 48 0x30 */
#define DATETIME_RADIX           93    /* 93 characters are used */

#ifdef ESI_PALM
   #include <datetime.h>
#endif



class CmoDateTime
{
public:
   CmoDateTime();
   ~CmoDateTime();

   CmoDateTime( const TCHAR* pcDateTime );

#ifdef _WIN32
   CmoDateTime( DATE* pdtResult );
#endif

   static CmoDateTime Now();

   void SetDateTime( const TCHAR* pcDateTime );


   void SetDateTime( I16 sYear,     // 1 - 65534
                     I8 cMonth,     // 1 - 12
                     I8 cDay,       // 1 - 31
                     I8 cHour,      // 0 - 23
                     I8 cMin,       // 0 - 59
                     I8 cSec );     // 0 - 59


   void GetDateTime( I16* psYear,     // 1 - 65534
                     I8* pcMonth,     // 1 - 12
                     I8* pcDay,       // 1 - 31
                     I8* pcHour,      // 0 - 23
                     I8* pcMin,       // 0 - 59
                     I8* pcSec );     // 0 - 59

   void AsString( CmoString* pstrResult,
                  MOTimeFormat eTimeFormat = tf12Hour );

   void SetToNow();

#ifdef ESI_PALM
   void GetNative( DateTimeType* pstResult );

   void GetNativeDate( DateType* pstResult );

   void GetNativeTime( TimeType* pstResult );


   void SetNative( DateTimeType* pstValue );

   void SetNativeDate( DateType* pstValue );

   void SetNativeTime( TimeType* pstValue );

#elif _WIN32
   void GetVariant( DATE* pdtResult );

   void SetVariant( DATE* pdtValue );

   void getVariant( DATE* pdtResult ){ GetVariant( pdtResult );}

   void setVariant( DATE* pdtValue ){ SetVariant( pdtValue );}
#endif



   // Operators
   bool operator!= ( CmoDateTime& RH );

   bool operator== ( CmoDateTime& RH );

   bool operator> ( CmoDateTime& RH );

   bool operator< ( CmoDateTime& RH );

   I64 GetRaw(){ return m_cyDateTime;}

   void SetRaw( I64 cyValue ){ m_cyDateTime = cyValue;}

   void AsCompressed( TCHAR *pcValue );
   void SetCompressed( const TCHAR *pcValue );

private:
   I64 m_cyDateTime;
};// CmoDateTime




#endif// CmoDateTime_H_INCLUDED
