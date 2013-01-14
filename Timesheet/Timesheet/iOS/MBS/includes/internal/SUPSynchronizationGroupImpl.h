//
//  SUPSynchronizationGroupImpl.h
//  clientrt
//
//  Created by Jane Yang on 12/21/11.
//  Copyright (c) 2011 Sybase, Inc. All rights reserved.
//

#import "SUPSynchronizationGroup.h"
@class  SUPDatabaseDelegate;
@class SUPSISSubscription;

@interface SUPSynchronizationGroupImpl : NSObject<SUPSynchronizationGroup>
{
    @protected
    SUPDatabaseDelegate *delegate;
    SUPSISSubscription  *sisSubscription;
}
@property(readwrite,retain,nonatomic) SUPDatabaseDelegate *delegate;
@property(readwrite,retain,nonatomic) SUPSISSubscription  *sisSubscription;

+ (id<SUPSynchronizationGroup>) getInstance:(NSString*)name withDBDelegate:(SUPDatabaseDelegate*)dbDelegate;
- (id)init:(NSString*)name :(SUPDatabaseDelegate*)dbDelegate;
- (void) dealloc;
@end
