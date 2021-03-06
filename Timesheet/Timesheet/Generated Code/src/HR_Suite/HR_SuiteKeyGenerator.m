/*
 Generated by Sybase Unwired Platform 
 Compiler version - 2.1.3.358
*/ 

#import "HR_SuiteKeyGenerator.h"
#import "HR_SuiteKeyGeneratorMetaData.h"
#import "SUPEntityDelegate.h"
#import "HR_SuiteHR_SuiteDB.h"
#import "SUPKeyGenerator.h"

@implementation HR_SuiteKeyGenerator

static SUPEntityDelegate *g_HR_SuiteKeyGenerator_delegate = nil;

+ (SUPEntityDelegate *) delegate
{
	@synchronized(self) {
		if (g_HR_SuiteKeyGenerator_delegate == nil) {
			g_HR_SuiteKeyGenerator_delegate = [[SUPEntityDelegate alloc] initWithName:@"HR_SuiteKeyGenerator" clazz:[self class]
				metaData:[self metaData] dbDelegate:[HR_SuiteHR_SuiteDB delegate] database:[HR_SuiteHR_SuiteDB instance]];
		}
	}
	
	return [[g_HR_SuiteKeyGenerator_delegate retain] autorelease];
}

static SUPEntityMetaDataRBS* HR_SuiteKeyGenerator_META_DATA;

+ (SUPEntityMetaDataRBS*)metaData
{
    if (HR_SuiteKeyGenerator_META_DATA == nil) {
 	   	HR_SuiteKeyGenerator_META_DATA = [[HR_SuiteKeyGeneratorMetaData alloc] init];
	}
	
	return HR_SuiteKeyGenerator_META_DATA;
}

- (SUPClassMetaDataRBS*)getClassMetaData
{
    return [[self class] metaData];
}

- (id)init
{
    self = [super initWithParameters:[HR_SuiteHR_SuiteDB delegate]:@"hr_suite_1_0_keygenerator":100000];
    if (self) {
        // Initialization code here.
        [SUPKeyGenerator setObjectInstance:@"HR_Suite":self];
    }
    
    return self;
}

+ (HR_SuiteKeyGenerator*)getInstance
{
    HR_SuiteKeyGenerator* me = [[HR_SuiteKeyGenerator alloc] init];
    [me autorelease];
    return me;
}

+ (int64_t)generateId
{
    return [[HR_SuiteHR_SuiteDB delegate] generateId];
}

@end