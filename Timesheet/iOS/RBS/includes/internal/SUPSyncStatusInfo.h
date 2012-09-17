#import "sybase_sup.h"

typedef enum {
    SYNC_STATE_NONE     = 0,
    SYNC_STATE_STARTING =   1,
    SYNC_STATE_CONNECTING   =   2,
    SYNC_STATE_SENDING_HEADER   =   3,
    SYNC_STATE_SENDING_TABLE    = 4,
    SYNC_STATE_SENDING_DATA     = 5,
    SYNC_STATE_FINISHING_UPLOAD = 6,
    SYNC_STATE_RECEIVING_UPLOAD_ACK = 7,
    SYNC_STATE_RECEIVING_TABLE  = 8,
    SYNC_STATE_RECEIVING_DATA   = 9,
    SYNC_STATE_COMMITTING_DOWNLOAD  = 10,
    SYNC_STATE_SENDING_DOWNLOAD_ACK = 11,
    SYNC_STATE_DISCONNECTING    = 12,
    SYNC_STATE_DONE   = 13,
    SYNC_STATE_ERROR  = 14,
    SYNC_STATE_ROLLING_BACK_DOWNLOAD    = 15,
    SYNC_STATE_UNKNOWN      = 16
} SUPSyncStatusState ; 

@interface SUPSyncStatusInfo : NSObject {
    @public
    SUPSyncStatusState _state;
    NSString *_currentMBO;
    SUPLong _receivedBytes;
    SUPInt _receivedDeletes;
    SUPInt _receivedInserts;
    SUPInt _receivedUpdates;
    SUPLong _sentBytes;
    SUPInt _sentDeletes;
    SUPInt _sentInserts;
    SUPInt _sentUpdates;
}
@property(readwrite, retain, nonatomic) NSString *currentMBO;
@property(readwrite, assign) SUPSyncStatusState state;
@property(readwrite, assign) SUPLong    receivedBytes;
@property(readwrite, assign) SUPLong    sentBytes;
@property(readwrite, assign) SUPInt     receivedDeletes;
@property(readwrite, assign) SUPInt     receivedInserts;
@property(readwrite, assign) SUPInt     receivedUpdates;
@property(readwrite, assign) SUPInt     sentDeletes;
@property(readwrite, assign) SUPInt     sentInserts;
@property(readwrite, assign) SUPInt     sentUpdates;

- (id)initWithData:(SUPSyncStatusState) syncState withMBO:(NSString*)mbo withRcvdByte:(SUPLong)rbytes withSndByte:(SUPLong)sbytes withRcvdD:(SUPInt)rd withRcvdI:(SUPInt)ri withRcvdU:(SUPInt)ru withSndD:(SUPInt)sd withSndI:(SUPInt)si withSndU:(SUPInt)su;
-(void)dealloc;
@end
