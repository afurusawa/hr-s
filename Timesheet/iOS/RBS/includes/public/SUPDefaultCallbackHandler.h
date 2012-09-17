/*
 
 Copyright (c) Sybase, Inc. 2010   All rights reserved.
 
 In addition to the license terms set out in the Sybase License Agreement for
 the Sybase Unwired Platform (Program), the following additional or different
 rights and accompanying obligations and restrictions shall apply to the source
 code in this file (Code).  Sybase grants you a limited, non-exclusive,
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

#import "sybase_sup.h"

#import "SUPCallbackHandler.h"

@class SUPConnectionProfile;
@class SUPDefaultCallbackHandler;



/*!
 @class SUPDefaultCallbackHandler
 @abstract   Superclass for implementation of a callback handler.  
 @discussion This class implements the protocol defined in @link //apple_ref/occ/intf/SUPCallbackHandler SUPCallbackHandler @/link, providing empty implementations of all the required methods. Application programmers should implement a custom subclass to register for the interested events. The callback will be invoked on the thread that is processing the event.  The callback handler should be registered with the generated package database class, and may also be registered with generated MBO classes.
 */

@interface SUPDefaultCallbackHandler : NSObject<SUPCallbackHandler> {
}

/*!
    @method     
    @abstract   Returns a new instance of SUPDefaultCallbackHandler.
    @discussion 
*/

+ (SUPDefaultCallbackHandler*)getInstance;

/*!
 @method     
 @abstract   (Deprecated) Returns a new instance of SUPDefaultCallbackHandler.
 @discussion This method is deprecated. use getInstance instead.
 */

+ (SUPDefaultCallbackHandler*)newInstance DEPRECATED_ATTRIBUTE NS_RETURNS_NON_RETAINED;

/*!
 @method
 @abstract Called at the beginning of processing a message from the server, before the message transaction starts.
 @param size The size of the incoming message content in bytes.
 @param method The method string from the message header.
 @param mbo If this message is for a specific MBO, the name of the MBO; otherwise null.
 @discussion This method will only be called on platforms using message-based synchronization.  Only the callback handler registered with the package database class will be invoked.
 */
- (void)onMessageStart:(int)size withMethod:(NSString*)method withMbo:(NSString*)mbo;

/*!
 @method     
 @abstract   Called before applying an import message to database.
 @param entityObject The Mobile Business Object to be imported
 @discussion  Both CallbackHandlers registered for the MBO class of the entity and Package DB will be invoked.
 */
- (void)beforeImport:(id)entityObject;

/*!
 @method     
 @abstract   Called when an import message is successfully applied to the local database.
 @param entityObject The object.
 @discussion This method will be invoked when an import message is successfully applied to local database. However, it is not committed. One message from server may have multiple import entities and they would be committed in one transaction for the whole message.<p>Note:</p><p><ul><li>Stale data may be read from database at this time before commit of the whole message. Programmers are encouraged to wait for the next onTransactionCommit() is invoked then to read from database to obtain the updated data.</li><li> Both CallbackHandlers registered for the MBO class of the entity and Package DB will be invoked.</li></ul></p>
 */
- (void)onImport:(id)entityObject;

/*!
 @method     
 @abstract   Callback method invoked on replay failure.
 @param entityObject The Mobile Business Object to replay.
 @discussion Note that both CallbackHandlers registered for the MBO class of the entity and Package DB will be invoked.
 */
- (void)onReplayFailure:(id)entityObject;

/*!
 @method     
 @abstract   Callback method invoked on replay success.
 @param entityObject The Mobile Business Object to replay..
 @discussion Note that both CallbackHandlers registered for the MBO class of the entity and Package DB will be invoked. 
 */
- (void)onReplaySuccess:(id)entityObject;

/*!
 @method     
 @abstract   Callback method invoked on search failure.
 @param entityObject The backend search object.
 @discussion This method is for DOE-based applications only.  Note that both CallbackHandlers registered for the MBO class of the entity and Package DB will be invoked.
 */
- (void)onSearchFailure:(id)entityObject;

/*!
 @method     
 @abstract   Callback method invoked on search success.
 @param entityObject The backend search object.
 @discussion This method is for DOE-based applications only.  Note that both CallbackHandlers registered for the MBO class of the entity and Package DB will be invoked.
 */
- (void)onSearchSuccess:(id)entityObject;

/*!
 @method     
 @abstract   Callback method invoked on login failure.
 @discussion This method will be invoked when login fails for a beginOnlineLogin call.  Only the callback handler registered for the package database class will be invoked.
 */
- (void)onLoginFailure;

/*!
 @method     
 @abstract   Callback method invoked on login success.
 @discussion This method will be invoked when login succeeds for a beginOnlineLogin call.  Only the callback handler registered for the package database class will be invoked.
 */
- (void)onLoginSuccess;

/*!
 @method     
 @abstract   Callback method invoked on recover failure.
 @discussion Only the callback handler registered with the package database class will be invoked.
 */
- (void)onRecoverFailure;

/*!
 @method     
 @abstract   Callback method invoked on recover success.
 @discussion Only the callback handler registered with the package database class will be invoked.
 */
- (void)onRecoverSuccess;

/*!
 @method     
 @abstract   Callback method invoked on subscribe failure.
 @discussion Only the callback handler registered with the package database class will be invoked.
 */
- (void)onSubscribeFailure;

/*!
 @method     
 @abstract   Callback method invoked on subscribe success.
 @discussion Only the callback handler registered with the package database class will be invoked.
 */
- (void)onSubscribeSuccess;

/*!
 @method     
 @abstract   Callback method invoked on synchronize failure (deprecated).
 @discussion 
 */
- (void)onSynchronizeFailure DEPRECATED_ATTRIBUTE;

/*!
 @method     
 @abstract   Callback method invoked on synchronize success (deprecated).
 @discussion 
 */
- (void)onSynchronizeSuccess DEPRECATED_ATTRIBUTE;

/*!
 @method     
 @abstract   Callback method invoked when synchronization status changes.
 @param syncGroupList List of affected synchronization groups.
 @param context The current synchronization context.
 @return An @link //apple_ref/occ/tdef/SUPSynchronizationStatus/SUPSynchronizationStatusType SUPSynchronizationStatusType @/link value (SUPSynchronizationAction_CANCEL or SUPSynchronizationAction_CONTINUE)
 @discussion This method will be invoked at different stages of the synchronization. The status of the synchronization context specifies the stage of the synchronization.  If SynchronizationAction_CANCEL is returned then the synchronize will be cancelled if the  the status of the synchronization context is SynchronizationStatus_STARTING.
 */
- (SUPSynchronizationActionType)onSynchronize:(SUPObjectList*)syncGroupList withContext:(SUPSynchronizationContext*)context;

/*!
 @method     
 @abstract   Callback method invoked when suspend subscription fails.
 @discussion Only the callback handler registered for the package database class will be invoked.
 */
- (void)onSuspendSubscriptionFailure;

/*!
 @method     
 @abstract   Callback method invoked when suspend subscription is successful.
 @discussion Only the callback handler registered for the package database class will be invoked.
 */
- (void)onSuspendSubscriptionSuccess;

/*!
 @method     
 @abstract   Callback method invoked when resume subscription fails.
 @discussion Only the callback handler registered for the package database class will be invoked.
 */
- (void)onResumeSubscriptionFailure;

/*!
 @method     
 @abstract   Callback method invoked when  resume subscription is successful.
 @discussion Only the callback handler registered for the package database class will be invoked.
 */
- (void)onResumeSubscriptionSuccess;

/*!
 @method     
 @abstract   Callback method invoked on unsubscribe failure.
 @discussion Only the callback handler registered for the package database class will be invoked.
 */
- (void)onUnsubscribeFailure;

/*!
 @method     
 @abstract   Callback method invoked on unsubscribe success.
 @discussion Only the callback handler registered for the package database class will be invoked.
 */
- (void)onUnsubscribeSuccess;

/*!
 @method     
 @abstract   Called when server has finished sending initial MBO data after the client has subscribed.
 @discussion Only the callback handler registered with the package database class will be invoked.
 */
- (void)onImportSuccess;

/*!
 @method     
 @abstract   Called when an exception occurs during message processing.
 @discussion Other callbacks in this interface (whose names begin with "on") are invoked inside a database transaction.  If the transaction will be rolled back due to an unexpected exception, this operation will be called with the exception (before rollback occurs). @link //apple_ref/occ/cl/SUPDefaultCallbackHandler SUPDefaultCallbackHandler @/link's onMessageException will rethrow the exception so that the messaging layer could retry the message. The application programmer has the option to implement a custom CallbackHandler NOT to rethrow the exception based on exception types or other conditions so that the message will not be retried. 
 */
- (void)onMessageException:(NSException*)e;

/*!
 @method     
 @abstract   This method will be invoked after one message has been processed and committed.
 @discussion This method is only called at the end of handling an incoming message from the server - not for client initiated database changes that involve database transactions. Normally, onTransactionCommit is called at the end of the message handling to indicate that all database operations for the message have completed. Only the callback handler registered with the package database class will be invoked.
 
 */
- (void)onTransactionCommit;

/*!
 @method     
 @abstract   This method will be invoked after one message has been rolled back. It only happens when an exception was thrown when processing the message or from a custom callback method.
 @discussion This method is only called at the end of handling an incoming message from the server - not for client initiated database changes that involve database transactions. If there is a database error or some other problem that throws an exception during incoming message handling, e.g. when importing data, onTransactionRollback will be called. Only the callback handler registered with the package database class will be invoked.
 */
- (void)onTransactionRollback;

/*!
 @method     
 @abstract   Callback method invoked when all data is cleared after a server reset message is received..
 @discussion Only the callback handler registered with the package database class will be invoked.
 */
- (void)onResetSuccess;

/*!
 @method     
 @abstract   Callback method invoked on subscription end.
 @discussion This method will be invoked when reregistered or unsubscribed. All MBO data on the device would have been wiped out when this method is invoked. Only the callback handler registered with the package database class will be invoked.
 */
- (void)onSubscriptionEnd;

/*!
 @method     
 @abstract   Callback method invoked when storage space is low.
 @discussion 
 */
- (void)onStorageSpaceLow;

/*!
 @method     
 @abstract   Callback method invoked when storage space is recovered.
 @discussion 
 */
- (void)onStorageSpaceRecovered;

/*!
 @method     
 @abstract   Callback method invoked on connection status change.
 @param connStatus The connection status.
 @param connType The connection type
 @param errorCode If an error condition exists, this will contain an error code.
 @param errorString If an error condition exists, this will contain a string describing the error.
 @discussion 
 */
- (void)onConnectionStatusChange:(SUPDeviceConnectionStatus)connStatus:(SUPDeviceConnectionType)connType:(int32_t)errorCode:(NSString*)errorString;
- (void)onApplicationConnectionPropertyChange:(SUPConnectionPropertyType)propName:(NSString*)propValue;
@end
