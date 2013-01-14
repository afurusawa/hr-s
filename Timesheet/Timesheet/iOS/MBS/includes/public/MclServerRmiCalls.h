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
#ifndef ____MCLSERVERRMICALLS____
#define ____MCLSERVERRMICALLS____


// DeviceManagement exception codes for addDeviceRegistration
#define DM_RET_MMS_AUTHENTICATION_FAILED      100
#define DM_RET_MMS_COULD_NOT_REACH_SERVER     101
#define DM_RET_TEMPLATE_NOT_FOUND             102
#define DM_RET_AUTO_REGISTRATION_NOT_ENABLED  103
#define DM_RET_REGISTRATION_NOT_FOUND         104
#define DM_RET_DEVICE_REGISTERED_WITH_DIFFERENT_USER 105
#define DM_RET_USER_NAME_TOO_LONG             107
#define DM_RET_USER_NAME_INVALID              108

// MclServerRmiCalls interface
@interface MclServerRmiCalls : NSObject {
}


/**
 * Adds registration at the server for this device.  
 * Uses connection properties assigned to config settings to contact
 * the server.  
 * 
 * The password must be supplied in order to authenticate with the server
 * or order to perform the device registration.
 * 
 * If this is a workflow application, then the server will find an 
 * existing registration for this user, acquire the activation code
 * from the server, and configuration the client.  
 * 
 * password
 *                   Server Password for SUP to validate this user.
 * isWorkflowclient
 *                   True if this call is on behalf of a workflow client.
 * 
 * 
 * 
 */
+(void) addDeviceRegistration:(NSString *)password;
+(void) addDeviceRegistration:(NSString *)password withTimeout:(NSInteger)timeout;
+(void) deleteDeviceRegistration;
+(void) deleteDeviceRegistration:(NSInteger)timeout;

@end

#endif // ____MCLSERVERRMICALLS____
