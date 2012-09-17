//
//  SUPAbstractLocalEntity.h
//  clientrt
//
//  Created by Jane Yang on 9/8/11.
//  Copyright 2011 Sybase, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SUPAbstractStructure.h"
#import "sybase_sup.h"
#import "SUPLocalEntityDelegate.h"
#import "SUPEntityDelegate.h"
#import "SUPStatementWrapper.h"

#define OP_CREATE           0
#define OP_UPDATE           1
#define OP_DELETE           2
#define OP_SAVE             3
#define OP_SUBMIT_PENDING   4
#define OP_UPDATE_STATUS    5
#define OP_UPDATE_REPLAY_COUNTER    6
#define OP_CANCEL_PENDING   7
#define OP_REPLAY_FAILURE   8
#define OP_CANCEL_OS_PENDING    9

@class SUPEntityDelegate;
@interface SUPAbstractLocalEntity : SUPAbstractStructure
{
    
}
- (void)save;
- (void)refresh;
- (void) create;
- (void) update;
- (void) delete;
- (void)setEntityDelegate:(SUPEntityDelegate*)newEntityDelegate;
- (SUPObjectList*) getChildren:(SUPRelationshipMetaData*) amd:(BOOL)pendingOnly:(BOOL)enableSubmitOnly;
-(SUPQuery*) initChildrenQuery:(SUPQuery*)query :(SUPStringList*)keys;
@end
@interface SUPAbstractLocalEntity (internal)
- (SUPLocalEntityDelegate*)getEntityDelegate;
//- (void)setEntityDeletgate:(SUPEntityDelegate*)newEntityDelegate;
- (int)bindToStatement:(id<SUPStatementWrapper>) sw withAttribute:(SUPAttributeMetaDataRBS *)amd atIndex:(NSInteger)index;
- (void)bindCUD:(id<SUPStatementWrapper>) sw withType:(int)type;
- (id)cloneAll;
- (SUPString)generateCreateStatement;
- (SUPString)getCreateSQL;
- (SUPString)generateUpdateStatement;
- (SUPString)getUpdateSQL;
- (SUPString)generateDeleteStatement;
- (SUPString)getDeleteSQL;
- (void) cascadeSave;
- (void) cascadeDelete;
- (void)cascadeOpToChild:(int) opType withData:(id)data withEntity:(SUPAbstractLocalEntity*)childMBO;
- (BOOL)cascade:(int)opType :(id)data;
- (void) createCore;
- (void) updateCore;
- (void) deleteCore;
- (id) i_pk;
- (SUPString) keyToString;
- (void) bindNames:(SUPStringList*)names withResultSet:(id<SUPResultSetWrapper>)rs;
- (void) bindAttributes:(SUPObjectList*)attrList withResultSet:(id<SUPResultSetWrapper>)rs skipLazyLoad:(BOOL)skipLazyLoad;
-(void) writeJson:(SUPJsonObject*)obj;
- (void)writeJsonAssociation:(SUPJsonObject *) obj:(SUPRelationshipMetaData *) relationship;
- (BOOL) isUserDefinedInPK:(SUPAttributeMetaDataRBS*)amd;
- (void) refreshSelfOnly;
@end
