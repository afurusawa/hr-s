/******************************************************************************
*    Copyright 2001 - 2003 Extended Systems
*    Source File            : moString.h
*    Platform Dependencies  :
*    Description            : Header file for string classes.
*
*    Notes                  :
******************************************************************************/
#ifndef CmoString_H_INCLUDED
#define CmoString_H_INCLUDED


#include "moOS.h"
#include "moTypes.h"

#if defined( MOCLIENT_IPHONE ) || defined( USE_MOBILE_OBJECTS )
#include "tchar.h"
#endif


namespace mo
{
   class CmoString;
}// namespace

#ifdef ESI_PALM
   #include <StringMgr.h>
   #include <SystemMgr.h>
   #include <FeatureMgr.h>
   #include <TextMgr.h>

// macro to satisfy Win32 TEXT macro for auto conversion to L"string".
// on Palm, no unicode so macro does nothing.
   #define TEXT( string )  string

#elif _WIN32
   #include <string.h>
   #include <stdio.h>
   #include <wtypes.h>
   #include <tchar.h>
#endif


namespace mo
{

   class CmoString
   {
   public:
      ~CmoString();

      // Constructors
      //*************************************
      CmoString();
      CmoString( bool bValue );
      CmoString( const TCHAR* pcValue );
      CmoString( double dValue, I16 sPrecision );
      CmoString( I16 sValue );
      CmoString( TCHAR cValue );
      CmoString( I32 lValue );
      CmoString( UI32 ulValue );
      CmoString( const CmoString& strValue );
      //*************************************


      // Data pointer access.
      //*************************************
      const TCHAR* c_str() const { return m_pcData;}
      const TCHAR* getData() const { return m_pcData;}
      void LoadAnsi( char* pcAnsiString );
      //*************************************

      // Methods that locate a sub string
      //*************************************
      CmoString StrBeforeToken( const TCHAR* pcToken );
      CmoString StrAfterToken( const TCHAR* pcToken );
      CmoString StrBeforeLastToken( const TCHAR* pcToken );
      CmoString StrAfterLastToken( const TCHAR* pcToken );
      CmoString SubStr( I32 lBegin, I32 lCount );

      I32 Find( const TCHAR* pcValue, I32 lStartPos = 0 );
      I32 Find( const TCHAR cValue, I32 lStartPos = 0 );
      I32 RFind( const TCHAR* pcValue, I32 lStartPos );

      //*************************************

      // Conversion routines
      //*************************************

      // Not needed on Palm
      #ifdef _WIN32
      void LoadAsBase64( const UI8* pucBuf,
                         UI32 ulBufSize );

      UI8* Base64ToBinary( UI32& ulBufSize );

      void LoadAsHex( const UI8* pucBuf,
                      UI32 ulBufSize );

      #endif

      UI32 AsULong() const;
      I32 AsLong() const;
      R64 AsDouble() const;
      CmoString AsUpper() const;
      CmoString AsLower() const;
      UI16 AsUShort() const;
      I16 AsShort() const;
      bool AsBool() const;
      //*************************************



      // String manipulation routines
      //*************************************
      void Format( const TCHAR* pcFormat, I32 lMaxChars, ... );

      CmoString& Trim();
      CmoString& LTrim();
      CmoString& RTrim();
      CmoString& ConvUpper();
      CmoString& ConvLower();
      CmoString& EatWS( I32 lBegin, I32& lRemovedCount );
      CmoString& ReplaceSubStr( const TCHAR* pcNewSub, const TCHAR* pcOldSub );
      CmoString& ScrubXMLEscape();
      CmoString& Erase( I32 lStartPos, I32 lCount );
      //*************************************


      // Operators
      //*************************************
      CmoString operator +( const CmoString& strValue );
      CmoString operator +( const TCHAR* pcValue );
      CmoString operator +( const I16 pusValue );

      CmoString& operator +=( const CmoString& strValue );
      CmoString& operator +=( const TCHAR* pcValue );

      void operator =( const TCHAR* pcValue );
      void operator =( UI32 ulValue );
      void operator =( I32 lValue );
      void operator =( const CmoString& strValue );
      void operator =( TCHAR cValue );

      bool operator ==( const TCHAR* pcValue );
      bool operator ==( const CmoString& strValue );

      bool operator !=( const TCHAR* pcValue );
      bool operator !=( const CmoString& strValue );


      TCHAR operator []( I32 lPos ) const;
//      TCHAR operator ()( I32 lPos );
      //*************************************


      // Misc
      //*************************************
      bool IsEmpty();
      void Empty();
      I32 Length() const;

      void UpdateSize();

      #ifdef _WIN32
      void LoadLastWin32Err();
      void LoadWin32Err( HRESULT hr );

      static TCHAR* LoadLastWin32Err(TCHAR*& pszError );
      static TCHAR* LoadWin32Err( HRESULT hr, TCHAR*& pszError );
      #endif

      CmoString LoadSourceLocation( const TCHAR* pcFileName,
                                    I32 lLineNo );
      I32 getBufferSize();
      //*************************************


      // File name/path utilities
      //*************************************
      CmoString ExtractFileName();
      CmoString ExtractFilePath();
      CmoString ExtractFileDir();
      CmoString& ForceBackSlash();
      //*************************************
   private:
      TCHAR* m_pcData;

      void setData( TCHAR* m_pcData );
      bool InBounds( I32 lPos );
      void Init();
   };// CmoString


//}// namespace mo

}// namespace mo




#endif //CmoString_H_INCLUDED
