#import "sybase_core.h"

@class SUPJsonObject;

@class SUPBase64EncodingException;

@interface SUPBase64EncodingException : NSException
{
    NSString *_message;
}

@property(readwrite,retain,nonatomic) NSString* message;

+ (SUPBase64EncodingException*)getInstance;
- (SUPBase64EncodingException*)init;
- (SUPBase64EncodingException*)finishInit;
- (void)dealloc;
+ (SUPBase64EncodingException*)withMessage:(NSString*)theMessage;
- (NSString*)name;
- (NSString*)reason;
- (NSString*)description;

@end
