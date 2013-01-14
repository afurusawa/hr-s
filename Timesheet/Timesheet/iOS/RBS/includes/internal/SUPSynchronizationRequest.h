//
//  SUPSynchronizationRequest.h
//  clientrt
//
//  Created by Jane Yang on 12/21/11.
//  Copyright (c) 2011 Sybase, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum
{
	SyncRequestStatus_INACTIVE          = 0,
	SyncRequestStatus_QUEUED            = 1,
	SyncRequestStatus_CANCELLED         = 2,
    SyncRequestStatus_ACTIVE            = 3
} SyncRequestStatus;

#define SUPSynchronizationRequest_UPLOADONLYSYNC      0x0
#define SUPSynchronizationRequest_FULLSYNC            0x1
#define SUPSynchronizationRequest_ASYNCLASTDOWNLOAD   0x2

@class SUPObjectList;

@interface SUPSynchronizationRequest : NSObject
{
    @private
    SUPObjectList *     syncGroups;
    SyncRequestStatus   syncReqStatus;
    int                 syncReqMode;
    id                  userContext;
}
@property(readwrite, retain, nonatomic) SUPObjectList *syncGroups;
@property(readwrite, retain, nonatomic) id  userContext;
@property(readwrite, assign, nonatomic) int syncReqMode;
@property(readwrite, assign, nonatomic) SyncRequestStatus syncReqStatus;
+ (SUPSynchronizationRequest*) getInstance;
- (id) initWithParams:(SUPObjectList*)sgs :(id)context :(int)syncMode;
- (void)dealloc;
@end
