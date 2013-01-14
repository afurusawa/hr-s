//
//  SUPDatabaseDelegate.h
//  clientrt
//
//  Created by Scott Kovatch on 8/1/11.
//  Copyright 2011 Sybase. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SUPDatabaseMetaDataRBS.h"
#import "SUPConnectionProfile.h"
#import "SUPCallbackHandler.h"
#import "SUPConnectionWrapper.h"
#import "SUPLogger.h"
#import "SUPQueryResultSet.h"
#import "SUPOnlineLoginStatus.h"
#import "SUPAbstractDBRBS.h"
#import "SUPJsonObject.h"
#import "SUPEntityDelegate.h"

@class SUPAbstractPersonalizationParameters;
@class SUPServerPersonalizationDelegate;
@class SUPSynchronizationRequestQueue;
@class SUPJsonMessage;

@interface SUPDatabaseDelegate : NSObject {
    @private
    SUPAbstractPersonalizationParameters *personalizationParameters;
    BOOL    mSubscribed;
    BOOL    serviceStarted;
    SUPStringList    *syncSet;
    SUPStringList    *contextSet;
    int syncMode;
    SUPSynchronizationRequestQueue *srq;
    SUPSynchronizationRequestQueue *imq;
    BOOL isInsideCB;
    
    
}

@property (readwrite, retain, nonatomic) SUPAbstractDBRBS *database;
@property (readwrite, retain, nonatomic) SUPObjectList *classDelegates;
@property (readwrite, retain, nonatomic) NSMutableDictionary *delegateMap;
@property (readwrite, retain, nonatomic) SUPAbstractPersonalizationParameters *personalizationParameters;
@property (readwrite, retain, nonatomic) SUPServerPersonalizationDelegate *spDelegate;
@property (readwrite, retain, nonatomic) SUPSynchronizationRequestQueue *srq;
@property (readwrite, retain, nonatomic) SUPSynchronizationRequestQueue *imq;
@property (readwrite, retain, nonatomic) SUPString remoteId;

- (id)initWithDatabase:(SUPAbstractDBRBS *)inDatabase;

- (void)addDelegate:(SUPClassDelegate *)inDelegate forName:(NSString *)entityName;
- (SUPEntityDelegate *)getDelegate:(NSString*) entityName;

- (SUPLocalTransaction*)beginTransaction;
- (NSObject<SUPCallbackHandler>*)callbackHandler;
- (SUPConnectionProfile*)connectionProfile;
- (SUPConnectionProfile*)getConnectionProfile;
- (SUPConnectionProfile*)getSynchronizationProfile;
- (void)createDatabase;
- (void)createPublication:(SUPStringList *)statements withName:(SUPString)publicationName forTables:(SUPObjectList *)emdList;
- (SUPStringList *)sqlCreateStatements;
- (void)cleanAllData:(BOOL) keepClientOnly;
- (void)cleanAllData;
- (void)deleteDatabase;
- (BOOL)databaseExists;
- (id<SUPConnectionWrapper>)getConnectionWrapper;
- (void)openConnection;
- (void)closeConnection;
- (NSString*)getSyncUsername;
- (NSString*)getDomainName;
- (int32_t)getSchemaVersion;
- (int32_t)getProtocolVersion;
- (id<SUPLogger>)getLogger;
- (SUPOnlineLoginStatus*)getOnlineLoginStatus;
//- (NSObject<SUPSynchronizationGroup> *)getSyncGroupForName:(NSString*)_name;
- (void)registerCallbackHandler:(NSObject<SUPCallbackHandler>*)handler;

- (void)loginToSync:(NSString *)user password:(NSString *)pass;
//- (void)beginOnlineLogin:(NSString *)user password:(NSString *)pass;
//- (void)beginOnlineLogin;
- (BOOL)offlineLogin:(NSString *)user password:(NSString *)pass;
//- (BOOL)offlineLogin;
- (void)resumeSubscription;
- (void)subscribe;
- (id<SUPSynchronizationGroup>) getSynchronizationGroup:(NSString*)name;
- (void)beginSynchronize;
- (void)beginSynchronizeForGroups:(SUPObjectList*)synchronizationGroups withContext:(id)context;
- (void)beginSynchronizeForGroups:(SUPObjectList*)inSynchronizationGroups withContext:(id)context withUploadOnly:(BOOL)uploadOnly;
- (void)submitPendingOperations;
- (void)submitPendingOperations:(NSString*)synchronizationGroup;
- (void)cancelPendingOperations;
- (void)cancelPendingOperations:(NSString*)synchronizationGroup;
//- (BOOL)hasPendingOperations;
- (void)suspendSubscription;
- (void)recover;
- (void)unsubscribe;
- (BOOL)isSubscribed;
- (int64_t)generateId;
- (int64_t)generateLocalId;
- (void)changeEncryptionKey:(NSString *)newKey;
//- (SUPObjectList*)getLogRecords:(SUPQuery*)query;
//- (void)submitLogRecords;
- (BOOL) initialSync;
- (BOOL)onlineLogin:(NSString *)user password:(NSString *)pass;
- (void)synchronize:(NSString*)syncGroups_param;

- (void)synchronize;
- (void)synchronizeWithListener:(id<SUPSyncStatusListener>) listener;

- (void)synchronize:(NSString *)synchronizationGroup withListener:(id<SUPSyncStatusListener>)listener;
-(NSString*)scriptVersion;
- (void)generateEncryptionKey;
- (void)handleRbsPushMessage:(SUPJsonMessage*)message;
- (BOOL) isReplayQueueEmpty;
- (SUPObjectList*) getBackgroundSyncRequests;
- (SUPObjectList*)getChangeLogs:(SUPQuery*)query;
+ (void) findAndCheckPendingObjects : (SUPObjectList*)reverseList :(SUPObjectList*)mboList;
- (NSString*) getRemoteId;
- (void)traceSynchronize:(SUPConnectionProfile*)profile synchronizationGroup:(SUPString)synchronizationGroup userContext:(SUPString)userContext remoteId:(SUPString)remoteId;
@end
