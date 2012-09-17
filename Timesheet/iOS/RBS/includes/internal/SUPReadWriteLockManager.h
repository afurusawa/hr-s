//
//  SUPReadWriteLockManager.h
//  clientrt
//
//  Created by Jane Yang on 12/19/11.
//  Copyright (c) 2011 Sybase, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol SUPReadWriteLockManager
@property (nonatomic, assign) int32_t maxReaders;
@property(readwrite,retain, nonatomic) NSCondition *condition;
/*
 * @method
 * @abstract Acquire a read lock.  The caller will block until the lock is acquired.
 */
- (void)readLock;
/*
 * @method
 * @abstract Acquire a write lock.  The caller will block until the lock is acquired.
 * @discussion If the calling thread's outermost lock is a read lock, this method throws an exception.
 * @throws NSException
 */
- (void)writeLock;

/*
 * @method
 * @abstract Unlock the most recent lock made by the calling thread.
 * @discussion If the calling thread has no lock, this method throws an exception.
 * @throws NSException
 */
- (void)unlock;
- (id)init;
- (void)dealloc;
- (oneway void)release;
- (id)retain;
@end
