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
#import "MessagingClientLib.h"
#import "SUPApplicationCallback.h"
#import "sybase_core.h"
#import "SUPApplicationSettings.h"
#import "SUPConnectionProperties.h"
#import "SUPDeviceCondition.h"
#import "SUPConnectionStatus.h"
#import "SUPRegistrationStatus.h"
#import "SUPApplicationRuntimeException.h"
#import "SUPApplicationDefaultCallback.h"
#import "SUPApplicationTimeoutException.h"
#import "SUPConnectionPropertyException.h"

//@protocol SUPApplicationCallback;

#define NO_ERROR 0

//Return code for message client status
#define     MC_STATUS_NOT_INITIALIZED   -1
#define     MC_STATUS_NOT_START         0
#define     MC_STATUS_START             1
#define     MC_STATUS_SUSPEND           2

// names for setting fields
#define kServerNamePref @"servername_preference"
#define kServerPortPref @"serverport_preference"
#define kCompanyIDPref @"companyid_preference"
#define kUserNamePref @"username_preference"
#define kActivationCodePref @"activationcode_preference"
#define kURLPrefixPref @"urlprefix_preference"

/*!
 @class SUPApplication
 @abstract   SUPApplication class
 @discussion A class for the management of mobile application registrations, connections and context. Each generated database class has a setApplication operation. The application identifier and application context (Android-only) must be set on the application object before setApplication is called on a database class. The application object must then be registered with each database class by calling setApplication before the application calls startConnection, registerApplication or unregisterApplication.
 */
@interface SUPApplication : NSObject {
	
	@private
	int32_t messageClientStatus;
	int32_t connectionStatus;
	int32_t registrationStatus;
	SUPNullableString applicationIdentifier;
	id<SUPApplicationCallback> applicationCallback;
	SUPApplicationSettings* applicationSettings;
	SUPConnectionProperties* connectionProperties;
	BOOL registrationAuto;
	BOOL registerFlag;
    NSString* instanceId;
}

@property(readwrite, retain, nonatomic) id<SUPApplicationCallback> applicationCallback;
@property(readwrite, retain, nonatomic) NSString* applicationIdentifier;
@property(readonly, retain, nonatomic) SUPApplicationSettings* applicationSettings;
@property(readonly, retain, nonatomic) SUPConnectionProperties* connectionProperties;
@property(readonly) int32_t connectionStatus;
@property(readonly) int32_t registrationStatus;


/*!
 @function
 @abstract   returns a singleton instance of SUPApplication
 @discussion 
 @param      
 @result    SUPApplication object 
 */
+ (SUPApplication*)getInstance;


/*!
 @function
 @abstract   returns a singleton instance of SUPApplication. This method functions similar to + (SUPApplication*)getInstance and is being added for API consistancy
 accross platforms. This API is not applicable to iOS platform
 @discussion 
 @param      (NSString*)instanceName: 
 @result    SUPApplication object 
 */
+ (SUPApplication*)getInstance:(NSString*)instanceName;


/*!
 @function
 @abstract   returns nil. This API is not applicable to iOS platform
 @discussion 
 @param      
 @result   NSString* 
 */
+ (NSString*)instanceId;
- (NSString*)instanceId;


/*!
    @function
    @abstract   sets callback handler
    @discussion 
    @param   SUPApplicationCallback   
    @result     
*/
+ (void)setApplicationCallback:(id<SUPApplicationCallback>)value;
- (void)setApplicationCallback:(id<SUPApplicationCallback>)value;

/*!
 @function
 @abstract   returns callback handler
 @discussion 
 @param      
 @result   SUPApplicationCallback  
 */
+ (id<SUPApplicationCallback>)applicationCallback;
- (id<SUPApplicationCallback>)applicationCallback; 

/*!
 @function
 @abstract   sets application identifer
 @discussion 
 @param      NSString
 @result     
 */
+ (void)setApplicationIdentifier :(NSString*)value;
- (void)setApplicationIdentifier :(NSString*)value;

/*!
 @function
 @abstract   returns application identifer
 @discussion 
 @param      
 @result     NSString 
 */
+ (NSString*)applicationIdentifier;
- (NSString*)applicationIdentifier;

/*!
 @function
 @abstract   returns applications settings 
 @discussion 
 @param      
 @result  SUPApplicationSettings  instance
 */
+ (SUPApplicationSettings*)applicationSettings; 
- (SUPApplicationSettings*)applicationSettings; 

/*!
 @function
 @abstract   returns connection parameters
 @discussion 
 @param      
 @result   SUPConnectionProperties  instance
 */
+ (SUPConnectionProperties*)connectionProperties;
- (SUPConnectionProperties*)connectionProperties; 

/*!
 @function
 @abstract   returns connection status defined in SUPConnectionStatus.h
 @discussion 
 @param      
 @result   int32_t - connection status defined in SUPConnectionStatus.h
 */
+ (int32_t)connectionStatus;
- (int32_t)connectionStatus;

/*!
 @function
 @abstract   returns registration status defined in SUPRegistrationStatus.h
 @discussion 
 @param      
 @result   int32_t registration status defined in SUPRegistrationStatus.h
 */
+ (int32_t)registrationStatus;
- (int32_t)registrationStatus;

/*!
 @function
 @abstract   registers application if not registered already, otherwise SUPPersistenceException. once registered, start connection
 @discussion 
 - Create the registration for this application, and start the connection. 
 - If the registration was previously created, then this operation has no effect. 
 - You must set the appropriate connectionProperties before calling this operation (which can be done in a previous run of the application as connection properties are persistent). 
 - If some connection properties are improperly set such as to make registration impossible, a ConnectionPropertyException will be thrown. 
 - If the server cannot be contacted for registration creation, then ApplicationRumtimeException will be thrown. 
 - You can set the applicationCallback before calling this operation to receive asynchronous notification of registration status changes.
 
 - If a callback handler is registerd and network connectivity is available, the sequence of callbacks as a result of calling registerApplication should be:
 
 onRegistrationStatusChanged(RegistrationStatus.REGISTERING, 0, null)
 onConnectionStatusChanged(ConnectionStatus.CONNECTING, 0, null)
 onConnectionStatusChanged(ConnectionStatus.CONNECTED, 0, null)
 onRegistrationStatusChanged(RegistrationStatus.REGISTERED, 0, null)
 When the registrationStatus of REGISTERED has been reached, the application can be confident that its applicationSettings have been received from the server and so the application is now in a suitable state for database subscriptions and/or synchronization.
 
 - If a callback handler is registerd and network connectivity is unavailable, the sequence of callbacks as a result of calling registerApplication may be:
 
 onRegistrationStatusChanged(RegistrationStatus.REGISTERING, 0, null)
 onRegistrationStatusChanged(RegistrationStatus.REGISTRATION_ERROR, code, message)
 In such a case, the registration process has permanently failed and will not continue in the background.
 
 - If a callback handler is registerd and network connectivity is available for the start of registration but becomes unavailable before the connection is established, the sequence of callbacks as a result of calling registerApplication may be:
 
 onRegistrationStatusChanged(RegistrationStatus.REGISTERING, 0, null)
 onConnectionStatusChanged(ConnectionStatus.CONNECTING, 0, null)
 onConnectionStatusChanged(ConnectionStatus.CONNECTION_ERROR, code, message)
 In such a case, the registration process has temporarily failed and will continue in the background when network connectivity is restored.
 

 @param    int32_t - if timeout > o and if registration takes longer then timeout, then throw SUPApplicationTimeoutException 
 @result   
 */
+ (void)registerApplication :(int32_t)timeout;
- (void)registerApplication :(int32_t)timeout;

/*!
 @function
 @abstract   starts connection, if not registered already, register first.
 @discussion 
 
 - Start the connection for this application. 
 - If the application was not previously registered, then ApplicationRuntimeException will be thrown. 
 - If the connection was previously started, then this operation has no effect. 
 - You must set the appropriate connectionProperties before calling this operation (which can be done in a previous run of the application as connection properties are persistent). 
 - If some connection properties are improperly set such as to make connection impossible, a ConnectionPropertyException will be thrown. 
 - You can set the applicationCallback before calling this operation to receive asynchronous notification of connection status changes.
 
 - If a callback handler is registerd and network connectivity is available, the sequence of callbacks as a result of calling startConnection should be:
 onConnectionStatusChanged(ConnectionStatus.CONNECTING, 0, null)
 onConnectionStatusChanged(ConnectionStatus.CONNECTED, 0, null)
 
 - If a callback handler is registerd and network connectivity is unavailable, the sequence of callbacks as a result of calling startConnection should be:
 onConnectionStatusChanged(ConnectionStatus.CONNECTING, 0, null)
 onConnectionStatusChanged(ConnectionStatus.CONNECTION_ERROR, code, message)
 
 - After a connection is successfuly established, it can transition at any later time to CONNECTION_ERROR status or NOTIFICATION_WAIT status and subsequently back to CONNECTING and CONNECTED when connectivity resumes.

 @param      int32_t - if timeout > o and if start connection takes longer then timeout, then throw SUPApplicationTimeoutException 
 @result   
 */
+ (void)startConnection :(int32_t)timeout;
- (void)startConnection :(int32_t)timeout;

/*!
 @function
 @abstract   stop connection
 @discussion 
 - Stop the connection for this application. 
 - If the connection was previously stopped, then this operation has no effect. 
 - You can set the applicationCallback before calling this operation to receive asynchronous notification of connection status changes.
 
 - If a callback handler is registerd, the sequence of callbacks as a result of calling stopConnection should be:
 onConnectionStatusChanged(ConnectionStatus.DISCONNECTING, 0, null)
 onConnectionStatusChanged(ConnectionStatus.DISCONNECTED, 0, null)
 @param      int32_t - if timeout > o and if stop connection takes longer then timeout, then throw SUPApplicationTimeoutException 
 @result   
 */
+ (void)stopConnection :(int32_t)timeout;
- (void)stopConnection :(int32_t)timeout;

/*!
 @function
 @abstract   unregister application
 @discussion 
 - Delete the registration for this application, and stop the connection. 
 - If no registration was previously created, or a previous registration was already deleted, then this operation has no effect. 
 - You must set the appropriate connectionProperties before calling this operation (which can be done in a previous run of the application as connection properties are persistent). 
 - If some connection properties are improperly set such as to make unregistration impossible, a ConnectionPropertyException will be thrown. 
 - If the server cannot be contacted for registration deletion, then ApplicationRumtimeException will be thrown. 
 - You can set the applicationCallback before calling this operation to receive asynchronous notification of registration status changes.
 
 - If a callback handler is registerd and network connectivity is available, the sequence of callbacks as a result of calling unregisterApplication should be:
 onConnectionStatusChanged(ConnectionStatus.DISCONNECTING, 0, null)
 onConnectionStatusChanged(ConnectionStatus.DISCONNECTED, 0, null)
 onRegistrationStatusChanged(RegistrationStatus.UNREGISTERING, 0, null)
 onRegistrationStatusChanged(RegistrationStatus.UNREGISTERED, 0, null)
 
 - If a callback handler is registerd and network connectivity is unavailable, the sequence of callbacks as a result of calling unregisterApplication should be:
 onConnectionStatusChanged(ConnectionStatus.DISCONNECTING, 0, null)
 onConnectionStatusChanged(ConnectionStatus.DISCONNECTED, 0, null)
 onRegistrationStatusChanged(RegistrationStatus.UNREGISTERING, 0, null)
 onRegistrationStatusChanged(RegistrationStatus.REGISTRATION_ERROR, code, message)
 @param      int32_t - if timeout > o and if unregister takes longer then timeout, then throw SUPApplicationTimeoutException 
 @result   
 */
+ (void)unregisterApplication :(int32_t)timeout;
- (void)unregisterApplication :(int32_t)timeout;

@end

@interface SUPApplication (internal)
- (void)setConnectionStatus:(SUPInt)value;
- (void)setRegistrationStatus:(SUPInt)value;
- (BOOL)getConnectionPropertiesFromSettings;
+ (NSInteger)messageClientStatus;
+ (BOOL)registrationAuto;
+ (void)setConfigProperty:(SUPConnectionPropertyType)propId withValue:(id)value;
+ (id)getConfigProperty:(SUPConnectionPropertyType)propId;
+ (BOOL)isConnectionInfoConfigured;
- (void)checkInitialized;
- (BOOL)isRegistered;
+ (BOOL)isRegistered;
+ (SUPNullableString)domainName;
+ (void)startConnection :(SUPInt)timeout;
+ (void)stopConnection :(SUPInt)timeout;
+ (BOOL)provisioned;
+ (void)checkDefaults;
+ (void)setRegister:(NSString*)propVale;
+ (void)setUnregister;

typedef enum {
	MCStatusCode_WRONG_STATUS_NUM =0,
    MCStatusCode_CONNECTED = 1,
    MCStatusCode_DISCONNECTED = 2,
    MCStatusCode_DEVICE_IN_FLIGHT_MODE = 3,
    MCStatusCode_DEVICE_OUT_OF_NETWORK_COVERAGE = 4,
    MCStatusCode_DEVICE_WAITING_FOR_CONNECTION = 5,
    MCStatusCode_DEVICE_DATA_ROAMING = 6,
    MCStatusCode_DEVICE_STORAGE_SPACE_LOW = 7,
    MCStatusCode_DEVICE_WAITING_FOR_NOTIFICATION = 8
} MCStatusCode;


@end
