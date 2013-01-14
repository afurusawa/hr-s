/******************************************************************************
*    Copyright 2001 - 2003 Extended Systems
*    Source File            : moOS.h
*    Platform Dependencies  :
*    Description            : Header file for misc. OS definitions.
*
*    Notes                  :
******************************************************************************/


#ifndef moOS_H_INCLUDED
#define moOS_H_INCLUDED

#define MO_OS_H_INCLUDED

#if defined(WIN32) || defined(_WIN32_WCE)
#include <windows.h>
#elif defined(__SYMBIAN32__)

#elif defined(MOCLIENT_IPHONE) || defined( USE_MOBILE_OBJECTS )
   typedef char TCHAR;
   #include "tchar.h"
#else

#endif


#endif // moOS_H_INCLUDED
