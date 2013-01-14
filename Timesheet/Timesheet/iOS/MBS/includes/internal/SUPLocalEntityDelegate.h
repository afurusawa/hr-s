//
//  SUPLocalEntityDelegate.h
//  clientrt
//
//  Created by Jane Yang on 9/9/11.
//  Copyright 2011 Sybase, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SUPClassDelegate.h"


@class SUPAbstractLocalEntity;
@class SUPQueryResultSet;
@protocol SUPStatementWrapper;
@class SUPQuery;
@class SUPEntityMetaDataRBS;

@interface SUPLocalEntityDelegate : SUPClassDelegate
{
    @private
    SUPObjectList   *_findAllAttrList;
    SUPObjectList   *_relationAttrList;
    SUPString       _findAllQuery;
}
@property(readwrite, retain, nonatomic) SUPObjectList   *findAllAttrList;
@property(readwrite, retain, nonatomic) SUPObjectList   *relationAttrList;
@property(readwrite, retain, nonatomic) NSString   *findAllQuery;

- (id)initWithName:(NSString *)inEntityName clazz:(Class)inEntityClass metaData:(SUPEntityMetaDataRBS *)inMetadata dbDelegate:(SUPDatabaseDelegate*) inDBDelegate database:(SUPAbstractDBRBS*)db;
- (SUPAbstractLocalEntity*) findEntityWithKey:(id) key;
- (SUPAbstractLocalEntity*) findEntityWithKeys:(SUPObjectList*)keys;
- (SUPObjectList*) findEntities:(SUPStringList*)paramNames withValues:(SUPObjectList*)values;
- (SUPObjectList*)findWithQuery:(SUPQuery*)query :(Class)entityClass;
- (SUPObjectList*)findWithSQL:(SUPString)sql :(Class)entityClass:(int)skip:(int)take;
- (SUPQueryResultSet*)findWithSQL:(SUPString)sql withDataTypes:(SUPObjectList*)dataTypes withValues:(SUPObjectList*)values withColumns:(SUPStringList*)columns withColumnTypes:(SUPObjectList*)columnTypes withSkip:(int)skip withTake:(int)take;
- (id)findWithSQL:(SUPString)sql withDataTypes:(SUPObjectList*)dataTypes withValues:(SUPObjectList*)values withIDs:(SUPStringList*)ids withClass:(Class)entityClass;
- (SUPObjectList*)findWithSQL:(SUPString)sql withDataTypes:(SUPObjectList*)dataTypes withValues:(SUPObjectList*)values withIDs:(SUPStringList*)ids withSkip:(int)skip withTake:(int)take withClass:(Class)entityClass;
- (SUPObjectList*)findEntitiesWithParams:(SUPString)attrName:(id)value;
- (int) getSize:(SUPQuery*)query;
- (void) bindParameterInStmtWrapper:(id<SUPStatementWrapper>)sw withIndex:(int)index withDataType:(SUPDataType*)dataType withValue:(id)value;
- (SUPObjectList*)readResultSet:(id<SUPStatementWrapper>)ps withMetaData:(SUPObjectList*)attrList;
- (SUPAbstractLocalEntity*)getEntity;
- (SUPAbstractLocalEntity*)load:(id)entityKeys;
- (SUPAbstractStructure*)getKeyObject;
- (void) dealloc;
@end
