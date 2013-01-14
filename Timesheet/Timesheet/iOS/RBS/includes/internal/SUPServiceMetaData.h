#import "sybase_sup.h"

#import "SUPClassMetaData.h"

@interface SUPServiceMetaData : SUPClassMetaData

+ (SUPServiceMetaData*)getInstance;

@property(assign) SUPBoolean rpc;
@property(assign) SUPBoolean sms;

- (SUPBoolean)isService;

@end
