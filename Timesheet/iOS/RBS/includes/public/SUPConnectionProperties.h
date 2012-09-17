/*
 
 Copyright (c) Sybase, Inc. 2010   All rights reserved.                                    
 
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

#import <Foundation/Foundation.h>
#import "SUPLoginCertificate.h"
#import "SUPLoginCredentials.h"
#import "SUPStringProperties.h"

//Use HTTP for network communication (unencrypted session with encrypted payload). See also: Hypertext Transfer Protocol.
#define SUPConnectionProperties_NETWORK_PROTOCOL_HTTP	 @"http"	

//Use HTTPS for network communication (encrypted session with encrypted payload). See also: HTTP Secure.
#define SUPConnectionProperties_NETWORK_PROTOCOL_HTTPS	 @"https"	

// Connection Property name
#define SUP_SERVER_NAME_PROP "ServerName"
#define SUP_SERVER_PORT_PROP "ServerPort"
#define SUP_FARMID_PROP "FarmID"
#define SUP_USERNAME_PROP "Username"
#define SUP_ACTCODE_PROP "ActivationCode"
#define SUP_URL_PREFIX_PROP "URLPrefix"
#define SUP_Password_PROP "Password"
#define SUP_APP_ID_PROP "ApplicationID"

// password policy property name
#define SUP_PWDPOLICY_ENABLED_PROP  @"PasswordPolicy_enabled"
#define SUP_PWDPOLICY_DEFAULT_PASSWORD_ALLOWED_PROP @"PasswordPolicy_default_password_allowed"
#define SUP_PWDPOLICY_MIN_LENGTH_PROP @"PasswordPolicy_min_length"
#define SUP_PWDPOLICY_HAS_DIGITS_PROP @"PasswordPolicy_has_digits"
#define SUP_PWDPOLICY_HAS_UPPER_PROP @"PasswordPolicy_has_upper"
#define SUP_PWDPOLICY_HAS_LOWER_PROP @"PasswordPolicy_has_lower"
#define SUP_PWDPOLICY_HAS_SPECIAL_PROP @"PasswordPolicy_has_special"
#define SUP_PWDPOLICY_EXPIRATION_DAYS_PROP @"PasswordPolicy_expiration_days"
#define SUP_PWDPOLICY_MIN_UNIQUE_CHARS_PROP @"PasswordPolicy_min_unique_chars"
#define SUP_PWDPOLICY_LOCK_TIMEOUT_PROP @"PasswordPolicy_lock_timeout"
#define SUP_PWDPOLICY_RETRY_LIMIT_PROP @"PasswordPolicy_retry_limit"

// Sync server property names
#define SUP_SYNC_SVR_HOST_PROP "SyncServerHost"
#define SUP_SYNC_SVR_PORT_PROP "SyncServerPort"
#define SUP_SYNC_SVR_PROTOCOL_PROP "SyncServerProtocol"
#define SUP_SYNC_SVR_STREAM_PARAMS_PROP "SyncServerStreamParams"
#define SUP_SYNC_SVR_URL_SUFFIX_PROP "SyncServerUrlSuffix"

// Connection status name
#define SUP_CONNECTED_NAME "Connected"  // device connected
#define SUP_DISCONNECTED_NAME "Disconnected"  // device not connected
#define SUP_DEVICEINFLIGHTMODE_NAME "DeviceInFlightMode" // device not connected because of flight mode
#define SUP_DEVICEOUTOFNETWORKCOVERAGE_NAME "DeviceOutOfNetworkCoverage" // device not connected because no network coverage
#define SUP_WAITINGTOCONNECT_NAME "WaitingToConnect"   // device not connected and waiting to retry a connection
#define SUP_DEVICEROAMING_NAME "DeviceRoaming"  // device not connected because roaming was set to false and device is roaming
#define SUP_DEVICELOWSTORAGE_NAME "DeviceLowStorage" // device not connected because of low space.
// Connection Type name
#define SUP_ALWAYS_ON_NAME "Always_ON"

/*!
 @class
 @abstract  A class that supports the configuration of properties to enable application registrations and connections.
 @discussion  
 */
@interface SUPConnectionProperties : NSObject {
	
@private
    NSString* activationCode;
	
	//
	SUPLoginCertificate *loginCertificate;
	
	//Set this property to enable authentication by username and password.
	SUPLoginCredentials *loginCredentials;
	
	//Network protocol for the server connection URL.
	NSString* networkProtocol;
	
	//Port number for the server connection URL.
	int32_t portNumber;
	
	//Security configuration to be used.
	NSString* securityConfiguration;
	
	//Server name for the server connection URL.
	NSString* serverName;
	
	//URL suffix for the server connection URL. 
	NSString* urlSuffix;
	
	NSString* farmId;

	SUPStringProperties *httpHeaders;
    SUPStringProperties *httpCookies;

    SUPLoginCredentials *httpCredentials;
	

}

/*!
 @property
 @abstract In addition to setting either loginCertificate or loginCredentials, an activation code may be required for application registration.
 @discussion
 */
@property(readwrite, retain, nonatomic) NSString* activationCode;
/*!
 @property
 @abstract Set this property to enable authentication by a digital certificate.
 @discussion
 */
@property(readwrite, retain, nonatomic) SUPLoginCertificate *loginCertificate;
/*!
 @property
 @abstract Set this property to enable authentication by username and password.
 @discussion
 */
@property(readwrite, retain, nonatomic) SUPLoginCredentials *loginCredentials;
/*!
 @property
 @abstract Network protocol for the server connection URL.
 @discussion
 */
@property(readwrite, retain, nonatomic) NSString* networkProtocol;
/*!
 @property
 @abstract Port number for the server connection URL.
 @discussion
 */
@property(readwrite) int32_t portNumber;
/*!
 @property
 @abstract Security configuration to be used.
 @discussion
 */
@property(readwrite, retain, nonatomic) NSString* securityConfiguration;
/*!
 @property
 @abstract Server name for the server connection URL.
 @discussion
 */
@property(readwrite, retain, nonatomic) NSString* serverName;
/*!
 @property
 @abstract URL suffix for the server connection URL.
 @discussion
 */
@property(readwrite, retain, nonatomic) NSString* urlSuffix;
/*!
 @property
 @abstract Farm ID.
 @discussion
 */
@property(readwrite, retain, nonatomic) NSString* farmId;
/*!
 @property
 @abstract  Any custom HTTP headers needed for server communication.
 @discussion
 */
@property(readwrite, retain, nonatomic) SUPStringProperties* httpHeaders;
/*!
 @property
 @abstract  Any custom HTTP cookies needed for server communication.
 @discussion
 */
@property(readwrite, retain, nonatomic) SUPStringProperties* httpCookies;
/*!
 @property
 @abstract  Credentials needed for HTTP basic authentication.
 @discussion
 */
@property(readwrite, retain, nonatomic) SUPLoginCredentials *httpCredentials;

//@property(readwrite, retain, nonatomic) SUPNullableString advancedUrlSuffix;

+ (SUPConnectionProperties*)getInstance;

-(NSString*)getUserName;


@end

