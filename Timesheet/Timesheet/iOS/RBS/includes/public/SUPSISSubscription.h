/*
 
 Copyright (c) Sybase, Inc. 2012   All rights reserved.                                    
 
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
#import "sybase_sup.h"


@class SUPSISSubscriptionKey;
@class SUPObjectList;
@class SUPJsonObject;
@class SUPJsonArray;
@class SUPDatabaseDelegate;
@class SUPSynchronizationGroup;
@protocol SUPCallbackHandler;
@protocol SUPConnectionWrapper;
@protocol SUPResultSetWrapper;

@interface SUPSISSubscription : NSObject
{
@private
    NSString* _deviceId;
    NSString* _username;
    NSString* _appname;
    BOOL _enable;
    BOOL _adminLock;
    int32_t _interval;
    NSString* _protocol;
    NSString* _address;
    NSString* _domain;
    NSString* _package;
    NSString* _syncGroup;
    NSString* _clientId;
    SUPDatabaseDelegate *db_delegate;
    BOOL       _isNew;
    BOOL       _isDirty;
    BOOL       _isDeleted;
}
@property(retain,nonatomic) NSString* deviceId;
@property(retain,nonatomic) NSString* username;
@property(retain,nonatomic) NSString* appname;
@property(assign,nonatomic) BOOL enable;
@property(assign,nonatomic) BOOL adminLock;
@property(assign,nonatomic) int32_t interval;
@property(retain,nonatomic) NSString* protocol;
@property(retain,nonatomic) NSString* address;
@property(retain,nonatomic) NSString* domain;
@property(retain,nonatomic) NSString* package;
@property(retain,nonatomic) NSString* syncGroup;
@property(retain,nonatomic) NSString* clientId;
@property(retain,nonatomic) SUPDatabaseDelegate *db_delegate;
@property(assign,nonatomic) BOOL isNew;
@property(assign,nonatomic) BOOL isDirty;
@property(assign,nonatomic) BOOL isDeleted;

- (void) refresh;
+ (id) getInstance;
+ (id) getInstanceWithDBDelegate:(SUPDatabaseDelegate*)delegate;
- (SUPSISSubscriptionKey*) _pk;
- (NSString*) keyToString;
//- (BOOL) equals:(SUPSISSubscription*)that;
//- (int) hashCode;
- (void) copyAll:(SUPSISSubscription*)entity;
+ (void) registerCallbackHandler:(NSObject<SUPCallbackHandler>*)newCallbackHandler;
+ (NSObject<SUPCallbackHandler>*) callbackHandler;
- (SUPSISSubscription*) find:(SUPSISSubscriptionKey*)id_;
- (void)bind:(id<SUPResultSetWrapper>)resultSet;
- (SUPSISSubscription*) load:(SUPSISSubscriptionKey*)id_;
- (void) save;
- (SUPSISSubscription*) merge:(SUPSISSubscription*)entity;
- (void) create;
- (void) delete;
- (void) update;
- (SUPSynchronizationGroup*) getSynchronizationGroup;
- (SUPObjectList*)findAll:(int)skip:(int)take;
- (SUPObjectList*)findAll;
- (SUPObjectList*)getLogRecords;
- (void)fromJSON:(SUPJsonObject*)json;
+ (SUPSISSubscription*)fromJSON:(SUPJsonObject*)json;
+ (SUPJsonObject*)toJSON:(SUPSISSubscription*)object;
- (SUPJsonObject*)toJSON;
+ (SUPObjectList*)fromJSONList:(SUPJsonArray*)array;
+ (SUPJsonArray*)toJSONList:(SUPObjectList*)array;
- (void)dealloc;
- (id)init;
@end

@interface SUPSISSubscription (internal)
//+ (void) createTables:(id<SUPConnectionWrapper>)connection;
@end