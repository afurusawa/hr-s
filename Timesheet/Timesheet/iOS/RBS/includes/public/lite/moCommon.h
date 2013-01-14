/******************************************************************************
*    Copyright 2001 - 2003 Extended Systems
*    Source File            : moCommon.h
*    Platform Dependencies  :
*    Notes                  :
******************************************************************************/

#ifndef MO_COMMON_H_INCLUDED
#define MO_COMMON_H_INCLUDED


// Enumerations
//******************************************************************
//******************************************************************


// Object type enumeration
typedef enum
{
   otNone = 0,
   otCOM = 1
}MO_OBJECTTYPE;


// Data type enum
// Types could be understood by mo client
typedef enum
{
   dtString       = 0, //not allow with dtArray
   dtByte         = 1, 
   dtBoolean      = 2,
   dtSingle       = 3,
   dtDouble       = 4,
   dtBinary       = 6, //not allow with dtArray, same as dtByte|dtArray
   dtLong         = 7,
   dtShort        = 8,
   dtULong        = 9,
   dtUShort       = 10,
   dtDataset      = 11, //not allow with dtArray
   dtEmpty        = 12, //not allow with dtArray
   dtCurrency     = 13,
   dtDateTime     = 14,
   dtADODataset   = 15, //This type is obsolete, and shall avoid to use, 
                        //it is replaced by dtDataSet 
   dtDecimal      = 18,
   dtInt64        = 19,
   dtUInt64       = 20,
   dtSByte        = 21,
   dtGuid         = 22,
   dtCookieBinary = 23, //not allow with dtArray, same as dtByte|dtArray
   dtS2dStreamBinary = 24, //not allow with dtArray, same as dtByte|dtArray
   dtD2sStreamBinary = 25, //not allow with dtArray, same as dtByte|dtArray
   dtD2sFragmentedBinary = 26,//not allow with dtArray, same as dtByte|dtArray

   // See MAX_MO_DATATYPE that defines the max non-array value. 
   // Change MAX_MO_DATATYPE if new types are added.

   dtArray        = 0x80  //can only apply to fixed lenghth primitive data type
}MO_DATATYPE;

#define MAX_MO_DATATYPE dtD2sFragmentedBinary // Value used to define bounds of supported types.

// pass type enumeration
typedef enum
{
   ptByRef = 0,
   ptByVal = 1,
   ptReturn = 2,
   ptObjectName = 3,
   ptMethodName = 4,
   ptRequestID = 5
} MO_PASSTYPE;



typedef enum 
{
   sdRequestStream,
   sdResponseStream
} MO_STREAM_DIRECTION;



// commands
#define MO_CMD_INVOKE_WAIT            101
#define MO_CMD_ERROR                  108
#define MO_CMD_TRACE_LOG              120
#define MO_CMD_AWAIT_REQUEST          134
#define MO_CMD_ASYNC_INVOKE           135

#define MO_DATA_TYPE_STRING           0
#define MO_DATA_TYPE_BOOLEAN          2
#define MO_DATA_TYPE_SINGLE           3
#define MO_DATA_TYPE_DOUBLE           4
#define MO_DATA_TYPE_ARRAY            5
#define MO_DATA_TYPE_BINARY           6
#define MO_DATA_TYPE_LONG             7
#define MO_DATA_TYPE_SHORT            8
#define MO_DATA_TYPE_ULONG            9
#define MO_DATA_TYPE_USHORT           10
#define MO_DATA_TYPE_DATASET          11
#define MO_DATA_TYPE_EMPTY            12
#define MO_DATA_TYPE_INT64            13
#define MO_DATA_TYPE_DATETIME         14



// since these enums have specific values, order does not matter.
typedef enum
{
   cmdNone              = -1,
   cmdInvokeWait        = MO_CMD_INVOKE_WAIT,
   cmdError             = MO_CMD_ERROR,
   cmdTraceLog          = MO_CMD_TRACE_LOG,
   cmdAwaitRequest      = MO_CMD_AWAIT_REQUEST,
   cmdAsyncInvoke       = MO_CMD_ASYNC_INVOKE,
}MO_COMMAND;

#ifdef WIN32
#define SYNCHRONOUS_MOCA_CALLBACK_NAME    _T(".")
#define SYNCHRONOUS_MOCA_GUID_PARAM       _T("_GUID_")   
#define SYNCHRONOUS_MOCA_SLEEP_INTERVAL   1000           // polling sleep milliseconds
#endif
#endif// MO_COMMON_H_INCLUDED



