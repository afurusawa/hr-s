/******************************************************************************
*    Copyright 2001 - 2002 Extended Systems
*    Source File            : moMemUtils.h
*    Platform Dependencies  :
*    Description            : Header file for misc. memory utilities.
*
*    Notes                  :
******************************************************************************/

#ifndef moMemUtils_H_INCLUDED
#define moMemUtils_H_INCLUDED

#if !defined( XCMO_SERVER )
//#define XCMO_DEBUG
#endif

#include "moOS.h"
#include "moTypes.h"
#include "moError.h"
#include "moErrCodes.h"
#include "moUtils.h"

// macro for debuggin memory leaks
#define SOURCE_LOCATION             _T(__FILE__), __LINE__

#ifdef ESI_PALM
   #include <PalmOS.h>
   #include <DataMgr.h>

   // Mask used to determine if the pointer points to memory
   // in dynamic or storage heap.
   #define XCMO_STORAGE_HEAP_MASK               0x80000000
#else
#if defined WIN32_WCE || defined _WIN32_WCE || defined WIN32
   #include <windows.h>
#endif
   #include <string.h>
   typedef void* MemHandle;
#endif


TCHAR *moNewString( UI32 ulSize );
void moMemTraceStart();
void moMemTraceStop();
void moMemTraceShowResults();

bool VerifyPtr( void* pValue,
                const TCHAR* pcFileName,
                long lLineNo );


//#define OBJECT_TRACKER
#if defined( OBJECT_TRACKER )

enum OBJECT_TYPE
{
   CMORECORDSET = 0,
   CMOCLIENT,
   CMOCONNECTION,
   CMOREQUESTOPTIONS,
   CMOFIELDS,
   CMOFIELD,
   CMOINDEXES,
   CMOPARAMLIST,
   CMOPARAM,
   CMOSTRING,
   CMOERROR,
   CMODATETIME,
   CMOBINARY,
   CMOLIST,
   CMOLISTITEM,
   CMOLISTHEAD,
   CMOSTREAMWRAPPER,
   CMOSYNCRECORDSET,
   CMODATALIST,
   CMODATALISTENTRY,
   CMODATACHUNK,
   CMOSIMPLEDATACHUNK,
   CMOSIMPLEDATALIST,
   CMOBYTELIST,

   // add all new types before this one
   CMONUMOBJECTS
};

void OBJECT_TRACK_START();
void OBJECT_TRACK_END();
void OBJECT_INCREMENT( OBJECT_TYPE enObjectType );
void OBJECT_DECREMENT( OBJECT_TYPE enObjectType );

#else

#define OBJECT_INCREMENT( x )
#define OBJECT_DECREMENT( x )
#define OBJECT_TRACK_START()
#define OBJECT_TRACK_END()

#endif

#define MO_CHECK_ALLOC( ptr )                                              \
   if ( ptr == NULL )                                                      \
      {                                                                    \
      MOAssertFunc( _T( "ptr != NULL" ), NULL, _T(__FILE__),__LINE__ );    \
      SetLastErr( MO_ERR_MEM_ALLOC,                                        \
                  SOURCE_LOCATION );                                       \
      }                                                                    \



#endif // moMemUtils_H_INCLUDED
