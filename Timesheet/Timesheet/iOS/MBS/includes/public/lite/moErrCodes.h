/******************************************************************************
*    Copyright 2001 - 2003 Extended Systems
*    Source File            : moErrCodes.h
*    Platform Dependencies  :
*    Description            : Error values
*    Notes                  :
******************************************************************************/




#ifndef moErrCodes_H_INCLUDED
#define moErrCodes_H_INCLUDED

// HR result value to be returned by any server side COM object that wishes
// to return an error from the COM call that is not logged but is sent to the clent.
// The value was simply made up.
#define MO_HR_RESULT_DONT_LOG -112234


// Global error code listing for all utility classes.
//******************************************************************

#define MO_ERR_SUCCESS                                      0

// class CmoFileStream
#define CmoFileStream_ERR_ALREADY_OPEN                      1
#define CmoFileStream_ERR_FILE_OPEN                         2
#define CmoFileStream_ERR_FILE_STREAM                       3
#define CmoFileStream_ERR_FILE_SEEK                         4
#define CmoFileStream_ERR_NOT_OPEN                          5
#define CmoFileStream_ERR_FILE_CLEAR                        6
#define CmoFileStream_ERR_FILENAME_NOT_SET                  7
#define CmoFileStream_ERR_FORCE_DIRECTORIES                 8
#define CmoFileStream_ERR_REMOVE_DIRECTORY                  9

// Generic File errors
#define MO_ERR_FILE_OPEN_FAILED                             100
#define MO_ERR_FILE_CLOSE_FAILED                            101
#define MO_ERR_FILE_NOT_FOUND                               102



// Communication/traveler library errors
#define COMMERR_CONN_MGR_INIT_ERROR                         500
#define COMMERR_QUERY_CONNMETHOD_ERROR                      501
#define COMMERR_CONNMETHOD_NOT_FOUND                        502
#define COMMERR_CONNECTION_OPEN_ERROR                       503
#define COMMERR_INIT_CRYPTOLIB_ERROR                        504
#define COMMERR_CRYPTOFUNCTIONS_NOT_AVAILABLE               505
#define COMMERR_TRAVELER_LIB_INIT_ERROR                     506
#define COMMERR_UNABLE_TO_SET_COMMS_CONTEXT                 507
#define COMMERR_UNABLE_TO_SET_USER_ID                       508
#define COMMERR_UNABLE_TO_SET_PASSWORD                      509
#define COMMERR_UNABLE_TO_SET_DEVICE_ID                     510
#define COMMERR_UNABLE_TO_SET_DEVICE_TYPE                   511
#define COMMERR_UNABLE_TO_SET_COMPRESSION_LEVEL             512
#define COMMERR_UNABLE_TO_SET_ENCRYPTION_FLAG               513
#define COMMERR_START_TRAVELER_SESSION_ERROR                514
#define COMMERR_SERVER_KEYS_ERROR                           515
#define COMMERR_SEND_REQUEST_FAILED                         516
#define COMMERR_RESPONSE_READ_ERROR                         517
#define COMMERR_NO_PENDING_REQUEST                          518
#define COMMERR_UNABLE_TO_SET_COMPANY_ID                    519
#define COMMERR_UNABLE_TO_SET_APP_ID                        520
#define COMMERR_UNABLE_TO_SET_CONNECTION_ID                 521
#define COMMERR_UNABLE_TO_SET_VAL_CODE                      522
#define COMMERR_UNABLE_TO_SET_ENABLE_DEVICE_VAL_FLAG        523
#define COMMERR_UNABLE_TO_SET_PUBLICKEY                     524
#define COMMERR_UNABLE_TO_SET_TIMEOUT                       525
#define COMMERR_UNABLE_TO_SET_TM_URL                        526
#define COMMERR_UNABLE_TO_SET_DEVICE_ID_ARCHIVED            527
#define COMMERR_UNABLE_TO_SET_SERVER_VERIFICATION_KEY       528

// Traveler protocol errors
#define COMMERR_TMERR_SEQ_FAIL                              550
#define COMMERR_TMERR_AUTH_FAIL                             551
#define COMMERR_TMERR_SESSION_FAIL                          552
#define COMMERR_TMERR_BAD_PACKET                            553
#define COMMERR_TMERR_LICENSE_FAIL                          554
#define COMMERR_TMERR_NO_OWNER_CHANGE                       555
#define COMMERR_TMERR_MISSING_DEVICE_TYPE                   556
#define COMMERR_TMERR_MISSING_DEVICE_ID                     557
#define COMMERR_TMERR_NO_SERVER                             558
#define COMMERR_TMERR_BAD_HEADER_LEN                        559
#define COMMERR_TMERR_BAD_PUBLIC_HEADER                     560
#define COMMERR_TMERR_UNKNOWN_CMD_ID                        561
#define COMMERR_TMERR_INCOMPLETE_DEST_URL                   562
#define COMMERR_TMERR_BAD_CRED                              563
#define COMMERR_TMERR_GEN_MEM_FAIL                          564
#define COMMERR_TMERR_BAD_PUBLIC_KEY                        565
#define COMMERR_TMERR_BAD_VERSION                           566
#define COMMERR_TMERR_BAD_ENCRYPTED_HEADER_LEN              567
#define COMMERR_TMERR_BAD_SYM_KEY                           568
#define COMMERR_TMERR_INVALID_DEST                          569
#define COMMERR_TMERR_BAD_DEV_ID                            570
#define COMMERR_TMERR_SESS_TIMEOUT                          571
#define COMMERR_TMERR_AUTH_TIMEOUT                          572
#define COMMERR_TMERR_SCRIPT_START_SESSION_ABORT            573
#define COMMERR_TMERR_GENERAL_SERVER                        574
#define COMMERR_TMERR_SCRIPT_OWNER_CHANGE_ABORT             575
#define COMMERR_TMERR_SERVER_BUSY                           576
#define COMMERR_TMERR_SERVER_UNDER_MAINTENANCE              577
#define COMMERR_TMERR_DEVICEVAL_WRONG_USER                  578
#define COMMERR_TMERR_DEVICEVAL_WRONG_DEVICE                579
#define COMMERR_TMERR_DEVICEVAL_INVALID_VAL_CODE            580
#define COMMERR_TMERR_DEVICEVAL_VALCODE_CHK_FAILED          581
#define COMMERR_TMERR_CANT_READ_WITHOUT_SEND                582
#define COMMERR_TMERR_KILL_PILL                             583
#define COMMERR_TMERR_SERVER_VERIFICATION_FAILED            584

#define COMMERR_LAST_COM_ERROR                              599

// CmoThread
#define CmoThread_ERR_CREATING_THREAD                       600

// CmoCOMBroker
#define CmoCOMBroker_ERR_GETIDSOFNAMES                      1000
#define CmoCOMBroker_ERR_COCREATEINSTANCE                   1001
#define CmoCOMBroker_ERR_COM_EXCEPTION                      1002
#define CmoCOMBroker_ERR_PARAM_NOT_FOUND                    1003
#define CmoCOMBroker_ERR_TYPE_MISMATCH                      1004
#define CmoCOMBroker_ERR_UNKNOWN_DATA_TYPE                  1005
#define CmoCOMBroker_ERR_CLSID                              1006
#define CmoCOMBroker_ERR_INVOKE                             1007
#define CmoCOMBroker_ERR_INVALID_FIELD_TYPE                 1008
#define CmoCOMBroker_ERR_INVALID_RETURN_TYPE                1009
#define CmoCOMBroker_ERR_DB_DATETIME_TO_STR                 1010
#define CmoCOMBroker_ERR_DB_INVALID_DATETIME                1011
#define CmoCOMBroker_ERR_INVALID_OUT_ARG                    1012
#define CmoCOMBroker_ERR_FIELD_SIZE_0                       1013
#define CmoCOMBroker_ERR_DECIMAL_CONVERT                    1014

//CmoSOAPBroker
#define CmoSOAPBroker_ERR_CREATE_METHODINVOKER              1050
#define CmoSOAPBroker_ERR_CREATE_SERVEROBJECT               1051
#define CmoSOAPBroker_ERR_CREATE_PARAMETERCONTAINER         1052
#define CmoSOAPBroker_ERR_INVOKE                            1053
#define CmoSOAPBroker_ERR_SERVER_ASSEMBLY_MISSING           1054
#define CmoSOAPBroker_ERR_CHECKING_INIT_METHOD              1055


// CmoObjectBroker
#define CmoObjectBroker_ERR_COINITIALIZE                    1100
#define CmoObjectBroker_ERR_OBJ_NOT_REGISTERED              1101
#define CmoObjectBroker_ERR_COM_EXCEPTION                   1102
#define CmoObjectBroker_ERR_DENIED_GROUP_ACCESS             1103
#define CmoObjectBroker_ERR_DENIED_ANONYMOUS_USER           1104


// CmoRequestBroker
#define CmoRequestBroker_ERR_DUPLICATE_OBJLIFE              1200
#define CmoRequestBroker_ERR_INVALID_CMD                    1202
#define CmoRequestBroker_ERR_AUTHENT                        1203
#define CmoRequestBroker_ERR_UNKNOWN_EXCEPTION              1204
#define CmoRequestBroker_ERR_REMOTE_ADMIN_DISABLED          1205
#define CmoRequestBroker_ERR_SECURITY_DISABLED              1206
#define CmoRequestBroker_ERR_UNKNOWN_DATA_TYPE              1207
#define CmoRequestBroker_ERR_ADMIN_AUTHENT                  1208
#define CmoRequestBroker_ERR_OBJECT_NAME_MISMATCH           1209
#define CmoRequestBroker_ERR_OBJECT_LIFE_NOT_FOUND          1210
#define CmoRequestBroker_ERR_GUID_CREATE_FAILURE            1211
#define CmoRequestBroker_ERR_LICENSE_EXPIRED                1212
#define CmoRequestBroker_ERR_WAITTIMEOUT                    1213
#define CmoRequestBroker_ERR_INVALID_LOG_EVENT_PARAMS       1214
#define CmoRequestBroker_ERR_INVALID_VERIFY_GROUP_PARAMS    1215
#define CmoRequestBroker_ERR_OBJECT_OFFLINE_FOR_UPDATE      1216
#define CmoRequestBroker_ERR_ENCRYPT_NOT_STRING_TYPE        1217

// CmoParam
#define PARAM_ERR_PARAM_DATA_SIZE                           1300
#define PARAM_ERR_MEM_ALLOC                                 1301
#define PARAM_ERR_WRONG_TYPE                                1302
#define PARAM_ERR_UNKNOWN_PROTOCOL                          1303
#define PARAM_ERR_PARAM_NOT_FOUND                           1304
#define PARAM_ERR_NULL_ARG                                  1305
#define PARAM_ERR_UNKNOWN_DATA_TYPE                         1306
#define PARAM_ERR_DECRYPTION                                1307
#define PARAM_ERR_STREAM_CREATE_FAILURE                     1308
#define PARAM_ERR_STREAM_OPEN_FAILURE                       1309

// CmoList
#define CmoList_ERR_MEM_ALLOC                               1400


#if defined( CIE )
// CmoCOMTypeLib
#define CmoCOMTypeLib_ERR_LOADING_TYPELIB                   1500
#define CmoCOMTypeLib_ERR_INFOCOUNT                         1501
#define CmoCOMTypeLib_ERR_GETTYPEINFO                       1502
#define CmoCOMTypeLib_ERR_GETTYPEATTR                       1503
#define CmoCOMTypeLib_ERR_GETDOC                            1504
#define CmoCOMTypeLib_ERR_GETFUNCDESC                       1505
#define CmoCOMTypeLib_ERR_GETNAMES                          1506
#define CmoCOMTypeLib_ERR_GET_LIB_NAME                      1507


#endif



// general mobile objects errors
#define MO_SUCCESS                                          0
#define MO_ERR_MEM_ALLOC                                    1600
#define MO_ERR_UNKNOWN_EXCEPTION                            1603
#define MO_ERR_INVALID_PARAMS                               1609

// MO_CLIENT
#define MO_CLIENT_ERR_METHOD_NAME_TOO_LONG                  1708
#define MO_CLIENT_ERR_SERVER_RESP_UNKNOWN                   1710
#define MO_CLIENT_ERR_UNKNOWN_DATA_TYPE                     1713
#define MO_CLIENT_ERR_INVALID_CONNECTION_OBJECT             1714
#define MO_CLIENT_ERR_EXPECTED_CLQDBINARY                   1715
#define MO_CLIENT_ERR_EXPECTED_CLQDDATASET                  1716
#define MO_CLIENT_ERR_GETTING_SERV_PUB_KEY                  1717
#define MO_CLIENT_ERR_SERVER_SECURITY_OFF                   1718
#define MO_CLIENT_ERR_GETTING_CLIENT_KEYS                   1719
#define MO_CLIENT_ERR_MAX_CHALLENGE                         1720
#define MO_CLIENT_ERR_CHECKSUM_FAILURE                      1721
#define MO_CLIENT_ERR_NO_ACTIVE_PROFILE                     1722
#define MO_CLIENT_ERR_INVALID_SEQ_ID                        1723
#define MO_CLIENT_ERR_EXPECTED_PARAM                        1724
#define MO_CLIENT_ERR_PROFILE_RECORD_LOCK_FAILURE           1725
#define MO_CLIENT_ERR_UNKNOWN_CHAR_ENCODING                 1726
#define MO_CLIENT_ERR_BINARY_STREAM_FAILURE                 1727
#define MO_CLIENT_ERR_BINARY_STREAM_NOT_COMPLETE            1728
#define MO_CLIENT_FAIL_READ_DEVICE_ID                       1729
#define MO_CLIENT_INVALID_DEVICE_ID                         1730
#define MO_CLIENT_INVALID_DEVICE_ID_SIZE                    1731
#define MO_CLIENT_ERR_STORING_DEVICE_ID_ARCHIVED            1732
#define MO_CLIENT_ERR_INVALID_STREAM                        1733

#if defined( MO_SERVER )

// Events (not errors)
#define MO_EVENT_SERVER_STARTED                             1800
#define MO_EVENT_SERVER_STOPPED                             1801
#define MO_EVENT_METHOD                                     1802
#define MO_EVENT_CONNECT                                    1803
#define MO_EVENT_AUTHENT                                    1804
#define MO_EVENT_DEBUG                                      1805
#define MO_EVENT_STOPSERVER                                 1806
#define MO_EVENT_GET_CONFIG_DATA                            1807
#define MO_EVENT_UPDATE_CONFIG_DATA                         1808
#define MO_EVENT_DISCONNECT                                 1809
#define MO_EVENT_GET_COM_REG_LIST                           1810
#define MO_EVENT_SET_COM_REG_LIST                           1811
#define MO_EVENT_GET_EVENT_LOG                              1812
#define MO_EVENT_EMPTY_EVENT_LOG                            1813
#define MO_EVENT_GET_VERSION                                1814
#define MO_EVENT_GET_STATS                                  1815
#define MO_TRACE_LOG                                        1816
#define MO_RELEASED_OBJECT                                  1817
#define MO_EVENT_CONNECTION_REMOVED                         1818
#define MO_EVENT_RETRIEVE                                   1819
#define MO_EVENT_RETRIEVE_ACK                               1820
#define MO_EVENT_CONNECTION_FAILURE                         1821
#define MO_EVENT_OBJECT_UPDATE                              1822



// CmoReqResp
#define CmoReqResp_ERR_UNKNOWN_COMMAND_TYPE                 1900
#define CmoReqResp_ERR_UNKNOWN_PROTOCOL_VERSION             1902
#define CmoReqResp_ERR_SECURITY_MISMATCH                    1903
#define CmoReqResp_ERR_CHECKSUM_FAILURE                     1904
#define CmoReqResp_ERR_AUTHENT                              1905
#define CmoReqResp_ERR_DEVICE_NOT_REGISTERED                1906
#define CmoReqResp_ERR_INVALID_SECURITY_OPTION              1907
#define CmoReqResp_ERR_INVALID_SERVER_KEY_REQUEST           1908
#define CmoReqResp_ERR_INVALID_ADMIN_REQUEST                1909
#define CmoReqResp_ERR_INVALID_RESPONSE_SESSION_KEY         1910
#define CmoReqResp_ERR_INVALID_SESSION_KEY                  1911
#define CmoReqResp_ERR_DECRYPTING_PASSWORD                  1912
#define CmoReqResp_ERR_UNKNOWN_PROTOCOL                     1913
#define CmoReqResp_ERR_LOCATE_RESPONSE                      1914
#define CmoReqResp_ERROR_INVALID_OBJECT_TYPE                1915
#define CmoReqResp_ERROR_MISSING_URL                        1916
#define CmoReqResp_ERROR_MISSING_CONNECTION_NAME            1917
#define CmoReqResp_ERROR_MISSING_APPLICATION_NAME           1918
#define CmoReqResp_ERROR_DB_EXCEPTION                       1919


// CmoLog
#define CmoLog_ERR_LOG_CONNECTION                           2000
#define CmoLog_ERR_OPENING_LOG                              2001
#define CmoLog_ERR_CREATING_LOG                             2002
#define CmoLog_ERR_OPENING_LOG_INDEX                        2003
#define CmoLog_ERR_SETTING_INDEX                            2004
#define CmoLog_ERR_LOG_FIRST                                2005
#define CmoLog_ERR_LOG_LAST                                 2006
#define CmoLog_ERR_LOG_NEXT                                 2007
#define CmoLog_ERR_LOG_PRIOR                                2008
#define CmoLog_ERR_LOG_ATEOF                                2009
#define CmoLog_ERR_LOG_ATBOF                                2010
#define CmoLog_ERR_LOG_FINDKEY                              2011
#define CmoLog_ERR_LOG_COUNT                                2012

#endif


// CmoReg
#define CmoReg_ERR_KEY_NOT_OPEN                             2300
#define CmoReg_ERR_WRITESTRING                              2301
#define CmoReg_ERR_DELETE_VALUE                             2302
#define CmoReg_ERR_DELETE_KEY                               2303
#define CmoReg_ERR_OPEN_KEY                                 2304
#define CmoReg_ERR_QUERY_KEY                                2305
#define CmoReg_ERR_ENUM_KEY                                 2306


// CmoConnection
#define CmoConnection_ERR_PROFILE_NOT_FOUND                 2900
#define CmoConnection_ERR_NO_ACTIVE_PROFILE                 2901
#define CmoConnection_ERR_SERVER_PUB_KEY_EXISTS             2902
#define CmoConnection_ERR_SERVER_PUB_KEY_NOT_FOUND          2903
#define CmoConnection_ERR_PASSWORD_TOO_LONG                 2904
#define CmoConnection_ERR_INVALID_PROF_BOOKMARK             2905
#define CmoConnection_ERR_OLD_PROF_TABLE                    2906
#define CmoConnection_ERR_INVALID_SERVER_ID                 2907
#define CmoConnection_ERR_INVALID_SERVER_PORT               2908

#define CmoConnection_ERR_MISSING_USERNAME_PARAM            2951
#define CmoConnection_ERR_MISSING_PASSWORD_PARAM            2952
#define CmoConnection_ERR_MISSING_SERVER_PARAM              2953
#define CmoConnection_ERR_MISSING_PORT_PARAM                2954

#define CmoConnection_ERR_DEVICE_IN_FLIGHT_MODE             2961
#define CmoConnection_ERR_DEVICE_OUT_OF_NETWORK_COVERAGE    2962
#define CmoConnection_ERR_DEVICE_ROAMING                    2963
#define CmoConnection_ERR_DEVICE_LOWSTORAGE                 2964

// CmoRecordset
// free                                                     3500
#define CmoRecordset_ERR_NOT_SUPPORTED                      3501
#define CmoRecordset_ERR_INVALID_FIELD_TYPE                 3502
#define CmoRecordset_ERR_TABLE_IS_NOT_OPEN                  3503
#define CmoRecordset_ERR_INVALID_FIELD_POS                  3504
#define CmoRecordset_ERR_FIELD_NOT_FOUND                    3505
#define CmoRecordset_ERR_FIELD_DEFS_NOT_EQUAL               3506
#define CmoRecordset_ERR_INVALID_INDEX_POS                  3507
#define CmoRecordset_ERR_INDEX_NOT_FOUND                    3508

// Dataset Utils
#define DSUTILS_ERR_UNKNOWN_EXCEPTION                       3600
#define DSUTILS_ERR_ENCRYPTED                               3601
#define DSUTILS_ERR_NOT_ENCRYPTED                           3602

// STR UTILS
#define STRUTIL_ERR_MEM_ALLOC                               3700

// AF CLIENT
#define CLIENT_AF_ERR_PARAM_NOT_FOUND                       3800
#define CLIENT_AF_ERR_FIELD_NOT_FOUND                       3801
#define CLIENT_AF_ERR_MEM_ALLOC                             3802
#define CLIENT_AF_ERR_INVALID_RO                            3803
#define CLIENT_AF_ERR_CREATE_OBJECT                         3804


// XPD
#define XPD_ERR_SCHEMA_OPEN_FAILED                          3902
#define XPD_ERR_TABLE_OPEN_FAILED                           3904
#define XPD_ERR_MEM_ALLOC                                   3905
#define XPD_ERR_WRONG_FIELD_TYPE                            3914
#define XPD_ERR_BOF_OR_EOF                                  3919
#define XPD_ERR_NOT_XPD_TABLE                               3931
#define XPD_ERR_INCOMPATIBLE_VERSION                        3948
#define XPD_ERR_INVALID_FIELD_NAME                          3949 // field name is invalid or NULL
#define XPD_ERR_INVALID_RECORDSET_STATE                     3950 // cannot call this function when recordset is in the current state
#define XPD_ERR_FIELDS_NOT_DEFINED                          3951 // must create fields prior to calling create table
#define XPD_ERR_DATABASE_ERROR                              3952 // An EDB error occurred, see native error code
#define XPD_ERR_OPEN_ERROR                                  3953 // An EDB error occurred, see native error code
#define XPD_ERR_SCHEMA_ERROR                                3954 // the schema table is corrupt
#define XPD_ERR_INVALID_INDEX_NAME                          3955 // index name is invalid or NULL
#define XPD_ERR_INVALID_INDEX_EXPR                          3956 // the index expression is invalid or NULL
#define ERR_ADO_INITINSTANCE                                3957 // create instance of an ADODB.Recordset failed
#define ERR_ADO_OPENTABLE                                   3958 // open table failed
#define XPD_ERR_TABLE_ALREADY_EXISTS                        3959 // cannot create table because it already exists

#if defined( MO_SERVER )
#define GENERAL_ERR_MEM_ALLOC                               4000
#define CheckCAL_ERR_NOT_LICENSED                           4401
#define CmoGarbageCollector_ERR_UNKNOWN_EXCEPTION           4500
#define CmoWorkerThread_ERR_UNKNOWN_EXCEPTION               4900
#endif

// CmoDateTime
#define CmoDateTime_ERR_YEAR_OUT_OF_RANGE                   5200
#define CmoDateTime_ERR_MONTH_OUT_OF_RANGE                  5201
#define CmoDateTime_ERR_DAY_OUT_OF_RANGE                    5202
#define CmoDateTime_ERR_HOUR_OUT_OF_RANGE                   5203
#define CmoDateTime_ERR_MIN_OUT_OF_RANGE                    5204
#define CmoDateTime_ERR_SEC_OUT_OF_RANGE                    5205
#define CmoDateTime_ERR_MSEC_OUT_OF_RANGE                   5206
#define CmoDateTime_ERR_CONVERT                             5207


// EVB Client
#define EVBClient_ERR_FIELD                                 5300
#define EVBClient_ERR_CREATE_OBJECT                         5301
#define EVBClient_ERR_GETPARAMRECORDSET                     5302


// CmoResultStore
#define CmoResultStore_ERR_UNABLE_TO_DELETE                 5400
#define CmoResultStore_ERR_UNKNOWN_EXCEPTION                5401


#define UTILS_ERR_GETTING_CREATOR_ID                        5500

// MOCA -- Server Invokes Client functionality
#define MOCA_INVALID_APPLICATION_ID                         5600
#define MOCA_UNSUPPORTED                                    5601
#define MOCA_DELETE_REQUESTS_MISSING_REQUIRED_PARAM         5602
#define MOCA_MISSING_REQUIRED_PARAM                         5603
#define MOCA_DATA_CORRUPTION_USER_ID                        5604
#define MOCA_DATA_CORRUPTION_DEVICE_ID                      5605
#define MOCA_DATA_COULD_NOT_GET_COMPUTERNAME                5606
#define MOCA_ILLEGAL_DEVICE_ID_SPECIFIED                    5607
#define MOCA_DATA_DEVICE_CONNECTION_ID_NOT_FOUND            5608
#define MOCA_DATA_INVALID_REQUEST_PARAMS                    5609
#define MOCA_DATA_INVALID_USER_ID                           5610
#define MOCA_DATA_INVALID_DEVICE_ID                         5611
#define MOCA_DATA_INVALID_CONNETION_NAME                    5612
#define MOCA_DATA_INVALID_OBJECT_NAME                       5613
#define MOCA_DATA_INVALID_METHOD_NAME                       5614
#define MOCA_DATA_OUTPUT_ERROR                              5615
#define MOCA_OBJECT_NOT_REGISTERED                          5616
#define MOCA_DATA_INVALID_APPLICATION_NAME                  5617
#define MOCA_DEVICE_DATA_STORED_RESULTS_NOT_FOUND           5618
#define MOCA_DATA_QUEUED_MESSAGES_RECORD_NOT_FOUND          5619
#define MOCA_DATA_QUEUED_MESSSAGE_INVALID_STATE             5620
#define MOCA_ALREADY_STARTED                                5621
#define MOCA_NOT_STARTED                                    5622
#define MOCA_DATA_USER_DEVICE_ID_NOT_FOUND                  5623
#define MOCA_CLIENT_QUEUE_INITIALIZE_FAILURE                5624
#define MOCA_TOO_MANY_MOCA_CLIENT_INSTANCES                 5625
#define MOCA_DEVICE_DATA_STORED_REQUESTS_NOT_FOUND          5626
#define MOCA_ASYNC_OBJECT_NOT_REGISTERED                    5627
#define MOCA_DEVICE_DATA_STORED_RESULTS_FAILURE             5628
#define MOCA_MISSING_REQUEST_ID                             5630
#define MOCA_CLIENT_ERROR_NOT_HANDLED                       5631
#define MOCA_LOG_OPEN_FAILED                                5632
#define MOCA_SETUSER_SETDEVICEID                            5633
#define MOCA_DATA_USER_DEVICE_ID_2_NOT_FOUND                5634
#define MOCA_UNEXPECTED_MOERR_CAUGHT                        5635
#define MOCA_UNEXPECTED_EXCEPTION_CAUGHT                    5636
#define MOCA_CLIENT_NOT_INITIALIZED                         5637
#define MOCA_QUEUED_ITEM_NOT_DELIVERED_DUE_TO_MAX_RETRY     5638
#define MOCA_RETRY_REQUEST_AT_LOWER_PRIORITY                5639
#define MOCA_MESSAGES_TIMEOUT_UNEXPECTED_EXCEPTION_CAUGHT   5640
#define MOCA_MESSAGE_TIMED_OUT_IN_QUEUE                     5641
#define MOCA_POWER_MANAGER_START_FAILED                     5642
#define MOCA_USER_CONNECTION_ALREADY_PROCESSING_A_REQUEST   5643
#define MOCA_USER_SERIALIZATION_FAILED                      5644
#define MOCA_SET_WORKER_THREAD_COUNT_BEFORE_START           5645
#define MOCA_CLIENT_PROCESSING_REQUEST_ID_BAD               5646
#define MOCA_ENCRYPTION_FAILED                              5647
#define MOCA_DECRYPTION_FAILED                              5648
#define MOCA_QUEUED_ITEM_NOT_DELIVERED_DUE_TO_DECRYPT_FAIL  5649
#define MOCA_QUEUED_ITEM_NOT_DELIVERED_DUE_TO_CRC_FAIL      5650
#define MOCA_MESSAGE_INVALID_NO_OBJECTNAME                  5651
#define MOCA_MESSAGE_INVALID_NO_METHODNAME                  5652
#define MOCA_MESSAGE_INVALID_NO_REQUESTID                   5653
#define MOCA_MESSAGES_DELIVERY_UNEXPECTED_EXCEPTION_CAUGHT  5654
#define MOCA_ADD_DEVICE_REQUEST_FAILURE_UPDATING_RECORD     5655
#define MOCA_DATA_FAILED_TO_OPEN_NAMED_EVENT                5656
#define MOCA_COMPRESSION_FAILED                             5657
#define MOCA_DECOMPRESSION_FAILED                           5658
#define MOCA_QUEUED_ITEM_NOT_DELIVERED_DUE_TO_DECOMPRESSION_FAIL  5659


#define REG_ERR_OPEN_KEY                                    6000


// CmoByteList
#define CmoByteList_ERR_INVALID_INDEX                       6100

// OS errors
#define WIN_API_FAILURE                                     6300 // see the native or code
#define PALM_CREATE_DATABASE_FAILED                         6301 // see the native or code
#define PALM_FIND_DATABASE_FAILED                           6302
#define PALM_OPEN_DATABASE_FAILED                           6303 // see the native error code
#define PALM_CLOSE_DATABASE_FAILED                          6304 // see the native error code
#define PALM_DELETE_DATABASE_FAILED                         6305 // see the native error code

// ECStream failures
#define OB_STREAM_READ_FAILURE                              6400 // see the native error code
#define OB_STREAM_WRITE_FAILURE                             6401 // see the native error code
#define OB_STREAM_BAD_RECORD_SET                            6402 // record set not parsed correctly

// sync errors
#define MO_SYNC_PARAM_MISSING                               6500 // the description contains the name of the param
#define MO_SYNC_COM_ERROR                                   6501 // the native code contains the HRESULTS
#define MO_SYNC_INVALID_COMMAND                             6502 // the description contains the command
#define MO_SYNC_RECORD_NOT_FOUND                            6503 // the record was not found
#define MO_SYNC_NON_COM_ERROR                               6504 // non COM Exception error.
#define MO_SYNC_SETTINGSDB_ERROR                            6505 // Error With Settings DB.
#define MO_SYNC_USER_CANCELLED                              6506 // User cancelled
#define MO_SYNC_SESSIONLOST_ERROR                           6507 // Error With Settings DB.
#define MO_SYNC_ERROR                                       6508 // Error With Settings DB.
#define MO_SYNC_SESSION_STORE_ERROR                         6509 // MO Session store (moRecordset if null)
#define MO_SYNC_SESSION_DELETE_ERROR                        6510
//******************************************************************

#define MO_USER_CANCELLED                                   6600

//Push Registration Errors
#define MO_ERR_PUSHREG_APPBUSY                              6700 //The application is currently performing a task.
#define MO_ERR_PUSHREG_EMPTY_ACTIONLIST                     6701 //There are no Action Sets configured.
#define MO_ERR_PUSHREG_APP_NOT_FOUND                        6702 //Could not get the application name.
#define MO_ERR_PUSHREG_PROFLIE_NOT_FOUND                    6703 //No current profile. Live Connect Registration not run?
#define MO_ERR_PUSHREG_PUSHREG_SETTING                      6704 //Error accessing push settings.
#define MO_ERR_PUSHREG_REGISTER                             6705 //Error while registering
#define MO_ERR_PUSHREG_UNREGISTER                           6706 //Error while unregistering.
#define MO_ERR_PUSHREG_NAME                                 6707 //Error finding name of item to register for.
#define MO_ERR_PUSHREG_APP_NAME_EMPTY                       6708 //Could not get the application name.

// SUP errors
#define SUP_INVALID_PARAMETER                               6900
#define SUP_PARSE_FAILURE                                   6901
#define SUP_INVALID_RECORDID                                6902
#define SUP_INVALID_PIMSTORE                                6903
#define SUP_INVALID_PIMDATA                                 6904
#define SUP_INVALID_APPNAME                                 6905
#define SUP_INVALID_PIM_OPERATION                           6906
#define SUP_CONVERSION_FAILURE                              6910
#define SUP_OPERATION_FAILURE                               6911


// EDB errors
#define EDB_TABLE_IS_OPEN                                   10000
#define EDB_TABLE_IS_NOT_OPEN                               10001
#define EDB_NO_ACTIVE_INDEX                                 10002
#define EDB_RECORD_NOT_FOUND                                10003
#define EDB_VARIABLE_LENGTH_INDEX                           10004
#define EDB_FIELD_NAME_TOO_LONG                             10005
#define EDB_DUPLICATE_FIELD                                 10006
#define EDB_INVALID_FIELD_TYPE                              10007
#define EDB_INVALID_INDEX                                   10008
#define EDB_INVALID_FIELD                                   10009
#define EDB_INVALID_FIELD_INDEX                             10010
#define EDB_INVALID_RECORD                                  10011
#define EDB_MEMHANDLELOCK_FAILED                            10012
#define EDB_INVALID_OFFSET                                  10013

// SUPHandler errors
#define SUPOBJ_FACTORY_STRING_EXCEPTION                         10301
#define SUPOBJ_FACTORY_UNKNOWN_EXCEPTION                        10302
#define SUPOBJ_ASYNC_METHOD_CALL_FROM_SERVER_STRING_EXCEPTION   10303
#define SUPOBJ_ASYNC_METHOD_CALL_FROM_SERVER_UNKNOWN_EXCEPTION  10304
#define SUPOBJ_REFRESH_ALL_DATA_STRING_EXCEPTION                10305
#define SUPOBJ_REFRESH_ALL_DATA_UNKNOWN_EXCEPTION               10306
#define SUPOBJ_PROCESS_DATASTORE_CLEARED_STRING_EXCEPTION       10307
#define SUPOBJ_PROCESS_DATASTORE_CLEARED_UNKNOWN_EXCEPTION      10308
#define SUPOBJ_CONNECTION_STATE_CHANGED_STRING_EXCEPTION        10309
#define SUPOBJ_CONNECTION_STATE_CHANGED_UNKNOWN_EXCEPTION       10310
#define SUPOBJ_RELEASE_STRING_EXCEPTION                         10311
#define SUPOBJ_RELEASE_UNKNOWN_EXCEPTION                        10312
#define SUPOBJ_PIM_CHANGE_NOTIFICATION_STRING_EXCEPTION         10313
#define SUPOBJ_PIM_CHANGE_NOTIFICATION_UNKNOWN_EXCEPTION        10314
#define SUPOBJ_HANDLE_FILE_CHUNK_EXCEPTION                      10315

// Email plugin errors
#define EMAIL_ERR_NO_SETTINGS              16000
#define EMAIL_ERR_NO_PASSWORD              16001
#define EMAIL_ERR_UNLOCK_COMPONENT            16002
#define EMAIL_ERR_POP_LOGIN                                 16003
#define EMAIL_ERR_SSL_VERIFICATION                          16004
#define EMAIL_ERR_IMAP_CONNECTION             16005
#define EMAIL_ERR_IMAP_LOGIN               16006
#define EMAIL_ERR_IMAP_NO_INBOX               16007
#define EMAIL_ERR_POP_CONNECTION           16008
#define EMAIL_ERR_MESSAGE_MISSING                           16009

// 20000 and higher reserver for application specific errors
#define MO_APPLICATION_ERROR                                20000


#endif// moErrCodes_H_INCLUDED
