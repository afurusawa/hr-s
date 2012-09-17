#import "sybase_sup.h"

@class SUPObjectList;
@class SUPAttributeMap;
@class SUPAttributeMetaDataRBS;
@class SUPOperationMap;
@class SUPOperationMetaData;
@class SUPClassDelegate;
@class SUPAbstractStructure;

@interface SUPClassMetaDataRBS : NSObject

@property(readwrite, assign, nonatomic) SUPInt id;
@property(readwrite, retain, nonatomic) SUPString name;
@property(readwrite, retain, nonatomic) SUPObjectList* attributes;
@property(readwrite, retain, nonatomic) SUPObjectList* operations;
@property(readwrite, retain, nonatomic) SUPAttributeMap* attributeMap;
@property(readwrite, retain, nonatomic) SUPOperationMap* operationMap;
@property(readwrite, retain, nonatomic) SUPClassDelegate *delegate;
@property(readwrite, assign, nonatomic) BOOL allowPending;
@property(readwrite, assign, nonatomic) Class klass;
@property(readwrite, assign, nonatomic) BOOL useOldValue;
@property(readwrite, assign, nonatomic) BOOL superClassDefined;

- (SUPBoolean)isEntity;
- (SUPBoolean)isService;
- (SUPAttributeMetaDataRBS*)tryGetAttribute:(SUPString)inName;
- (SUPAttributeMetaDataRBS*)getAttribute:(SUPString)name;
- (SUPOperationMetaData*)getOperation:(SUPString)name;
- (SUPAbstractStructure*) getInstance;
@end
