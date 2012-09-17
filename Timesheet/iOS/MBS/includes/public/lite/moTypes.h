/******************************************************************************
*    Copyright 2001 - 2003 Extended Systems
*    Source File            : moTypes.h
*    Platform Dependencies  :
*    Description            : Header file for misc. type definitions.
*
*    Notes                  :
******************************************************************************/

#ifndef DMTYPES_H_INCLUDED
#define DMTYPES_H_INCLUDED


#include "moOS.h"

typedef unsigned short    UI16;
typedef unsigned long     UI32;

#if defined( MOCLIENT_IPHONE ) || defined( USE_MOBILE_OBJECTS )
   typedef signed long long I64;
   typedef unsigned int UI;
#elif defined WIN32
   #include <wtypes.h>
   typedef __int64        I64;
   typedef unsigned int   UI;
#endif

typedef long              I32;
typedef short             I16;
typedef char              I8;
typedef unsigned char     UI8;
typedef double            R8;
typedef double            R64;
typedef float             R4;
typedef float             R32;

#ifndef __cplusplus
   typedef unsigned char  bool;
   #define true           1
   #define false          0
#endif



#define MAX_CHARS_LONG    14



#endif// DMTYPES_H_INCLUDED

