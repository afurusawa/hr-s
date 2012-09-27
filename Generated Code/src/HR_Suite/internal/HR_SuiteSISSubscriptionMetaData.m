#import "HR_SuiteSISSubscriptionMetaData.h"

#import "SUPRelationshipMetaData.h"
#import "SUPParameterMetaData.h"
#import "SUPIndexMetaData.h"
#import "SUPAttributeMap.h"
#import "SUPObjectList.h"
#import "SUPClassMap.h"
#import "SUPEntityMap.h"
#import "HR_SuiteSISSubscription.h"
#import "SUPOperationMap.h"
#import "HR_SuiteHR_SuiteDB.h"
#import "SUPDataType.h"

@implementation HR_SuiteSISSubscriptionMetaData

+ (HR_SuiteSISSubscriptionMetaData*)getInstance
{
    return [[[HR_SuiteSISSubscriptionMetaData alloc] init] autorelease];
}

- (id)init
{
    if (self = [super init]) {
		self.id = 8;
		self.name = @"SISSubscription";
		self.klass = [HR_SuiteSISSubscription class];
 		self.allowPending = NO;;

		self.isClientOnly = YES;

		SUPObjectList *attributes = [SUPObjectList getInstance];
		SUPAttributeMetaDataRBS* a_deviceId = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			93:
			[SUPDataType forName:@"string"]:@"varchar(200)":@"deviceId":@"":@"device_id":
			@"":200:0:0:
			@"null":NO:@"":
			NO:NO:NO:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_deviceId setColumn:@"device_id"];
		SUPAttributeMetaDataRBS* a_username = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			94:
			[SUPDataType forName:@"string"]:@"varchar(100)":@"username":@"":@"user_name":
			@"":100:0:0:
			@"null":NO:@"":
			NO:NO:NO:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_username setColumn:@"user_name"];
		SUPAttributeMetaDataRBS* a_appname = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			95:
			[SUPDataType forName:@"string"]:@"varchar(100)":@"appname":@"":@"h":
			@"":100:0:0:
			@"sup":NO:@"":
			NO:NO:NO:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_appname setColumn:@"h"];
		SUPAttributeMetaDataRBS* a_enable = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			96:
			[SUPDataType forName:@"boolean"]:@"tinyint":@"enable":@"":@"i":
			@"":-1:0:0:
			@"false":NO:@"":
			NO:NO:NO:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_enable setColumn:@"i"];
		SUPAttributeMetaDataRBS* a_adminLock = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			97:
			[SUPDataType forName:@"boolean"]:@"tinyint":@"adminLock":@"":@"admin_lock":
			@"":-1:0:0:
			@"false":NO:@"":
			NO:NO:NO:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_adminLock setColumn:@"admin_lock"];
		SUPAttributeMetaDataRBS* a_interval = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			98:
			[SUPDataType forName:@"int"]:@"integer":@"interval":@"":@"l":
			@"":-1:0:0:
			@"0":NO:@"":
			NO:NO:NO:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_interval setColumn:@"l"];
		SUPAttributeMetaDataRBS* a_protocol = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			99:
			[SUPDataType forName:@"string"]:@"varchar(100)":@"protocol":@"":@"m":
			@"":100:0:0:
			@"TCN":NO:@"":
			NO:NO:NO:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_protocol setColumn:@"m"];
		SUPAttributeMetaDataRBS* a_address = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			100:
			[SUPDataType forName:@"string?"]:@"varchar(300)":@"address":@"":@"n":
			@"":300:0:0:
			@"null":NO:@"":
			NO:NO:YES:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_address setColumn:@"n"];
		SUPAttributeMetaDataRBS* a_domain = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			89:
			[SUPDataType forName:@"string"]:@"varchar(100)":@"domain":@"":@"domain":
			@"":100:0:0:
			@"null":NO:@"":
			YES:NO:NO:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_domain setColumn:@"domain"];
		SUPAttributeMetaDataRBS* a_package = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			90:
			[SUPDataType forName:@"string"]:@"varchar(100)":@"package":@"":@"pkg":
			@"":100:0:0:
			@"null":NO:@"":
			YES:NO:NO:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_package setColumn:@"pkg"];
		SUPAttributeMetaDataRBS* a_syncGroup = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			91:
			[SUPDataType forName:@"string"]:@"varchar(100)":@"syncGroup":@"":@"sync_group":
			@"":100:0:0:
			@"null":NO:@"":
			YES:NO:NO:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_syncGroup setColumn:@"sync_group"];
		SUPAttributeMetaDataRBS* a_clientId = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			92:
			[SUPDataType forName:@"string"]:@"varchar(100)":@"clientId":@"":@"cid":
			@"":100:0:0:
			@"null":NO:@"":
			YES:NO:NO:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_clientId setColumn:@"cid"];
 		
		[attributes addThis:a_deviceId];
		[attributes addThis:a_username];
		[attributes addThis:a_appname];
		[attributes addThis:a_enable];
		[attributes addThis:a_adminLock];
		[attributes addThis:a_interval];
		[attributes addThis:a_protocol];
		[attributes addThis:a_address];
		[attributes addThis:a_domain];
		[attributes addThis:a_package];
		[attributes addThis:a_syncGroup];
		[attributes addThis:a_clientId];
		self.attributes = attributes;
		
		SUPAttributeMap * attributeMap = [SUPAttributeMap getInstance];
   		[attributeMap setAttributes:attributes];
	   	self.attributeMap = attributeMap;

 		SUPOperationMetaData* o_refresh_0 = [SUPOperationMetaData createOperationMetaData:1:(SUPString)@"refresh":[SUPDataType forName:@"void"]:true];
		[o_refresh_0 setIsStatic:NO];
		[o_refresh_0 setIsCreate:NO];
		[o_refresh_0 setIsUpdate:NO];
		[o_refresh_0 setIsDelete:NO]; 		
 		SUPOperationMetaData* o_save_0 = [SUPOperationMetaData createOperationMetaData:2:(SUPString)@"save":[SUPDataType forName:@"void"]:true];
		[o_save_0 setIsStatic:NO];
		[o_save_0 setIsCreate:NO];
		[o_save_0 setIsUpdate:NO];
		[o_save_0 setIsDelete:NO]; 		
 
  		SUPObjectList *operations = [SUPObjectList listWithCapacity:2];
 		[operations addThis:o_refresh_0];
 		[operations addThis:o_save_0];
	 	self.operations = operations;
 	
		SUPOperationMap *operationMap = [SUPOperationMap getInstance];
		[operationMap setOperations:operations];
		self.operationMap = operationMap;		
		self.table = @"sup_sis_subscription";
		self.synchronizationGroup = @"system";

			
		[self.keyList add:a_domain];
		[self.keyList add:a_package];
		[self.keyList add:a_syncGroup];
		[self.keyList add:a_clientId];


        self.keyClass = @"SISSubscriptionKey";
    }
    return self;
}
@end