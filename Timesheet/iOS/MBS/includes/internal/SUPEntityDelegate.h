
#import <Foundation/Foundation.h>

#import "SUPLocalEntityDelegate.h"



typedef enum
{
    EntityState_NORMAL,
    EntityState_ORIGINAL,
    EntityState_DOWNLOAD
	
} SUPEntityState;

@class SUPAbstractEntityRBS;
@protocol SUPCallbackHandler; 
@protocol SUPOperationReplay;
@class SUPLocalEntityDelegate;
@class SUPEntityMetaDataRBS;

@interface SUPEntityDelegate : SUPLocalEntityDelegate {

    
}
@property (readwrite, retain, nonatomic) NSObject<SUPCallbackHandler>* callbackHandler;

- (id)initWithName:(NSString *)inEntityName clazz:(Class)inEntityClass metaData:(SUPEntityMetaDataRBS *)inMetadata dbDelegate:(SUPDatabaseDelegate*) inDBDelegate database:(SUPAbstractDBRBS*)db;
-(id)init;
-(void)dealloc;
-(SUPObjectList*)getPendingObjects;
-(SUPObjectList*)getPendingObjects:(int) skip:(int) take;
- (SUPObjectList*) getReplayPendingObjects;
- (void) submitPendingOperations;
- (void) cancelPendingOperations;
- (void)registerCallbackHandler:(NSObject<SUPCallbackHandler>*)handler;
//- (SUPObjectList*) findEntities:(SUPStringList*)names:(SUPObjectList*)values;
- (SUPObjectList*) findEntities:(SUPStringList*)paramNames withValues:(SUPObjectList*)values;
- (SUPObjectList*) findEntities:(SUPStringList*)names:(SUPObjectList*)values:(SUPEntityState)entityState;
- (void) unsubscribe_all_pull;
- (void) subscribe_pull:(SUPString)syncUser :(SUPObjectList*)paramVectors;
- (void)finishRbsReplayInternal:(id<SUPOperationReplay>)result;
@end

@interface SUPEntityDelegate () 
-(SUPString) replaceOSIfNeeded:(SUPString)sql :(BOOL)isOriginalState;
- (SUPAbstractEntityRBS*)findOS:(id)key;
@end
