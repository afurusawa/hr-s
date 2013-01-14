/*
 
 Copyright (c) Sybase, Inc. 2010   All rights reserved.                                    
 
 In addition to the license terms set out in the Sybase License Agreement for 
 the Sybase Unwired Platform ("Program"), the following additional or different 
 rights and accompanying obligations and restrictions shall apply to the source 
 code in this file ("Code").  Sybase grants you a limited, non-exclusive, 
 non-transferable, revocable license to use, reproduce, and modify the Code 
 solely for purposes of (i) maintaining the Code as reference material to better
 understand the operation of the Program, and (ii) development and testing of 
 applications created in connection with your licensed use of the Program.  
 The Code may not be transferred, sold, assigned, sublicensed or otherwise 
 conveyed (whether by operation of law or otherwise) to another party without 
 Sybase's prior written consent.  The following provisions shall apply to any 
 modifications you make to the Code: (i) Sybase will not provide any maintenance
 or support for modified Code or problems that result from use of modified Code;
 (ii) Sybase expressly disclaims any warranties and conditions, express or 
 implied, relating to modified Code or any problems that result from use of the 
 modified Code; (iii) SYBASE SHALL NOT BE LIABLE FOR ANY LOSS OR DAMAGE RELATING
 TO MODIFICATIONS MADE TO THE CODE OR FOR ANY DAMAGES RESULTING FROM USE OF THE 
 MODIFIED CODE, INCLUDING, WITHOUT LIMITATION, ANY INACCURACY OF DATA, LOSS OF 
 PROFITS OR DIRECT, INDIRECT, SPECIAL, INCIDENTAL OR CONSEQUENTIAL DAMAGES, EVEN
 IF SYBASE HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGES; (iv) you agree 
 to indemnify, hold harmless, and defend Sybase from and against any claims or 
 lawsuits, including attorney's fees, that arise from or are related to the 
 modified Code or from use of the modified Code. 
 
*/


#import "SUPAbstractROEntity.h"
#import "SUPParameterMetaData.h"
#import "SUPAttributeMetaDataRBS.h"
#import "SUPEntityMetaDataRBS.h"
#import "SUPOperationMetaData.h"
#import "SUPDataType.h"
#import "SUPCallbackHandler.h"
#import "SUPDefaultCallbackHandler.h"
#import "SUPStatementWrapper.h"
#import "SUPConnectionWrapper.h"
#import "SUPResultSetWrapper.h"

@class SUPJsonArray;
@class SUPJsonObject;
@class SUPAbstractDBRBS;
@class SUPEntityDelegate;
@class SUPAbstractLocalEntity;

/*!
 @enum 
 @abstract   Enumeration of the possible values for the entity property pendingChange.
 @discussion 
 */
typedef enum
{
	RbsEntityPendingState_NotPending      = 'N',
	RbsEntityPendingState_PendingCreate   = 'C',
	RbsEntityPendingState_PendingUpdate   = 'U',
	RbsEntityPendingState_PendingDelete   = 'D',
	RbsEntityPendingState_HasPendingChild = 'P',
	RbsEntityPendingState_Snapshot        = 'S',
	
} RbsEntityPendingState;

/*!
 @enum 
 @abstract   Table identifiers for each entity -- used internally by SUP generated iPhone code.
 @discussion 
 */
/*
typedef enum
{
	MainEntityTable,
	OriginalStateEntityTable,
	
} SUPEntityTable;
*/
#define CREATE_OPERATION    @"create"
#define UPDATE_OPERATION    @"update"
#define DELETE_OPERATION    @"delete"
#define FIND_OPERATION     @"find"
#define FINDALL_OPERATION   @"findall"
#define SAVE_OPERATION      @"save"
#define FIND_CHILDREN_OPERATION     @"findChildren"
#define SUBMIT_OPERATION    @"submitPending"
#define CANCELPENDING_OPERATION     @"cancelPending"
#define RELPAYREJECT_OPERATION      @"replayReject"
#define SUP_ERROR_DOMAIN	@"SUPErrorDomain"

#define SUCCESS 0
#define UNKOWN_ERROR        1
#define INVALID_PARAMETER   2
#define DATABASE_ERROR      3
#define PKG_NOT_SUBSCRIBED  4

/*!
 @class SUPAbstractEntityRBS
 @abstract   This is the base class for all entity classes.The methods in this class are documented in each entity class.
 @discussion 
 */
// Base class for entity classes
@interface SUPAbstractEntityRBS : SUPAbstractROEntity
{
    @protected
        RbsEntityPendingState _pendingChange;
        int64_t               _replayCounter;
        int64_t               _replayPending;
        int64_t               _replayFailure;
        SUPAbstractEntityRBS*    _originalState;
        BOOL                  _originalStateValid;
        SUPAbstractEntityRBS*	  _downloadState;
        BOOL				  _downloadStateValid;
        BOOL				  _disableSubmit;
        BOOL                  _disableSubmitChanged;
        BOOL                  _isOriginalState;
        BOOL                  _pending;
    
    // Metadata defines the concrete subclass this abstract entity represents.
    //SUPEntityMetaDataRBS*	  _classMetadata;
}

/** Returns true if this a create operation is pending */
@property(readonly, assign, nonatomic) BOOL isCreated;

/** Returns true if this an update operation is pending */
@property(readonly, assign, nonatomic) BOOL isUpdated;

/** True for any row that represents a pending create, update, or delete operation (optionally also set for snapshot rows, and when pendingChange is 'P'). False otherwise. */
@property(readwrite, assign, nonatomic) BOOL pending;

/** If pending is true, then 'C' (create), 'U' (update), 'D' (delete), 'P' (to indicate that this row is a parent in a cascading relationship for one or more pending child objects,
 but this row itself has no pending create, update or delete operations) or 'S' (to indicate that this row is a snapshot row). If pending is false, then 'N'.*/
@property(readwrite, assign, nonatomic) RbsEntityPendingState pendingChange;

/** Updated each time a row is created or modified by the client.  This value is derived from the time in seconds since an epoch, so it always 
 ** increases each time the row is changed. */
@property(readwrite, assign, nonatomic) int64_t replayCounter;

/** When a pending row is submitted to the server, the value of replayCounter is copied to replayPending.  This allows client code to detect 
 ** if a row has been changed since it was submitted to the server --the test to look for : replayCounter > replayPending. */
@property(readwrite, assign, nonatomic) int64_t replayPending;

/** When the server responds with a replayFailure message for a row that was submitted to the server, the replayCounter value is copied to 
 ** replayFailure, and replayPending is set to 0. */
@property(readwrite, assign, nonatomic) int64_t replayFailure;

/* If set, changes in this entity will not be submitted to the server by a submitPending (or submitPendingOperations) call */
@property(readwrite, assign, nonatomic) BOOL disableSubmit;
@property(readwrite, assign, nonatomic) BOOL disableSubmitChanged;

// All entities know their own metadata.
//- (SUPEntityMetaDataRBS*)metaData;

/* The state of this entity as saved in the original state table */
@property(readwrite, retain, nonatomic) SUPAbstractEntityRBS* originalState;
@property(readwrite, assign, nonatomic) BOOL originalStateValid;
@property(readwrite, assign, nonatomic) BOOL isOriginalState;
/* The state of this entity at last download from the server, before any pending changes were made */
@property(readwrite, retain, nonatomic) SUPAbstractEntityRBS* downloadState;
@property(readwrite, assign, nonatomic) BOOL downloadStateValid;

- (void)cancelPending;
- (void)createPending:(BOOL)isPending;
- (void)create;
- (void)delete;
- (id)init;
- (BOOL)isPending;
- (void)refresh;
- (void)submitPending;
- (void)update;
/*abstract*/ + (NSObject<SUPCallbackHandler>*)callbackHandler;
/*abstract*/ + (void)registerCallbackHandler:(NSObject<SUPCallbackHandler>*)newCallbackHandler;
- (SUPString)getLastOperation;
- (SUPAbstractEntityRBS*)i_getDownloadState;
+ (SUPAbstractEntityRBS *)getInstanceWithClass:(Class)entityClass;

@end

@interface SUPAbstractEntityRBS()
+ (SUPQuery*)getLogRecordQuery:(NSString*)entityName:(NSString*)keyString;
- (void)updatePending:(BOOL)isPending;
- (void) cancelPending:(SUPNullableBoolean)forceDeleteChild;
- (void) update_os;
- (SUPAbstractEntityRBS*)i_getOriginalState;
- (void)deletePending:(BOOL)isPending;
- (void) deleteOSPending;
- (void)dealloc;

@end
