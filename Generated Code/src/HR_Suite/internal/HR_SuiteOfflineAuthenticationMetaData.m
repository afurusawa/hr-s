#import "HR_SuiteOfflineAuthenticationMetaData.h"

#import "SUPRelationshipMetaData.h"
#import "SUPParameterMetaData.h"
#import "SUPIndexMetaData.h"
#import "SUPAttributeMap.h"
#import "SUPObjectList.h"
#import "SUPClassMap.h"
#import "SUPEntityMap.h"
#import "HR_SuiteOfflineAuthentication.h"
#import "SUPOperationMap.h"
#import "HR_SuiteHR_SuiteDB.h"
#import "SUPDataType.h"

@implementation HR_SuiteOfflineAuthenticationMetaData

+ (HR_SuiteOfflineAuthenticationMetaData*)getInstance
{
    return [[[HR_SuiteOfflineAuthenticationMetaData alloc] init] autorelease];
}

- (id)init
{
    if (self = [super init]) {
		self.id = 12;
		self.name = @"OfflineAuthentication";
		self.klass = [HR_SuiteOfflineAuthentication class];
 		self.allowPending = NO;;

		self.isClientOnly = YES;

		SUPObjectList *attributes = [SUPObjectList getInstance];
		SUPAttributeMetaDataRBS* a_passwordHash = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			114:
			[SUPDataType forName:@"int"]:@"integer":@"passwordHash":@"":@"b":
			@"":-1:0:0:
			@"null":NO:@"":
			NO:NO:NO:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_passwordHash setColumn:@"b"];
		SUPAttributeMetaDataRBS* a_user = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			113:
			[SUPDataType forName:@"string"]:@"varchar(300)":@"user":@"":@"a":
			@"":300:0:0:
			@"null":NO:@"":
			YES:NO:NO:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_user setColumn:@"a"];
 		
		[attributes addThis:a_passwordHash];
		[attributes addThis:a_user];
		self.attributes = attributes;
		
		SUPAttributeMap * attributeMap = [SUPAttributeMap getInstance];
   		[attributeMap setAttributes:attributes];
	   	self.attributeMap = attributeMap;

 		SUPOperationMetaData* o_refresh_0 = [SUPOperationMetaData createOperationMetaData:1:(SUPString)@"refresh":[SUPDataType forName:@"void"]:true];
		[o_refresh_0 setIsStatic:NO];
		[o_refresh_0 setIsCreate:NO];
		[o_refresh_0 setIsUpdate:NO];
		[o_refresh_0 setIsDelete:NO]; 		
 		SUPOperationMetaData* o__pk_0 = [SUPOperationMetaData createOperationMetaData:2:(SUPString)@"_pk":[SUPDataType forName:@"string?"]:true];
		[o__pk_0 setIsStatic:NO];
		[o__pk_0 setIsCreate:NO];
		[o__pk_0 setIsUpdate:NO];
		[o__pk_0 setIsDelete:NO]; 		
 		SUPOperationMetaData* o_save_0 = [SUPOperationMetaData createOperationMetaData:3:(SUPString)@"save":[SUPDataType forName:@"void"]:true];
		[o_save_0 setIsStatic:NO];
		[o_save_0 setIsCreate:NO];
		[o_save_0 setIsUpdate:NO];
		[o_save_0 setIsDelete:NO]; 		
 
  		SUPObjectList *operations = [SUPObjectList listWithCapacity:3];
 		[operations addThis:o_refresh_0];
 		[operations addThis:o__pk_0];
 		[operations addThis:o_save_0];
	 	self.operations = operations;
 	
		SUPOperationMap *operationMap = [SUPOperationMap getInstance];
		[operationMap setOperations:operations];
		self.operationMap = operationMap;		
		self.table = @"co_hr_suite_1_0_offlineauthentication";
		self.synchronizationGroup = @"";

			
		[self.keyList add:a_user];


    }
    return self;
}
@end