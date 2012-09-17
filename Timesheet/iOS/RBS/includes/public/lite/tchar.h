/*****************************************************
*    Copyright 2000 iAnywhere, Inc.
*    Source File            :  tchar.h
*    Created By             :  Eric Nelson
*    Date Created           :  4 June 2008
*    Platform Dependencies  :  iPhone Platform (OS)
*    Description            :  This is the TCHAR header file for
*                              iPhone Platform
*
*    Reference Documentation:
******************************************************/
#ifndef _TCHAR_H_
#define _TCHAR_H_

#define _T(x) x

#define LPCTSTR const TCHAR*


#if defined( MOCLIENT_IPHONE)  // do not define for projects other than iMO
#include "ETypes.h"
#include "platmacro.h"
#include "EStringHelper.h"

// CPP_Brett_Unresolved   #ifdef __cplusplus
// CPP_Brett_Unresolved   extern "C" {
// CPP_Brett_Unresolved   #endif

#define _T(x) x

inline size_t _tcslen(const TCHAR *p)
{ return(EStringHelper::EStrlen(p)); }
inline TCHAR *_tcscpy(TCHAR *pnew, const TCHAR *p)
{ return(EStringHelper::EStrcpy(pnew, p)); }
inline TCHAR *_tcsncpy(TCHAR *pnew, const TCHAR *p, size_t n)
{ return(EStringHelper::EStrncpy(pnew, p, n)); }
inline TCHAR *_tcscat(TCHAR *pnew, const TCHAR *p)
{ return(EStringHelper::EStrcat(pnew, p)); };
inline int _tcscmp(const TCHAR *pstr, const TCHAR *rhs)
{ return(EStringHelper::EStrcmp(pstr, rhs)); }
inline int _tcsicmp(const TCHAR *pstr, const TCHAR *rhs)
{ return(EStringHelper::EStricmp(pstr, rhs)); }
inline TCHAR *_tcsstr(const TCHAR *pstr, const TCHAR *s)
{ return(TCHAR*)(EStringHelper::EStrstr((TCHAR*)pstr, (TCHAR*)s)); }
inline TCHAR *_tcschr(const TCHAR *p, unsigned c)
{ return(TCHAR*)(EStringHelper::EStrchr(p, (TCHAR) c)); }
inline int _istspace(TCHAR cnew)
{ return(EStringHelper::EStrisspace(cnew)); }
inline char* _itot(int value, char *string, int radix)
{   sprintf(string, _T("%d"), value);
   return string;
}
#endif



#define _stprintf sprintf
#define _tcstol strtol
#define _tcstoul strtoul
#define _tcstod strtod
#define _tcslwr strlwr
#define _tcsupr strupr
#define _tcsncmp strncmp
#define _tcsrchr strchr
#define _istdigit isdigit
#define _ttoi atoi

#endif

