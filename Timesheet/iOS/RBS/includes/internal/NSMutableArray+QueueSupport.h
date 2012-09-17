//
//  NSMutableArray+QueueSupport.h
//  clientrt
//
//  Created by Jane Yang on 12/19/11.
//  Copyright (c) 2011 Sybase, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (QueueSupport)

- (id) headOfQueue;
- (id) deQueue;
- (void) enQueue:(id)obj;

@end

typedef NSMutableArray SUPQueue;
