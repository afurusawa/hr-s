//
//  SUPSqlTrace.h
//  clientrt
//
//  Created by Jane Yang on 10/27/11.
//  Copyright 2011 Sybase, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SUPConnectionProfile.h"
#import "SUPJsonObject.h"
// Log levels:
// DEBUG > INFO > WARN > ERROR > FATAL > OFF
/*!
 @defined
 @abstract   No logging.
 @discussion Set for no logging in the system.
 */
#define TRACE_OFF		0

/*!
 @defined
 @abstract   Fatal logging.
 @discussion Set for Fatal logging only.
 */
#define TRACE_FATAL	1

/*!
 @defined
 @abstract   Error logging.
 @discussion Set for Error or Fatal logging in the system.
 */
#define TRACE_ERROR	2

/*!
 @defined
 @abstract   Warning logging.
 @discussion Set for Warning, Error or Fatal logging in the system.
 */
#define TRACE_WARN	3

/*!
 @defined
 @abstract   Informational logging.
 @discussion Set for info, warning, error or fatal logging in the system.
 */
#define TRACE_INFO	4

/*!
 @defined
 @abstract   Debug logging.
 @discussion Set for All logging in the system.
 */
#define TRACE_DEBUG	5

#define SQLTraceLogDebug(pf,s,...) \
[SUPSqlTrace log:pf :(s),##__VA_ARGS__]

#define SQLTraceLogDetail(pf,s,...) \
[SUPSqlTrace logWithDetail:pf :(s),##__VA_ARGS__]

#define SQLTraceLogThrowableError(pf,s,...) \
[SUPSqlTrace throwableError:pf :(s),##__VA_ARGS__]

#define MBSLog(pf,s,...) \
 [SUPSqlTrace mbsLog:pf :(s),##__VA_ARGS__]

#define MBSLogHeader(pf,j,t) \
 [SUPSqlTrace mbsLogJsonHeader:pf : j:t]

#define MBSLogContent(pf,j,t) \
[SUPSqlTrace mbsLogJsonContent:pf : j:t]

void SQLTraceLogPersistenceException(SUPConnectionProfile *pf, NSString* format, ...);

@interface SUPSqlTrace : NSObject {
    
}
+ (void) log:(SUPConnectionProfile*)profile :(NSString*)format, ...;
+ (void) error:(SUPConnectionProfile*)profile withThrow:(BOOL)throwable withMessage:(NSString*)message;
+ (void) logWithDetail:(SUPConnectionProfile*)profile:(NSString*)format, ...;
+ (BOOL) getEnabled:(SUPConnectionProfile*)profile;
+ (void) throwableError:(SUPConnectionProfile*)profile :(NSString*)format, ...;
+ (void) mbsLog:(SUPConnectionProfile*)profile :(NSString*)format, ...;
+ (void) mbsLogJsonHeader:(SUPConnectionProfile*)profile :(SUPJsonObject*)header :(NSString*)title;
+ (void) mbsLogJsonContent:(SUPConnectionProfile*)profile :(SUPJsonObject*)content:(NSString*)title;
+ (void) mbsLogJsonStreamedContent:(SUPConnectionProfile*)profile :(NSString*)content:(NSString*)title;
@end


