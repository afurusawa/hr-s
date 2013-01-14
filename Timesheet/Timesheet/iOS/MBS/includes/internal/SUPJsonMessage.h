#import "sybase_core.h"

@class SUPJsonObject;
@class SUPJsonReader;
@class SUPJsonValue;
@class SUPJsonInputStream;

@class SUPJsonMessage;

@interface SUPJsonMessage : NSObject
{
    SUPJsonObject* _headers;
    id _content;
    SUPJsonInputStream* _contentStream;
    int32_t _size;
}

+ (SUPJsonMessage*)getInstance;
- (SUPJsonMessage*)init;
@property(readwrite,retain,nonatomic) SUPJsonObject* headers;
@property(readwrite,retain,nonatomic) id content;
@property(readwrite,retain,nonatomic) SUPJsonInputStream* contentStream;
@property(readwrite,assign,nonatomic) int32_t size;
- (SUPJsonMessage*)parse:(SUPString)text;
- (SUPString)toString;
- (void)dealloc;

@end
