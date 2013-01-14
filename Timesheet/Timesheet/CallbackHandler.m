/*
 
 Copyright (c) Sybase, Inc. 2012   All rights reserved.
 
 In addition to the license terms set out in the Sybase License Agreement for
 the Sybase Unwired Platform (Program), the following additional or different
 rights and accompanying obligations and restrictions shall apply to the source
 code in this file (Code).  Sybase grants you a limited, non-exclusive,
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


#import "CallbackHandler.h"
#import "SUPConnectionUtil.h"

@implementation CallbackHandler

+ (CallbackHandler*)getInstance
{
    CallbackHandler* _me_1 = [[CallbackHandler alloc] init];
    [_me_1 autorelease];
    return _me_1;
}

- (void)sendNotification:(NSNotification *)notification
{
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    [notification release];
}

- (void)postNotification:(NSString *)notification withObject:(id)obj;
{
    // All callback notifications other than onSubscribe: will happen on a thread other than the main UI thread. So, if you
    // want to update the UI in response to a callback you need to post the notification from the main thread.
    NSNotification *n = [NSNotification notificationWithName:notification object:obj];
    [n retain];
    [self performSelectorOnMainThread:@selector(sendNotification:) withObject:n waitUntilDone:NO];
}
- (void)onConnectionStatusChanged:(SUPConnectionStatusType)connectionStatus :(int32_t)errorCode :(NSString*)errorMessage
{
    NSLog(@"=================================================");
    NSLog(@"onConnectionStatusChanged: status = %d, code = %d, message = %@",connectionStatus,errorCode,errorMessage);
    NSLog(@"=================================================");
    NSString *notification = nil;
    switch(connectionStatus)
    {
        case SUPConnectionStatus_CONNECTED:
            notification = ON_CONNECT_SUCCESS;
            break;
        case SUPConnectionStatus_DISCONNECTED:
            notification = ON_CONNECT_FAILURE;
            break;
        default:
            // Ignore all other status changes for this example.
            break;
    }
    
    if (notification != nil) [self postNotification:notification withObject:nil];
    
}


- (void)onApplicationSettingsChanged:(SUPStringList*)names
{
    NSLog(@"================================================");
    NSLog(@"onApplicationSettingsChanged: names = %@",[names toString]);
    NSLog(@"================================================");
}


- (void)onRegistrationStatusChanged:(SUPRegistrationStatusType)registrationStatus :(int32_t)errorCode :(NSString*)errorMessage;
{
    NSLog(@"=================================================");
    NSLog(@"onRegistrationStatusChanged: status = %d, code = %d, message = %@",registrationStatus,errorCode,errorMessage);
    NSLog(@"=================================================");
}

- (void)onDeviceConditionChanged :(SUPDeviceConditionType)condition;
{
    NSLog(@"=================================================");
    NSLog(@"onDeviceConditionChanged: condition = %d",condition);
    NSLog(@"=================================================");
}

- (void)onHttpCommunicationError :(int32_t)errorCode :(NSString*)errorMessage :(SUPStringProperties*)responseHeaders
{
    NSLog(@"=================================================");
    NSLog(@"onHttpCommunicationError: errorCode = %i",errorCode);
    NSLog(@"=================================================");
}


- (void)onConnectionStatusChange:(SUPDeviceConnectionStatus)connStatus :(SUPDeviceConnectionType)connType :(int32_t)errorCode :(NSString *)errorString
{
    NSString *notification = nil;
    switch(connStatus)
    {
        case CONNECTED_NUM:
            notification = ON_CONNECT_SUCCESS;
            break;
        case DISCONNECTED_NUM:
            notification = ON_CONNECT_FAILURE;
            break;
        default:
            // Ignore all other status changes for this example.
            break;
    }

    if (notification != nil) [self postNotification:notification withObject:nil];
}

- (void)onReplaySuccess:(id)theObject
{
    MBOLogInfo(@"================================================");
    MBOLogInfo(@"Replay Successful");
    MBOLogInfo(@"=================================================");
    
    [self postNotification:ON_REPLAY_SUCCESS withObject:theObject];
}

- (void)onReplayFailure:(id)theObject
{
    MBOLogInfo(@"================================================");
    MBOLogInfo(@"Replay Failure");
    MBOLogInfo(@"=================================================");
    
    [self postNotification:ON_REPLAY_FAILURE withObject:theObject];
}



- (void)onLoginSuccess
{
    MBOLogInfo(@"================================================");
    MBOLogInfo(@"Login Successful");
    MBOLogInfo(@"=================================================");

    [self postNotification:ON_LOGIN_SUCCESS withObject:nil];
}

- (void)onLoginFailure
{
	MBOLog(@"=============================");
	MBOLogError(@"Login Failed");
	MBOLog(@"=============================");

	[self postNotification:ON_LOGIN_FAILURE withObject:nil];
}

- (void)onSubscribeSuccess
{
    MBOLogInfo(@"================================================");
    MBOLogInfo(@"Subscribe Successful");
    MBOLogInfo(@"=================================================");
}

- (void)onImportSuccess
{
    MBOLogInfo(@"================================================");
    MBOLogInfo(@"import ends Successful");
    MBOLogInfo(@"=================================================");

    [self postNotification:ON_IMPORT_SUCCESS withObject:nil];
}

@end
