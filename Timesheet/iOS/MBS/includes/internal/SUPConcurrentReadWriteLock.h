//
//  SUPConcurrentReadWriteLock.h
//  clientrt
//
//  Created by Jane Yang on 12/19/11.
//  Copyright (c) 2011 Sybase, Inc. All rights reserved.
//

/*!
 @class SUPConcurrentReadWriteLock
 @abstract   This is a different class from SUPReadWriteLock.
 @discussion This lock class has the following properties:
 
 - Multiple threads may have a read lock simultaneously, up to a maximum determined by the maxReaders property.
 - Only one thread may have a write lock, and read threads can have read lock while the write lock is active.
 - Write thread can get write lock if there is no other write lock has been granted.
 - Requests for the lock are queued and processed in the order received, to avoid starvation of reader or writer threads.
 - The lock is recursive; a thread may have nested lock/unlock calls.
 - The recursive property has one restriction: if a thread first read locks, then attempts to write lock without first fully unlocking, an exception will be thrown.
 
 Author : janeyang
 */

#import "SUPReadWriteLockManager.h"

@interface SUPConcurrentReadWriteLock : NSObject<SUPReadWriteLockManager>
{
@private
    int32_t _maxReaders;
    NSMutableArray *_threads;
    NSMutableArray *_threadsWaiting;
    NSObject *_writeLockedBy;
    NSCondition *_condition;
}
/*
 * @property
 * @abstract The maximum number of threads allowed to have a read lock simultaneously.
 * @discussion Default value is -1 (no limit)
 *
 */
@property(readwrite,assign, nonatomic) int32_t maxReaders;
/*
 * @property
 * @abstract Internal property, not for external use.
 *
 */
@property(readwrite,retain,nonatomic) NSCondition *condition;
/*
 * @property
 * @abstract Internal property, not for external use.
 *
 */
@property(readwrite,retain,nonatomic) NSMutableArray *threads;
/*
 * @property
 * @abstract Internal property, not for external use.
 *
 */
@property(readwrite,retain,nonatomic) NSMutableArray *threadsWaiting;
/*
 * @property
 * @abstract Internal property, not for external use.
 *
 */
@property(readwrite,retain, nonatomic) NSObject *writeLockedBy;

- (SUPConcurrentReadWriteLock*)init;
- (void)dealloc;

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
@end
