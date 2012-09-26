/*
 Generated by Sybase Unwired Platform 
 Compiler version - 2.1.3.358
*/ 

#import "HR_SuiteKeyPackageName.h"
#import "HR_SuiteKeyPackageNameMetaData.h"
#import "SUPJsonObject.h"
#import "HR_SuiteHR_SuiteDB.h"
#import "SUPClassDelegate.h"
#import "SUPEntityMetaDataRBS.h"

@implementation HR_SuiteKeyPackageName

@synthesize key_name = _key_name;
@synthesize package_name = _package_name;
@synthesize user_name = _user_name;
@synthesize domain_name = _domain_name;

static SUPClassDelegate *g_HR_SuiteKeyPackageName_delegate = nil;

+ (SUPClassDelegate *) delegate
{
	@synchronized(self) {
		if (g_HR_SuiteKeyPackageName_delegate == nil) {
			g_HR_SuiteKeyPackageName_delegate = [[SUPClassDelegate alloc] initWithName:@"HR_SuiteKeyPackageName" clazz:[self class]
				metaData:[self metaData] dbDelegate:[HR_SuiteHR_SuiteDB delegate] database:[HR_SuiteHR_SuiteDB instance]];
		}
	}
	
	return [[g_HR_SuiteKeyPackageName_delegate retain] autorelease];
}

static SUPClassMetaDataRBS* HR_SuiteKeyPackageName_META_DATA;

+ (SUPClassMetaDataRBS*)metaData
{
    if (HR_SuiteKeyPackageName_META_DATA == nil) {
 	   	HR_SuiteKeyPackageName_META_DATA = [[HR_SuiteKeyPackageNameMetaData alloc] init];
	}
	
	return HR_SuiteKeyPackageName_META_DATA;
}

- (SUPClassMetaDataRBS*)getClassMetaData
{
    return [[self class] metaData];
}
- (id) init
{
    if ((self = [super init]))
    {
        self.classMetaData = (SUPEntityMetaDataRBS *)[HR_SuiteKeyPackageName metaData];
        [self setClassDelegate:[[self class] delegate]];
        
    }
    return self;    
}

-(SUPString) getAttributeString:(int)id_
{
    switch(id_)
    {
    case 329:
        return self.key_name;
    case 331:
        return self.package_name;
    case 330:
        return self.user_name;
    case 332:
        return self.domain_name;
    default:
        return [super getAttributeString:id_];
    }
}

-(void) setAttributeString:(int)id_:(SUPString)v
{
    switch(id_)
    {
    case 329:
        self.key_name = v;
        break;;
    case 331:
        self.package_name = v;
        break;;
    case 330:
        self.user_name = v;
        break;;
    case 332:
        self.domain_name = v;
        break;;
    default:
        [super setAttributeString:id_:v];
        break;;
    }
}
- (id)getAttributeLargeObject:(int)id_ loadFromDB:(BOOL)loadFromDB
{
    switch(id_)
    {
        default:
        return [super getAttributeJson:id_];
    }
}
- (void)setAttributeLargeObject:(int)id_:(id)value
{
    switch(id_)
    {
        default:
            [super setAttributeJson:id_:value];
            break;
    }

}
+ (HR_SuiteKeyPackageName*)getInstance
{
    HR_SuiteKeyPackageName* me = [[HR_SuiteKeyPackageName alloc] init];
    [me autorelease];
    return me;
}
- (void)dealloc
{
    if(_key_name)
    {
        [_key_name release];
        _key_name = nil;
    }
    if(_package_name)
    {
        [_package_name release];
        _package_name = nil;
    }
    if(_user_name)
    {
        [_user_name release];
        _user_name = nil;
    }
    if(_domain_name)
    {
        [_domain_name release];
        _domain_name = nil;
    }
	[super dealloc];
}

@end