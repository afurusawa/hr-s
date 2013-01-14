//
//  SUPSynchronizationRequestQueue.h
//  clientrt
//
//  Created by Jane Yang on 12/22/11.
//  Copyright (c) 2011 Sybase, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SUPArrayList.h"
@class SUPSynchronizationRequest;
@class SUPObjectList;
@interface SUPSynchronizationRequestQueue : SUPArrayList
{
    @private
    NSCondition     *_condition;
}
@property(readwrite,retain, nonatomic) NSCondition *condition;

+ (SUPSynchronizationRequestQueue*)getInstance;
- (id) init;
- (void) dealloc;
- (void) enqueue:(SUPSynchronizationRequest*)request;
- (SUPSynchronizationRequest*)dequeue;
- (BOOL)peek;
- (int)size;
- (void)copyRequestsTo:(SUPObjectList*)toArray;
- (void) clear;
@end
