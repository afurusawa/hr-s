// Copyright (c) 2009, Sybase Inc.

#import "sybase_core.h"

@interface SUPStringCache : NSObject
{
}

+ (SUPString)fromChar:(SUPChar)c;
+ (SUPString)fromLong:(SUPLong)n;

@end
