#import "sybase_sup.h"

@class SUPObjectList;
@class SUPStringList;

@class SUPEntityMap;

@interface SUPEntityMap : NSObject
@property(readwrite, retain, nonatomic) SUPObjectList* entities;

+ (SUPEntityMap*)getInstance;
- (void)add:(SUPString)key:(id)value;
- (void)remove:(SUPString)key;
- (void)clear;
- (SUPBoolean)containsKey:(SUPString)key;
- (id)item:(SUPString)key;
- (SUPStringList*)keys;
- (SUPObjectList*)values;

@end
