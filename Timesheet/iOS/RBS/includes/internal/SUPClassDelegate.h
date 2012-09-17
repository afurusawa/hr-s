//
//  SUPClassDelegate.h
//  clientrt


#import <Foundation/Foundation.h>
//#import "SUPClassMetaData.h"
//#import "SUPDatabaseDelegate.h"
//#import "SUPAbstractStructure.h"
#import "sybase_sup.h"

@class SUPDatabaseDelegate;
@class SUPAbstractStructure;
@class SUPAbstractDBRBS;
@class SUPJsonArray;
@class SUPJsonObject;
@class SUPClassMetaDataRBS;
@class SUPObjectList;

@interface SUPClassDelegate : NSObject

@property (readwrite, retain, nonatomic) SUPClassMetaDataRBS *metaData;
@property (readwrite, retain, nonatomic) SUPDatabaseDelegate *dbDelegate;
@property (readwrite, retain, nonatomic) SUPAbstractDBRBS *database;
@property (readwrite, retain, nonatomic) Class clazz;

//@property (readwrite, retain, nonatomic) NSObject<SUPCallbackHandler> *callbackHandler;

- (id)initWithName:(NSString *)inEntityName clazz:(Class)inEntityClass metaData:(SUPClassMetaDataRBS *)inMetadata dbDelegate:(SUPDatabaseDelegate*) inDBDelegate database:(SUPAbstractDBRBS*)db;
- (void)copyAll:(SUPAbstractStructure *)toEntity from:(SUPAbstractStructure *)fromEntity;
- (SUPAbstractStructure *)fromJsonObject:(SUPJsonObject *) obj;
- (SUPObjectList *)fromJsonArray:(SUPJsonArray *)array1;
- (SUPJsonArray*) toJsonArray:(SUPObjectList *)list;
- (SUPJsonObject*)toJsonObject:(SUPAbstractStructure *)entity;
/*
- (void)submitPendingOperations;
- (void)cancelPendingOperations;
- (void)fillAndCheckPendingObjects;
*/
- (void)dealloc;
- (void)copyAll:(SUPAbstractStructure *)toEntity from:(SUPAbstractStructure *)fromEntity withSelfOnly: (BOOL)selfonly;
@end
