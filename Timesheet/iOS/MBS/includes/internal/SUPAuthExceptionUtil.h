//
//  SUPAuthExceptionUtil.h
//  clientrt
//
//  Created by Jane Yang on 12/21/11.
//  Copyright (c) 2011 Sybase, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SUPSynchronizeException.h"

#ifndef AUTHENTICATION_VALUES
#define AUTHENTICATION_VALUES
#define PACKAGE_DISABED_CODE 3000
#define UPGRADE_NOT_FINISH_CODE 3001
#define PV_NOT_COMPATIBLE_CODE 3002
#define APP_PACKAGE_NOT_MATCH_CODE 3003
#define APP_CONN_NOT_MATCH_CODE 3004
#define APP_CONN_LOCKED 3005
#define FAILURE_CODE_TOKEN_VALIDATION_ERROR 3006
#define FAILURE_CODE_IMPERSONATION_ERROR 3007
#define PACKAGE_DISABLED_MSG @"Package is disabled on server."
#define UPGRADE_NOT_FINISH_MSG @"The server upgrade is not finished."
#define PV_NOT_COMPATIBLE_MSG @"The client's protocol version is bigger than the server's protocol version"
#define APP_PACKAGE_NOT_MATCH_MSG @"The application doesn't match with the package"
#define APP_CONN_NOT_MATCH_MSG @"The application connection doesn't match with the application id"
#define APP_CONN_LOCKED_MSG @"The application connection is locked"
#define FAILURE_CODE_TOKEN_VALIDATION_ERROR_MSG @"Authentication failed because the token validation failed"
#define FAILURE_CODE_IMPERSONATION_ERROR_MSG @"Authentication failed because the username does not match the specified token/certificate"
#endif

@interface SUPAuthExceptionUtil : NSObject
+ (void) checkAuthValueAfterSync: (int)authValue:(SUPSynchronizeException*)ex;
@end
