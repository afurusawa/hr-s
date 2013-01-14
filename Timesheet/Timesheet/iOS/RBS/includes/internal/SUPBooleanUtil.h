// Copyright (c) 2009, Sybase Inc.

#import "sybase_core.h"

@interface SUPBooleanUtil : NSObject

+ (SUPBoolean)getBoolean:(SUPNullableBoolean)a;
+ (SUPBoolean)getBoolean_s:(SUPString)s;
+ (SUPNullableBoolean)getNullableBoolean:(SUPBoolean)a;
+ (SUPNullableBoolean)getNullableBoolean_s:(SUPString)s;
+ (SUPBoolean)equal:(SUPNullableBoolean)a:(SUPNullableBoolean)b;
+ (SUPBoolean)notEqual:(SUPNullableBoolean)a:(SUPNullableBoolean)b;

@end
