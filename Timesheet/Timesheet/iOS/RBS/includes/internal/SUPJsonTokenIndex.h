#import "sybase_core.h"

@class SUPJsonTokenIndex;

@interface SUPJsonTokenIndex : NSObject
{
    SUPInt _index;
}

+ (SUPJsonTokenIndex*)getInstance;
- (SUPJsonTokenIndex*)init;
@property(assign,nonatomic) SUPInt index;
- (void)dealloc;

@end
