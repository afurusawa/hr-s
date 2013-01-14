#import "sybase_core.h"

@class SUPAbstractOperationException;
@class SUPBase64EncodingException;
@class SUPByteList;
@class SUPJsonObject;
@class SUPNumberUtil;
@class SUPStringList;
@class SUPStringUtil;

@class SUPBase64Encoding;

@interface SUPBase64Encoding : NSObject
{
}

+ (SUPBinary)decode:(SUPString)text;
+ (SUPString)encode:(SUPBinary)data;
- (void)dealloc;

@end
