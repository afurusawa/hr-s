//
//  SUPReadWriteThread.h
//  clientrt
//
//  Created by Jane Yang on 12/19/11.
//  Copyright (c) 2011 Sybase, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark -
#pragma mark Wrapper class to represent a thread - either waiting for a lock or already has one

@interface SUPReadWriteThread : NSObject {
    
    NSThread *_thread;
    int32_t _lockCount;
    NSCondition *_condition;
}

@property(readwrite,retain,nonatomic) NSThread *thread;
@property(readwrite,assign,nonatomic) int32_t lockCount;
@property(readwrite,retain,nonatomic) NSCondition *condition;

- (SUPReadWriteThread*)init;
- (SUPReadWriteThread*)initWithThread:(NSThread *)thread andCount:(int32_t)count;
- (NSString*)description;

@end

