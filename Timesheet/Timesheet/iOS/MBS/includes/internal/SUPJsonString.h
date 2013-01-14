#import "sybase_core.h"

@class SUPStringList;
@class SUPStringUtil;

@class SUPJsonString;

@interface SUPJsonString : NSObject
{
    SUPString _value;
}

+ (SUPJsonString*)getInstance;
- (SUPJsonString*)init;
- (SUPString)value;
- (void)setValue:(SUPString)_value;
@property(readwrite, copy,nonatomic) SUPString value;
- (SUPString)toString;
- (SUPJsonString*)finishInit;
- (void)dealloc;

+ (SUPJsonString*)emptyString;

@end
