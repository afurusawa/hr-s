/*
 
 Copyright (c) Sybase, Inc. 2010  All rights reserved.                                    
 
 In addition to the license terms set out in the Sybase License Agreement for 
 the Sybase Unwired Platform ("Program"), the following additional or different 
 rights and accompanying obligations and restrictions shall apply to the source 
 code in this file ("Code").  Sybase grants you a limited, non-exclusive, 
 non-transferable, revocable license to use, reproduce, and modify the Code 
 solely for purposes of (i) maintaining the Code as reference material to better
 understand the operation of the Program, and (ii) development and testing of 
 applications created in connection with your licensed use of the Program.  
 The Code may not be transferred, sold, assigned, sublicensed or otherwise 
 conveyed (whether by operation of law or otherwise) to another party without 
 Sybase's prior written consent.  The following provisions shall apply to any 
 modifications you make to the Code: (i) Sybase will not provide any maintenance
 or support for modified Code or problems that result from use of modified Code;
 (ii) Sybase expressly disclaims any warranties and conditions, express or 
 implied, relating to modified Code or any problems that result from use of the 
 modified Code; (iii) SYBASE SHALL NOT BE LIABLE FOR ANY LOSS OR DAMAGE RELATING
 TO MODIFICATIONS MADE TO THE CODE OR FOR ANY DAMAGES RESULTING FROM USE OF THE 
 MODIFIED CODE, INCLUDING, WITHOUT LIMITATION, ANY INACCURACY OF DATA, LOSS OF 
 PROFITS OR DIRECT, INDIRECT, SPECIAL, INCIDENTAL OR CONSEQUENTIAL DAMAGES, EVEN
 IF SYBASE HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGES; (iv) you agree 
 to indemnify, hold harmless, and defend Sybase from and against any claims or 
 lawsuits, including attorney's fees, that arise from or are related to the 
 modified Code or from use of the modified Code. 
 
 */
 #import "SUPConnectionStatus.h"

/*!
 @enum       
 @abstract   The connection status enumeration.  Used by the onConnectionStatusChange callback handler method.
 @discussion 
 */
/*
typedef enum {
    SUPConnectionStatus_CONNECTED = 1,
    SUPConnectionStatus_DISCONNECTED = 2,
    SUPConnectionStatus_DEVICE_IN_FLIGHT_MODE = 3,
    SUPConnectionStatus_DEVICE_OUT_OF_NETWORK_COVERAGE = 4,
    SUPConnectionStatus_DEVICE_WAITING_FOR_CONNECTION = 5,
    SUPConnectionStatus_DEVICE_DATA_ROAMING_DISABLED = 6,
    SUPConnectionStatus_DEVICE_STORAGE_SPACE_LOW = 7,
    SUPConnectionStatus_DEVICE_WAITING_FOR_NOTIFICATION = 8
} SUPConnectionStatus;

 */
typedef enum {
    WRONG_STATUS_NUM        = 0,
	CONNECTED_NUM           = 1,								// Device is connected.
	DISCONNECTED_NUM		= 2,								// Device is not connected.
	DEVICEINFLIGHTMODE_NUM	= 3,					// Device is not connected due to flight mode.
	DEVICEOUTOFNETWORKCOVERAGE_NUM	= 4,	// Device is not connected due to no network coverage.
	WAITINGTOCONNECT_NUM	= 5,			// Device is not connected and is waiting to retry for a connection.      
	DEVICEROAMING_NUM		= 6,				// Device is not connected since roaming was set to false and device is roaming.
    DEVICELOWSTORAGE_NUM    = 7			// Device is not connected due to low space.
} SUPDeviceConnectionStatus;

/*!
 @enum 
 @abstract   The connection type enumeration.  Used by the onConnectionStatusChange callback handler method.
 @discussion 
 */

typedef enum {
    WRONG_TYPE_NUM     = 0,
	ALWAYS_ON_NUM      = 1 // iPhone has only one connection type
} SUPDeviceConnectionType;

/*!
 @enum       
 @abstract   The connection property ID enumeration.  Used by the onApplicationConnectionPropertyChange callback handler method.
 @discussion 
 */

typedef enum {
    UNKNOWN_PROPERTY_TYPE    = 0,
	SERVER_PROP_ID           = 1,   
	PORT_PROP_ID		     = 2,
	FARMID_PROP_ID			 = 3,
	DOMAIN_PROP_ID           = 7,
    CONNECTION_SYNC_SVR_HOST                              =  8,
    CONNECTION_SYNC_SVR_PORT                              =  9,
    CONNECTION_SYNC_SVR_PROTOCOL                          = 10,
    CONNECTION_SYNC_SVR_URL_SUFFIX                        = 11,
    CONNECTION_SYNC_SVR_STREAM_PARAMS                     = 12,
	USERNAME_PROP_ID		 = 10001,
	ACTCODE_PROP_ID          = 10002,
	URL_PREFIX_PROP_ID       = 1305,
    CUSTOM1_PROP_ID          = 2300,
    CUSTOM2_PROP_ID          = 2301,
    CUSTOM3_PROP_ID          = 2302,
    CUSTOM4_PROP_ID          = 2303,
    PWDPOLICY_ENABLED_PROP_ID = 3100,
    PWDPOLICY_DEFAULT_PASSWORD_ALLOWED_PROP_ID = 3101,
    PWDPOLICY_MIN_LENGTH_PROP_ID = 3102,
    PWDPOLICY_HAS_DIGITS_PROP_ID = 3103,
    PWDPOLICY_HAS_UPPER_PROP_ID = 3104,
    PWDPOLICY_HAS_LOWER_PROP_ID = 3105,
    PWDPOLICY_HAS_SPECIAL_PROP_ID = 3106,
    PWDPOLICY_EXPIRATION_DAYS_PROP_ID = 3107,
    PWDPOLICY_MIN_UNIQUE_CHARS_PROP_ID = 3108,
    PWDPOLICY_LOCK_TIMEOUT_PROP_ID = 3109,
    PWDPOLICY_RETRY_LIMIT_PROP_ID = 3110    
} SUPConnectionPropertyType;

#define getConnectionStatusNum(s)    [SUPConnectionUtil getConnectionStatusNum:s]
#define getConnectionTypeNum(t)      [SUPConnectionUtil getConnectionTypeNum:t]
#define getConnectionPropertyType(p) [SUPConnectionUtil getConnectionPropertyType:p]


// backwards compatibility
//typedef SUPConnectionStatus ConnectionStatus DEPRECATED_ATTRIBUTE;
//typedef SUPConnectionStatus SUPDeviceConnectionStatus DEPRECATED_ATTRIBUTE;

typedef SUPDeviceConnectionStatus ConnectionStatus DEPRECATED_ATTRIBUTE;
typedef SUPDeviceConnectionType ConnectionType DEPRECATED_ATTRIBUTE;

// The following methods are only used by library code.
@interface SUPConnectionUtil : NSObject {

}
+ (SUPDeviceConnectionStatus) getConnectionStatusNum:(NSString *)status_name;
+ (SUPDeviceConnectionType) getConnectionTypeNum:(NSString *)type_name;
+ (SUPConnectionPropertyType) getConnectionPropertyType:(NSString *)property_name;
@end
