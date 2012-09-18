#import "HR_SuiteKeyPackageNameMetaData.h"

#import "SUPParameterMetaData.h"
#import "SUPAttributeMap.h"
#import "SUPObjectList.h"
#import "SUPClassMap.h"
#import "SUPEntityMap.h"
#import "HR_SuiteKeyPackageName.h"
#import "SUPDataType.h"
#import "SUPAttributeMetaDataRBS.h"

@implementation HR_SuiteKeyPackageNameMetaData

+ (HR_SuiteKeyPackageNameMetaData*)getInstance
{
    return [[[HR_SuiteKeyPackageNameMetaData alloc] init] autorelease];
}

- (id)init
{
	if (self = [super init]) {
		self.name = @"KeyPackageName";
		self.klass = [HR_SuiteKeyPackageName class];
 
		SUPObjectList *attributes = [SUPObjectList listWithCapacity:7];
		SUPAttributeMetaDataRBS* a_key_name = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			121:
			[SUPDataType forName:@"string"]:@"varchar(255)":@"key_name":@"":@"":
			@"":255:0:0:
			@"null":NO:@"":
			NO:NO:NO:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
  		[attributes addThis:a_key_name];
		SUPAttributeMetaDataRBS* a_package_name = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			123:
			[SUPDataType forName:@"string"]:@"varchar(100)":@"package_name":@"":@"":
			@"":100:0:0:
			@"null":NO:@"":
			NO:NO:NO:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
  		[attributes addThis:a_package_name];
		SUPAttributeMetaDataRBS* a_user_name = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			122:
			[SUPDataType forName:@"string"]:@"varchar(255)":@"user_name":@"":@"":
			@"":255:0:0:
			@"null":NO:@"":
			NO:NO:NO:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
  		[attributes addThis:a_user_name];
		SUPAttributeMetaDataRBS* a_domain_name = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			124:
			[SUPDataType forName:@"string"]:@"varchar(100)":@"domain_name":@"":@"":
			@"":100:0:0:
			@"null":NO:@"":
			NO:NO:NO:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
  		[attributes addThis:a_domain_name];
 		self.attributes = attributes;
 		
 		SUPAttributeMap * attributeMap = [SUPAttributeMap getInstance];
    	[attributeMap setAttributes:attributes];
    	self.attributeMap = attributeMap;

	}
    return self;
}
@end