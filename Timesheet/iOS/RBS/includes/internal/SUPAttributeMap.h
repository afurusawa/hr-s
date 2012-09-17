#import "sybase_sup.h"

@class SUPObjectList;
@class SUPStringList;

@class SUPAttributeMap;

@interface SUPAttributeMap : NSObject

@property(readwrite, retain, nonatomic) SUPObjectList* attributes;

+ (SUPAttributeMap*)getInstance;
- (void)add:(SUPString)key:(id)value;
- (void)remove:(SUPString)key;
- (void)clear;
- (SUPBoolean)containsKey:(SUPString)key;
- (id)item:(SUPString)key;
- (SUPStringList*)keys;
- (SUPObjectList*)values;
- (void)dealloc;
- (SUPAttributeMap*)finishInit; 
@end
