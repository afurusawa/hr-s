/*
Copyright (c) Sybase, Inc. 2011 All rights reserved. 

In addition to the license terms set out in the Sybase License Agreement for 
the Sybase Unwired Platform ("Program"), the following additional or different 
rights and accompanying obligations and restrictions shall apply to the source 
code in this file ("Code"). Sybase grants you a limited, non-exclusive, 
non-transferable, revocable license to use, reproduce, and modify the Code 
solely for purposes of (i) maintaining the Code as reference material to better 
understand the operation of the Program, and (ii) development and testing of 
applications created in connection with your licensed use of the Program. 
The Code may not be transferred, sold, assigned, sublicensed or otherwise 
conveyed (whether by operation of law or otherwise) to another party without 
Sybase's prior written consent. The following provisions shall apply to any 
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

MessagingClientLib.h

Interface for push, client settings, and engine configuration
*/
#ifndef ____MESSAGINGCLIENLIB_H____
#define ____MESSAGINGCLIENLIB_H____


#import <UIKit/UIKit.h>

// Error codes

#define COMMERR_SEND_REQUEST_FAILED                 516   // Resetting Communications or communications cancelled during send
#define COMMERR_TMERR_NO_SERVER                     558   // Cannot Connect To Server
#define COMMERR_TMERR_BAD_CRED                      563   // bad credentials 
#define COMMERR_TMERR_SESS_TIMEOUT                  571   // Server Response Timeout - occurs normally with no ill effects
#define COMMERR_TMERR_DEVICEVAL_WRONG_USER          578   // Wrong User For Device 
#define COMMERR_TMERR_DEVICEVAL_WRONG_DEVICE        579   // Wrong Device For Code
#define COMMERR_TMERR_DEVICEVAL_ACTCODE_CHK_FAILED  581   // The Activation Code check failed for unknown reason 
#define COMMERR_TMERR_DEVICEVAL_INVALID_ACT_CODE    580   // The Activation Code was invlaid
#define COMMERR_STREAM_READ_FAILURE                 6400  // Communication Error  - occurs normally with no ill effects
#define COMMERR_USER_CANCELLED                      6600  // either user disabled, or could be switch from wifi to gprs, etc.


#define MCLERR_CALL_INIT_INSTANCE_FIRST                     14801
#define MCLERR_CONNECTION_SETTINGS_INCOMPLETE               14802
#define MCLERR_INIT_INSTANCE_FAILED                         14803
#define MCLERR_SET_CONFIG_PROPERTY_FAILED                   14804
#define MCLERR_NULL_PROPERTY_VALUE                          14805
#define MCLERR_START_CLIENT_FAILED                          14806
#define MCLERR_SHUTDOWN_CLIENT_FAILED                       14807
#define MCLERR_MOOBECT_CREATE_FAILURE                       14809
#define MCLERR_OPERATION_INVALID_FOR_STATE                  14810
#define MCLERR_OBJECT_REGISTRATION_FAILURE                  14811
#define MCLERR_INVALID_PARAMETER_TYPE                       14812
#define MCLERR_COULD_NOT_REACH_MMS_SERVER                   14813
#define MCLERR_MMS_AUTHENTICATION_FAILED                    14814
#define MCLERR_READ_FAILURE                                 14815
#define MCLERR_WRITE_FAILURE                                14816
#define MCLERR_NOT_FOUND                                    14817
#define MCLERR_NOT_SUPPORTED                                14818

// Connection states, should match eConnectionStatus from moclient.h
enum mclConnectionStatus
{
   eMclConnected = 1,                    
   eMclDisconnected = 2,                 
   eMclDeviceInFlightMode = 3,            
   eMclDeviceOutOfNetworkCoverage = 4,   
   eMclWaitingToConnect = 5,            
   eMclDeviceRoaming = 6,                
   eMclDeviceLowStorageStop = 7           
};

// NOTE: new error codes must be documented in the MCL documentation!
// http://share/sites/pto/adg/uep/Design%20Specifications/SUP%201.7%20Specifications/Messaging/MessagingClientAsLibrary.doc

// Auto registration errors
#define MCLERR_AUTO_REG_TEMPLATE_NOT_FOUND        14850
#define MCLERR_AUTO_REG_NOT_ENABLED               14851
#define MCLERR_AUTO_REG_REGISTRATION_NOT_FOUND    14852
#define MCLERR_AUTO_REG_WRONG_USER_FOR_DEVICE     14853
#define MCLERR_AUTO_REG_USER_NAME_TOO_LONG        14854                                            
#define MCLERR_AUTO_REG_DEVICE_ALREADY_REGISTERED 14855                                         
#define MCLERR_INVALID_USER_NAME                  14856                                         

#define MCLERR_UNKNOWN_ERROR                                14899

// Property IDs used by get/set config properties
// 
#define MCL_PROP_ID_CONNECTION_SERVER_NAME                                   1
#define MCL_PROP_ID_CONNECTION_SERVER_PORT                                   2
#define MCL_PROP_ID_CONNECTION_FARM_ID                                       3
#define MCL_PROP_ID_CONNECTION_DOMAIN                                        7
#define MCL_PROP_ID_CONNECTION_SYNC_SVR_HOST                                 8
#define MCL_PROP_ID_CONNECTION_SYNC_SVR_PORT                                 9
#define MCL_PROP_ID_CONNECTION_SYNC_SVR_PROTOCOL                            10
#define MCL_PROP_ID_CONNECTION_SYNC_SVR_URL_SUFFIX                          11
#define MCL_PROP_ID_CONNECTION_SYNC_SVR_STREAM_PARAMS                       12
#define MCL_PROP_ID_CONNECTION_USE_HTTPS                                    20
#define MCL_PROP_ID_CONNECTION_USER_NAME                                 10001
#define MCL_PROP_ID_CONNECTION_ACTIVATION_CODE                           10002
#define MCL_PROP_ID_DEVICE_MODEL                                          1200
#define MCL_PROP_ID_DEVICE_SUBTYPE                                        1201
#define MCL_PROP_ID_DEVICE_PHONE_NUMBER                                   1202
#define MCL_PROP_ID_DEVICE_IMSI                                           1203
#define MCL_PROP_ID_ADVANCED_MOCA_TRACE_LEVEL                             1302
#define MCL_PROP_ID_ADVANCED_MOCA_TRACE_SIZE                              1303
#define MCL_PROP_ID_ADVANCED_RELAY_SVR_URL_TEMPLATE                       1305
#define MCL_PROP_ID_FT_SM_LEVEL                                           1400
#define MCL_PROP_DEF_CUSTOM_CUSTOM1                                       2300
#define MCL_PROP_DEF_CUSTOM_CUSTOM2                                       2301
#define MCL_PROP_DEF_CUSTOM_CUSTOM3                                       2302
#define MCL_PROP_DEF_CUSTOM_CUSTOM4                                       2303
#define MCL_PROP_ID_IPHONE_SEC_MIN_PASSWORD_LENGTH                        2400
#define MCL_PROP_ID_IPHONE_SEC_REQUIRE_STRONG_PASSWORD                    2401
#define MCL_PROP_ID_IPHONE_SEC_IDLE_TIMEOUT                               2402
#define MCL_PROP_ID_IPHONE_SEC_MISSED_PASSWORD_DATA_WIPE                  2403 
#define MCL_PROP_ID_SECURITY_E2E_ENCRYPTION_ENABLED                       2800
#define MCL_PROP_ID_SECURITY_E2E_ENCRYPTION_TYPE                          2801
#define MCL_PROP_ID_SECURITY_TLS_TYPE                                     2802
#define MCL_PROP_ID_APPLICATION_CUSTOMIZATION_RESOURCES                   2903
#define MCL_PROP_ID_PROXY_APPLICATION_ENDPOINT                            3000
#define MCL_PROP_ID_PROXY_PUSH_ENDPOINT                                   3001

#define MCL_PROP_ID_PWDPOLICY_ENABLED                                     3100
#define MCL_PROP_ID_PWDPOLICY_DEFAULT_PASSWORD_ALLOWED                    3101
#define MCL_PROP_ID_PWDPOLICY_MIN_LENGTH                                  3102
#define MCL_PROP_ID_PWDPOLICY_HAS_DIGITS                                  3103
#define MCL_PROP_ID_PWDPOLICY_HAS_UPPER                                   3104
#define MCL_PROP_ID_PWDPOLICY_HAS_LOWER                                   3105
#define MCL_PROP_ID_PWDPOLICY_HAS_SPECIAL                                 3106
#define MCL_PROP_ID_PWDPOLICY_EXPIRATION_DAYS                             3107
#define MCL_PROP_ID_PWDPOLICY_MIN_UNIQUE_CHARS                            3108
#define MCL_PROP_ID_PWDPOLICY_LOCK_TIMEOUT                                3109
#define MCL_PROP_ID_PWDPOLICY_RETRY_LIMIT                                 3110

#define MCL_PROP_ID_CONNECTION_AUTO_REGISTRATION_HINT                    10005
                                  
#define MCL_PROP_ID_SETTINGS_EXCHANGE_COMPLETE                           20000                                                                                                                                                                                                                                                             

// Return codes from provisioning API
#define kProvisionComplete                0
#define kProvisionedPartially             1
#define kProvisionDataNotAvailable        2
#define kProvisionRequestedFromAfaria     3
#define kProvisionAfariaNotInstalled      4
#define kProvisionUrlNotFromAfaria        5
#define kProvisionDataVaultLocked         6
#define kProvisionUnexpectedError         7
#define kProvisionFormatError             8
#define kSettingsProvisioningNotImplemented 9

// The minimum PIN length (getSupSecMinPwLength), idle timeout (getSupSecIdleTimeout), missed
// data wipe value (getSupSecMissedPwDataWipe), and require strong PIN (getSupSecRequireStrongPin)
// values only apply if the security level is set to kSecurityLevelCustom.
// Otherwise, if the security level doesn't exist the default is kSecurityLevelHigh
// The minimum PIN length for kSecurityLevelMedium defaults to 4 (kMedSecurityPwLen)
// The minimum PIN length for kSecurityLevelMedium defaults to 6 (kHighSecurityPwLen)
// The idle timeout for kSecurityLevelMedium defaults to 10 minutes
// The idle timeout for kSecurityLevelHigh defaults to 0 minutes
// The missed password data wipe value for kSecurityLevelMedium defaults to 99 (kMedSecurityRetries)
// The missed password data wipe value for kSecurityLevelHigh defaults to 15 (kHighSecurityRetries)
// The require strong PIN value for all levels defaults to strong
enum securityLevels {
   kSecurityLevelNone,
   kSecurityLevelMedium,
   kSecurityLevelHigh,
   kSecurityLevelCustom
};

#define kMedSecurityPwLen     4
#define kHighSecurityPwLen    6
#define kMedSecurityRetries  99
#define kHighSecurityRetries 15

                                                                                                                                                                                                                                                                                        
// Protocol to be implemented by caller to listen to connection state notifications
@protocol ConnectionStateListenerDelegate 

@required
-(void) onConnectionStateChanged:(NSInteger) connStatus connectionType:(NSInteger)connType error:(NSInteger)errCode errorMsg:(NSString *)errMsg;

@end


// Protocol to be implemented by caller to listen to configuration state notifications
@protocol ConfigurationChangeListenerDelegate 

@required
-(void) onConfigurationChange:(NSInteger)iPropertyID  value:(id)oValue;

@end


// Protocol to be implemented by caller to listen to connection initialization notifications
@protocol ClientInitializeListenerDelegate 

@required
-(void) onClientInitialize;

@end

// Protocol to be implemented by application to display alert box to user displaying certificate info to user get their feedback
@protocol CertificateChallengeListenerDelegate 

@required
-(void) onCertificateChallenge:(NSString *)certInfo;

@end

// Protocol to be implemented by application to get username & password from user for HTTP Basic authentication
@protocol HTTPAuthChallengeListenerDelegate 

@required
// userName will be valid if it were provided in the past
-(void) onHTTPAuthChallenge:(NSString *)host forUser:(NSString *)userName withRealm:(NSString *)realm;

@end

// Protocol to be implemented by communication layer expecting the user results for certificate challenge
@protocol CertificateChallengeResultListenerDelegate 

@required
-(void) onCertificateChallengeResult:(BOOL)challengeResult;

@end

// Protocol to be implemented by communication layer to receive username & password from user for HTTP Basic authentication
@protocol HTTPAuthChallengeResultListenerDelegate 

@required
// credentialsSupplied indicates if user supplied credentials or not
// userName and password contains values supplied by user if credentialsSupplied is YES and nil otherwise
-(void) onHTTPAuthChallengeResult:(BOOL)credentialsSupplied forUser:(NSString *)userName withPassword:(NSString *)password;

@end

// Protocol to be implemented by application to listen for HTTP errors
@protocol HTTPErrorDelegate

@required 
-(void) onHTTPError:(int)code errorMessage:(NSString*)message httpHeaders:(NSDictionary*)headers;

@end

// Protocol to be implemented by application to listen for Workflow token authentication errors
@protocol WorkflowTokenErrorDelegate

@required 
-(void) onWorkflowTokenError:(int)code errorMessage:(NSString*)message;

@end

// Name of the exception thrown for MessagingClient errors
extern NSString * const MessagingClientExceptionName;

@interface MessagingClientException : NSException {
}
- (id)initWithErrorAndMessage: (int)errorCode message:(NSString *)errorMessage;

@end


// Main interface
@interface MessagingClientLib : NSObject {
   NSMutableArray *connStateListenerDelegateArray;
   NSMutableArray *configurationChangeListenerDelegateArray;
   NSMutableArray *clientInitializeListenerDelegateArray;
   id<CertificateChallengeListenerDelegate> certChallengeListenerDelegate;
   id<CertificateChallengeResultListenerDelegate> certChallengeResultListenerDelegate;
   id<HTTPAuthChallengeListenerDelegate> httpAuthChallengeListenerDelegate;
   id<HTTPAuthChallengeResultListenerDelegate> httpAuthChallengeResultListenerDelegate;
   id<HTTPErrorDelegate> httpErrorDelegate;
   id<WorkflowTokenErrorDelegate> workflowTokenErrorDelegate;
   
   NSString* givenHost;
   NSString* givenUserName;
   NSString* givenRealm;
}

@property (nonatomic, retain) NSMutableArray *connStateListenerDelegateArray;
@property (nonatomic, retain) NSMutableArray *configurationChangeListenerDelegateArray;
@property (nonatomic, retain) NSMutableArray *clientInitializeListenerDelegateArray;
@property (nonatomic, retain) id<CertificateChallengeListenerDelegate> certChallengeListenerDelegate;
@property (nonatomic, retain) id<CertificateChallengeResultListenerDelegate> certChallengeResultListenerDelegate;
@property (nonatomic, retain) id<HTTPAuthChallengeListenerDelegate> httpAuthChallengeListenerDelegate;
@property (nonatomic, retain) id<HTTPAuthChallengeResultListenerDelegate> httpAuthChallengeResultListenerDelegate;
@property (nonatomic, retain) id<HTTPErrorDelegate> httpErrorDelegate;
@property (nonatomic, retain) id<WorkflowTokenErrorDelegate> workflowTokenErrorDelegate;

/**
 * <description>Set the app ID.
 * Sometimes need to examine config and such before initialize is called.
 * 
 */ 
+(void) initInstance:(NSString *)sMbsAppId;


/**
 * Returns the singleton instance of the ClientAccess
 * @return The singleton instance of the ClientAccess
 * NOTE: getInstance will return null if initInstance has not been called!
 */
+(MessagingClientLib*) getInstance;
   
   
/**
 * <description>Setup and start the Moca Client and related objects.
 */
-(void) startClient;
   

/**
 * <description>Stop the Moca client and uninitialize (full stop).
 */
-(void) shutdownClient;


/**
 * <description>Shutsdown and restarts the Moca client.
 */
-(void) restartClient;

  
/**
 * <description>Suspend the Moca Client Connection if connected.
 * Call to stop a running client (client not uninitialized)
 */
-(void) suspendConnection;

   
/**
 * <description>Resume the Moca Client Connection if suspended.
 * Call to start a stopped client (client not reinitialized)
 */
-(void) resumeConnection;
   

/**
 * <description>Checks if clients connection settings are configured
 */
-(BOOL) isConfigured;
   

/**
 * <description>Get the value of a config property.
 * @param iPropId <description>ID of the property to get.
 * @return <description>Value Object (of approprite type) for the prop ID. 
 */
-(id) getConfigProperty:(NSInteger)iPropId;


/**
 * <description>Set the value of a config property.
 * @param iPropId <description>ID of the property to set
 * @param oValue <description>Value (appropriate type for the given ID)
 */
-(void) setConfigProperty:(NSInteger)iPropId withValue:(id)value;


/**
 * <description>Checks if a property is display only property
 */
-(BOOL) propertyIsDisplayOnly:(NSInteger)iPropId;


/**
 * <description>Set the value of all connection properties. 
 * Allows setting all typical user connection settings in a single step.
 * Allows a single commit. Change in connection settings requires MOCA client reset.
 * @param sServer <description> Server name or IP address.
 * @param iPort <description> IP Port.
 * @param sCompanyId <description> Company ID (proxy/relay server).
 * @param sUser <description> Messaging server user name.
 * @param sActCode <description> Activation Code.
 */
-(void) setConnectionProperties:(NSString *)sServer port:(NSInteger)iPort farmId:(NSString*)sCompanyId user:(NSString*)sUser actCode:(NSString*)sActCode;


/**
 * <description>Add a file to be uploaded on demand.
 * @param sDirectory <description>Device directory (proper blackberry URL format).
 * @param sFilename <description>File name. 
 *    Notes      :  
 */
 -(void) addTraceFileForUpload:(NSString *)sDirectory file:(NSString *)sFilename;

   
/**
 * <description>Log message to MocaLog
 * @param sMessage <description>Log message
 * @param iLevel <description>Known event code.
 */
-(void) log:(NSString *)sMessage level:(NSInteger)iLevel;


/**
 * <description>Get the current snapshot of log items.
 * @return <description>String array of last N log events (N is configurable)
 *    Notes      :  MAY NOT IMPLEMENT UNLESS SOMEONE NEEDS IT
 */
//-(NSArray *) getClientLogSnapshot;


/**
 * <description>Get the DeviceId used by MOCA client to uniquely identify the device
 */
-(NSString *) getDeviceID;

/**
 * <description>Create and throw the exception
 */
+ (void)throwMessagingClientException:(int)errorCode message:(NSString *)message;

/**
 * Add a listener for connection state change events
 * Apps may add a listener.
 * @param oListener Listener to notify when we get a connection state change
 */   
-(void) addConnectionStateListener:(id<ConnectionStateListenerDelegate>)delegate;
      
/**
 * Add a listener for config change events
 * Apps may add a listener.
 * @param oListener Listener to notify when we get a config change from server
 */   
-(void) addConfigurationChangeListener:(id<ConfigurationChangeListenerDelegate>)delegate;
   
   
/**
 * Add a listener for client initialization events
 * Apps may add a listener.
 * @param oListener Listener to notify when we get a client initialization event
 */
-(void) addClientInitializeListener:(id<ClientInitializeListenerDelegate>)delegate;

// Check if the application is provisioned
// If not provisioned request for provisioning data from Afaria client
// If Afaria client is not installed return appropriate code so that application can ask user to install Afaria client & try or enter data through settings bundle
// This function must be called from application:didFinishLaunchingWithOptions delegate implementation
// Parameters:
//    url - URL passed in the launchOptions parameter of application:didFinishLaunchingWithOptions:. This parameter can be nil
//    urlScheme - URL scheme of the calling application. Used by Afaria library to communicate with Afaria client
// Return values:
//    kProvisionComplete - Application provisioned already. Nothing more to do
//    kProvisionedPartially - Application is provisioned partially. User should use settings bundle to provision remaining settings
//    kProvisionDataNotAvailable - Provisioning data is not available. User should use settings bundle to provision the settings
//    kProvisionRequestedFromAfaria - Information required to connect to Afaria server is requested from Afaria client. Calling application should quit and call this same API when Afaria client launches the calling application.
//    kProvisionAfariaNotInstalled - Afaria client not installed. Either install Afaria client & try again or use settings application to enter the connection settings
//    kProvisionUrlNotFromAfaria - URL passed is not from Afaria
//    kProvisionDataVaultLocked - Messaging DataVault is locked. Unable to check if application is already provisioned.
//    kProvisionFormatError - Provisioning file is not in the expected format
//    kProvisionUnexpectedError - Unexpected error
//    kSettingsProvisioningNotImplemented - This feature is implemented only on devices. So simulator builds will return this error
+ (NSInteger)provisionApplicationIfRequired:(NSURL *)url appUrlScheme:(NSString *)urlScheme;

// Call this routine in the applicationDidBecomeActive delegate.  It will optimize
// re-establishing network connections after the device goes to sleep.
+(void) markDeviceActive;

// Determines if messaging DB exists
+ (BOOL) isMessagingDBExist;

// Reset messaging state by deleting messaging database and clearing the connection settings
// Also resets the messaging vault as messaging database does not exists anymore
+ (void) resetMessagingState;

// The verification key is checked against a server's public key to determine if a connection
// is allowable or not.  By calling this function, the next connection to a server will be
// accepted and the public key of that server will become the new verification key.
+ (void) clearServerVerificationKey;

// APIs used by application to pass challenge results from user

/**
 * Called by application to pass on the challenge result from user
 */
-(void)certificateChallengeResult:(BOOL)challengeResult;

/**
 * Called by application to pass the HTTP Basic Authentication parameters supplied by user
 */
// userName and password supplied by user
-(void)httpAuthChallengeResult:(BOOL)credentialsSupplied forUser:(NSString *)userName withPassword:(NSString *)password;


// APIs used by communication layer to request challenge from user

/**
 * Called by communication layer when it needs to challenge a certificate from user
 */
-(void)challengeCertificate:(NSString *)certInfo;


/**
 * Called by communication layer when it needs to HTTP Basic authentication parameters (userName/Password) from user
 */
// userName and password contains previously supplied values inf any
-(void)challengeHTTPAuth:(NSString *)host forUser:(NSString *)userName withRealm:(NSString *)realm;

/**
 * Called by communication layer when non-200 HTTP response code is received
 */
-(void)httpError:(int)code errorMessage:(NSString*)message httpHeaders:(NSDictionary*)headers;

/**
 * Called by client when it receives MOCA call indicating server Workflow token authentication failed
 */
-(void)workflowTokenError:(int)code errorMessage:(NSString*)message;

/** 
 * Set headers and cookies into HTTP requests
 */
- (void)setHttpHeaders:(NSDictionary*)headers withCookies:(NSDictionary*)cookies;

@end

// Class to enable and configure push
@interface MCLPush : NSObject
{
}

// Registers the applicaton for push
+ (void)setupForPush:(UIApplication*)application;

// Send the device token to the server to enable push
// Device application is registered for push and device token is passed as parameter
// This device token must be sent to server for server to send notification through APNS
+ (void)deviceTokenForPush:(UIApplication*)application deviceToken:(NSData *)devToken;

// This routine gets called if push registration failed
+ (void)pushRegistrationFailed:(UIApplication*)application errorInfo:(NSError *)err;

// This routine receives notifications while the application is running
+ (void)pushNotification:(UIApplication*)application notifyData:(NSDictionary *)userInfo;

@end

#endif // ____MESSAGINGCLIENLIB_H____

