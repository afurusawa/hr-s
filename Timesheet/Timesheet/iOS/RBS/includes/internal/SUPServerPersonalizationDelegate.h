//
//  SUPServerPersonalizationDelegate.h
//  clientrt
//
//  Created by Jane Yang on 11/10/11.
//  Copyright (c) 2011 Sybase, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SUPDatabaseDelegate;
@protocol SUPResultSetWrapper;
@class SUPServerPersonalization;
@class SUPObjectList;

@interface SUPServerPersonalizationDelegate : NSObject
{
    @private
    SUPDatabaseDelegate *dbDelegate;
}
@property(readwrite, retain, nonatomic)SUPDatabaseDelegate *dbDelegate;
- (SUPServerPersonalizationDelegate*)initWithDbDelegate:(SUPDatabaseDelegate*)db_delegate;
- (void)dealloc;
- (void)bind:(id<SUPResultSetWrapper>)rs :(SUPServerPersonalization*)sp;
- (void)copyAll:(SUPServerPersonalization*)fromEntity :(SUPServerPersonalization*)toEntity;
- (void)create:(SUPServerPersonalization*)sp;
- (void)update:(SUPServerPersonalization*)sp;
- (void)delete:(SUPServerPersonalization*)sp;
- (void)submitPending:(SUPServerPersonalization*)sp;
- (void)refresh:(SUPServerPersonalization*)sp;
- (SUPObjectList*)findAll;
@end
