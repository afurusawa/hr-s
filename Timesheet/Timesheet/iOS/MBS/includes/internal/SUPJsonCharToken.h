#import "sybase_core.h"

@class SUPStringUtil;
@class SUPJsonCharToken;

@interface SUPJsonCharToken : NSObject
{
    SUPChar _value;
}

+ (SUPJsonCharToken*)getInstance;
- (SUPJsonCharToken*)init;
@property(assign,nonatomic) SUPChar value;
- (SUPString)toString;
- (SUPJsonCharToken*)finishInit;
- (void)dealloc;

+ (SUPJsonCharToken*)leftBracket;
+ (SUPJsonCharToken*)rightBracket;
+ (SUPJsonCharToken*)leftCurlyBrace;
+ (SUPJsonCharToken*)rightCurlyBrace;
+ (SUPJsonCharToken*)comma;
+ (SUPJsonCharToken*)colon;


@end
