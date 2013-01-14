//
//  SUPAbstractPersonalizationParameters.h
//  clientrt
//
//  Created by Jane Yang on 11/4/11.
//  Copyright (c) 2011 Sybase, Inc. All rights reserved.
//

#import "SUPAbstractStructure.h"

@class SUPObjectList;
@class SUPServerPersonalizationDelegate;
@class SUPClientPersonalizationDelegate;
@interface SUPAbstractPersonalizationParameters : SUPAbstractStructure
{
    @protected
    BOOL    hasServerPK;
    BOOL    hasClientPK;
    BOOL    needReload;
    NSString *clientPersonalizationTableName;
}
@property(readwrite, retain, nonatomic) NSString* clientPersonalizationTableName;
@property(readwrite, assign, nonatomic)BOOL hasServerPK;
@property(readwrite, assign, nonatomic)BOOL hasClientPK;
@property(readwrite, assign, nonatomic)BOOL needReload;
@property(readwrite, retain, nonatomic)SUPServerPersonalizationDelegate *serverDelegate;
@property(readwrite, retain, nonatomic)SUPClientPersonalizationDelegate *clientDelegate;
@property(readwrite, retain, nonatomic)NSMutableDictionary *sessions;
@property(readwrite, retain, nonatomic)SUPObjectList *servers;
@property(readwrite, retain, nonatomic)SUPObjectList *clients;

- (id) getValue:(NSString*)pk;
- (id) getDefaultValue:(NSString*)pk;
- (void) load;
-/*abstract*/(NSString*)username;
-/*abstract*/(void)setUsername:(NSString*)username;
-/*abstract*/(NSString*)password;
-/*abstract*/(void)setPassword:(NSString*)password;
- (void) save;
- (void) saveUserNamePassword;
- (NSDictionary*) getAllPersonalizationKeys;
- (void) reset;
- (void) reloadIfNeeded;
@end
