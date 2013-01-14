/*******************************************************************************
* Source File : mo_bin_protocol.h
* Date Created: 07/28/2000
* Copyright   : 2000 - 2002, Extended Systems, Inc.
* Description : header file for MO protocol
* Notes       : !!!!! IMPORTANT !!!!!!!
*               Do not modify the order of the enumeration items in this file. Add new Items to the end of
*               the enumeration. Otherwise, we break backwards compatibility with older clients.
*
*******************************************************************************/

#ifndef mo_bin_protocol_H_INCLUDED
#define mo_bin_protocol_H_INCLUDED

#include "moCommon.h"
#include "moTypes.h"
#include "moOS.h"
#include "moList.h"

#define RETURN_PARAM_NAME           _T("__mofr")

#define MO_INTERNAL_CALL_OBJECT     _T("MOInternalMO")
#define MO_INTERNAL_CALL_ECHO       _T("Echo")
#define MO_INTERNAL_CALL_SAVE_D2S_STREAM_DATA  _T("SaveD2sData")
#define MO_INTERNAL_CALL_GET_STREAM_DATA   _T("GetStreamData")
#define MO_INTERNAL_CALL_REMOVE_STREAM_DATA   _T("RemoveStreamData")
#define MO_INTERNAL_CALL_CREATE_STREAM_DATA   _T("CreateStreamData")
#define MO_INTERNAL_CLIENT_OBJECT   _T("MOInternal_Obj")
#define MO_INTERNAL_ACK_CLIENT_RESPONSE   _T("MOInternal_ACR")

#define MO_INTERNAL_FIELD_MOCA_PROCESSING _T("MOCA^PROC" )
#define MO_INTERNAL_VALUE_MOCA_PROCESSING 87876
#define MO_INTERNAL_FIELD_MOCA_RETRY_COUNT _T("MIF^MRC" )

#define MO_INTERNAL_FIELD_BINARY_STREAM_COOKIE _T("Cookie" )
#define MO_INTERNAL_FIELD_BINARY_STREAM_START_IDX _T("StartIdx" )
#define MO_INTERNAL_FIELD_BINARY_STREAM_BYTE_COUNT _T("ByteCount" )
#define MO_INTERNAL_FIELD_BINARY_STREAM_RETURN_DATA _T("ReturnData" )

#define MO_INTERNAL_FIELD_D2S_GUID _T("GUID" )
#define MO_INTERNAL_FIELD_D2S_SEQUENCE_NUM _T("SeqNum" )
#define MO_INTERNAL_FIELD_D2S_DATA _T("Data" )

// MO protocol version
// update this value anytime there is a change that would require
// a client to no longer work with the server.
//Currently, both 8 and 9 are supported
#define MO_PROTOCOL_VERSION         8
#define MO_PROTOCOL_VERSION_PARAM_ENCRYPTION 9
#define MO_PROTOCOL_VERSION_PROXY_VERSION 10
#define MO_PROTOCOL_VERSION_ROBIE 11
#define MO_PROTOCOL_VERSION_BINARY_STREAM 12

//the proxy version is used to find out which version of proxy is used by client application
//so that the proper parameter type could be send to application.
//Version list
//0: string array parameter converts to datatable, 5.0
//1: string array parameter converts to string array 5.5
//2: use xml serializer to stream complex data type
#define PROXYVERSION_SUPPORT_STRINGARRAY 1
#define CURRENT_PROXYVERSION 2

// Error param names
#define ERROR_PARAM_ERROR_CODE         _T("EC")
#define ERROR_PARAM_NATIVE_ERROR_CODE  _T("NEC")
#define ERROR_PARAM_MESSAGE            _T("MSG")
#define ERROR_PARAM_DETAIL             _T("DET")
#define ERROR_PARAM_SOURCE             _T("SRC")


// definitions
//******************************************************************
//******************************************************************



// URI used for internal server requests. For use in HTTP header
// to identify the request as it goes through a firewall according to
// SOAP guidelines. Not functionally used by server. For regular invocation
// requests, the URI is the actual object and method name.
//*********************************************************
#define URI_INTERNAL_SERVER           _T("/server:")
#define URI_NONE                      _T("/uri_none:")

#define URI_CONNID                    _T("connid")
#define URI_APPID                     _T("appid")
#define URI_VALCODE                   _T("valcode")
#define URI_NOAUTH                    _T("noauth")
#define CONST_SourceURLName L"SourceURL"
#define CONST_DestURLName   L"DestURL"
#define MO_DEVICE_ID_SUFFIX_DELIM     _T("__" )


#define MO_SIZE_GUID          16


// Trace Log Param Names
#define TRACE_NUM_PARAM                _T("Trac")
#define TRACE_TEXT_PARAM               _T("Data")


// Log Event Command params
#define LOG_EVENT_MSG_PARAM            _T("EventMsg")
#define LOG_EVENT_TYPE_PARAM           _T("EventType")
#define LOG_EVENT_CODE_PARAM           _T("EventCode")
#define LOG_EVENT_USER_NAME_PARAM      _T("UserName")
#define LOG_EVENT_USER_IP_PARAM        _T("UserIP")
#define LOG_EVENT_USER_PORT_PARAM      _T("UserPort")
#define LOG_EVENT_OBJECT_NAME_PARAM    _T("ObjectName")
#define LOG_EVENT_METHOD_NAME_PARAM    _T("MethodName")
#define LOG_EVENT_PARAM_COUNT          8 // must reflect LOG_EVENT_x_PARAM count


// maximums
#define MAX_METHOD_NAME             255
#define MAX_OBJECT_LIFE_ID          255
#define MAX_PARAM_NAME              255
#define MAX_SIZE_DATA               512
#define MAX_OBJECT_NAME             255
#define MAX_PARAM_DATA_SIZE         75000000   //~75MB
#define MAX_USER_ID                 255
#define MAX_PASSWORD                255
#define MAX_ERROR_MSG               65535

#define CHAR_ENCODING_UNICODE       65535
#define DONT_KEEP_ALIVE             65535

//******************************************************************
//******************************************************************



// Structures that define protocols sent between client and server.
//******************************************************************
//******************************************************************

#pragma pack(push, 1)

#define MO_HEADER_FLAG_OBJECTLIFE     0x01
#define MO_HEADER_FLAG_RETRIEVE_ACK   0x02


//MO_HEADER (latest protocol version)
typedef struct MO_HEADER
{
   UI8      ucProtocolVersion;    // the protocol version number
   UI8      ucProxyVersion;   //the client side proxy version
   UI8      ucHeaderFlags;        // MO_HEADER_FLAG_OBJECTLIFE and others
   UI16     usHeaderSize;         // size of this header
   UI16     usCommand;            // command to execute cmdInvoke, etc
   I32      iParameterEncryptionFlag; //indicate which parameter needs decryption
   UI16     usObjectLifeTimeout;  // Time and object should stay alve - DONT_KEEP_ALIVE
                                  // indicates it should be unloaded once finished
   UI16     usCharEncoding;
   UI8      ucParamCount;
   UI8      ucClassNameLength;
   UI8      ucMethodNameLength;
} MO_HEADER;

// this header is then followed by:
//     ucClassNameLength TCHARs containing the class name and
//     ucMethodNameLength TCHARs containing the method name and
//     if MO_HEADER_FLAG_OBJECTLIFE bit is set true, 16 bytes containing the Object life ID guid-aucObjectLifeID[ MO_SIZE_GUID ]
//     INVOKE_PARAMS if the usCommand is cmdInvoke and
//     a request handle to retrieve a request if this is cmdRetrieve
//     a retrieve ack if MO_HEADER_FLAG_RETRIEVE_ACK
//     the actual parameter data

// this info is only included when using cmdInvoke
typedef struct INVOKE_PARAMS {
   I32   lRequestID;              // Handle of the request
   UI16  usStoredResultTimeout;   // Minutes the result of the method call shall be kept
} INVOKE_PARAMS;




// MO_PARAM_HEADER
typedef struct
{
   UI8  ucDataType;                    // 1  data type
   UI8  ucPassType;                    // 1  pass type
   UI8  ucParamNameLength;             // param name size, max = 255 bytes.
} MO_PARAM_HEADER;
// this is followed in the stream by
//    ucParamNameLength TCHARs consiting of the param name
//    and 4 bytes the indicate the value size if the data is string or binary
//    and the data for the param




#define MO_RESP_FLAG_OBJECTLIFE  0x01

typedef struct MO_RESPONSE
{
   UI8      ucProtocolVersion;    // the protocol version number
   UI8      ucResponseFlags;      // MO_RESP_FLAG_OBJECTLIFE and other flags
   UI16     usHeaderSize;         // size of this header
   UI16     usCommand;            // command executed cmdInvoke, cmdError, etc
   UI8      ucParamCount;         // number of params in the data
} MO_RESPONSE;

//     This is followed by
//       if bObjectLifeID is true, 16 bytes containing the Object life ID guid-aucObjectLifeID[ MO_SIZE_GUID ]
//       The the actual parameter data
#pragma pack( pop )


//******************************************************************
//******************************************************************

#endif// mo_protocol_H_INCLUDED
