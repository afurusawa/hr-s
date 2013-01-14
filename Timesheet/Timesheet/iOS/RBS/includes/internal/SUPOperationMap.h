#import "sybase_sup.h"

@class SUPObjectList;
@class SUPStringList;

@class SUPOperationMap;

@interface SUPOperationMap : NSObject

@property(readwrite, retain, nonatomic) SUPObjectList* operations;

+ (SUPOperationMap*)getInstance;
- (void)add:(SUPString)key:(id)value;
- (void)remove:(SUPString)key;
- (void)clear;
- (SUPBoolean)containsKey:(SUPString)key;
- (id)item:(SUPString)key;
- (SUPStringList*)keys;
- (SUPObjectList*)values;

@end
