#import "HR_SuiteUsersMetaData.h"

#import "SUPRelationshipMetaData.h"
#import "SUPParameterMetaData.h"
#import "SUPIndexMetaData.h"
#import "SUPAttributeMap.h"
#import "SUPObjectList.h"
#import "SUPClassMap.h"
#import "SUPEntityMap.h"
#import "HR_SuiteUsers.h"
#import "SUPOperationMap.h"
#import "HR_SuiteHR_SuiteDB.h"
#import "SUPDataType.h"

@implementation HR_SuiteUsersMetaData

+ (HR_SuiteUsersMetaData*)getInstance
{
    return [[[HR_SuiteUsersMetaData alloc] init] autorelease];
}

- (id)init
{
    if (self = [super init]) {
		self.id = 11;
		self.name = @"Users";
		self.klass = [HR_SuiteUsers class];
 		self.allowPending = YES;;

		self.isClientOnly = NO;

		SUPObjectList *attributes = [SUPObjectList getInstance];
		SUPAttributeMetaDataRBS* a_id = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			39:
			[SUPDataType forName:@"int"]:@"integer":@"id":@"":@"a":
			@"":-1:0:0:
			@"null":NO:@"":
			NO:NO:NO:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_id setColumn:@"a"];
		SUPAttributeMetaDataRBS* a_employeeName = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			40:
			[SUPDataType forName:@"string?"]:@"varchar(1200)":@"employeeName":@"":@"b":
			@"":1200:0:0:
			@"null":NO:@"":
			NO:NO:YES:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_employeeName setColumn:@"b"];
		SUPAttributeMetaDataRBS* a_employeeID = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			41:
			[SUPDataType forName:@"string?"]:@"varchar(1200)":@"employeeID":@"":@"c":
			@"":1200:0:0:
			@"null":NO:@"":
			NO:NO:YES:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_employeeID setColumn:@"c"];
		SUPAttributeMetaDataRBS* a_employeePassword = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			42:
			[SUPDataType forName:@"string?"]:@"varchar(1200)":@"employeePassword":@"":@"d":
			@"":1200:0:0:
			@"null":NO:@"":
			NO:NO:YES:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_employeePassword setColumn:@"d"];
		SUPAttributeMetaDataRBS* a_address = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			43:
			[SUPDataType forName:@"string?"]:@"varchar(1200)":@"address":@"":@"e":
			@"":1200:0:0:
			@"null":NO:@"":
			NO:NO:YES:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_address setColumn:@"e"];
		SUPAttributeMetaDataRBS* a_department = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			44:
			[SUPDataType forName:@"string?"]:@"varchar(1200)":@"department":@"":@"f":
			@"":1200:0:0:
			@"null":NO:@"":
			NO:NO:YES:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_department setColumn:@"f"];
		SUPAttributeMetaDataRBS* a_position = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			45:
			[SUPDataType forName:@"string?"]:@"varchar(1200)":@"position":@"":@"g":
			@"":1200:0:0:
			@"null":NO:@"":
			NO:NO:YES:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_position setColumn:@"g"];
		SUPAttributeMetaDataRBS* a_manager = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			46:
			[SUPDataType forName:@"string?"]:@"varchar(1200)":@"manager":@"":@"h":
			@"":1200:0:0:
			@"null":NO:@"":
			NO:NO:YES:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_manager setColumn:@"h"];
		SUPAttributeMetaDataRBS* a_email = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			47:
			[SUPDataType forName:@"string?"]:@"varchar(1200)":@"email":@"":@"i":
			@"":1200:0:0:
			@"null":NO:@"":
			NO:NO:YES:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_email setColumn:@"i"];
		SUPAttributeMetaDataRBS* a_phone = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			48:
			[SUPDataType forName:@"string?"]:@"varchar(1200)":@"phone":@"":@"j":
			@"":1200:0:0:
			@"null":NO:@"":
			NO:NO:YES:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_phone setColumn:@"j"];
		SUPAttributeMetaDataRBS* a_picture = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			49:
			[SUPDataType forName:@"string?"]:@"varchar(1200)":@"picture":@"":@"l":
			@"":1200:0:0:
			@"null":NO:@"":
			NO:NO:YES:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_picture setColumn:@"l"];
		SUPAttributeMetaDataRBS* a_firstName = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			50:
			[SUPDataType forName:@"string?"]:@"varchar(1200)":@"firstName":@"":@"m":
			@"":1200:0:0:
			@"null":NO:@"":
			NO:NO:YES:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_firstName setColumn:@"m"];
		SUPAttributeMetaDataRBS* a_lastName = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			51:
			[SUPDataType forName:@"string?"]:@"varchar(1200)":@"lastName":@"":@"n":
			@"":1200:0:0:
			@"null":NO:@"":
			NO:NO:YES:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_lastName setColumn:@"n"];
		SUPAttributeMetaDataRBS* a_fax = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			52:
			[SUPDataType forName:@"string?"]:@"varchar(1200)":@"fax":@"":@"o":
			@"":1200:0:0:
			@"null":NO:@"":
			NO:NO:YES:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_fax setColumn:@"o"];
		SUPAttributeMetaDataRBS* a_updateManagerCalled = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			54:
			[SUPDataType forName:@"boolean"]:@"tinyint":@"updateManagerCalled":@"":@"q":
			@"":-1:0:0:
			@"null":NO:@"":
			NO:NO:NO:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_updateManagerCalled setColumn:@"q"];
		SUPAttributeMetaDataRBS* a_updatePasswordCalled = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			55:
			[SUPDataType forName:@"boolean"]:@"tinyint":@"updatePasswordCalled":@"":@"r":
			@"":-1:0:0:
			@"null":NO:@"":
			NO:NO:NO:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_updatePasswordCalled setColumn:@"r"];
		SUPAttributeMetaDataRBS* a_pending = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			20001:
			[SUPDataType forName:@"boolean"]:@"tinyint":@"pending":@"":@"_pf":
			@"default 'N'":-1:0:0:
			@"null":NO:@"":
			NO:NO:NO:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_pending setColumn:@"_pf"];
		SUPAttributeMetaDataRBS* a_pendingChange = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			20002:
			[SUPDataType forName:@"char"]:@"char(1)":@"pendingChange":@"":@"_pc":
			@"":1:0:0:
			@"null":NO:@"":
			NO:NO:NO:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_pendingChange setColumn:@"_pc"];
		SUPAttributeMetaDataRBS* a_replayPending = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			20005:
			[SUPDataType forName:@"long"]:@"decimal(20,0)":@"replayPending":@"":@"_rp":
			@"":-1:0:0:
			@"null":NO:@"":
			NO:NO:NO:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_replayPending setColumn:@"_rp"];
		SUPAttributeMetaDataRBS* a_replayFailure = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			20006:
			[SUPDataType forName:@"long"]:@"decimal(20,0)":@"replayFailure":@"":@"_rf":
			@"":-1:0:0:
			@"null":NO:@"":
			NO:NO:NO:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_replayFailure setColumn:@"_rf"];
		SUPAttributeMetaDataRBS* a_surrogateKey = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			53:
			[SUPDataType forName:@"long"]:@"decimal(20,0)":@"surrogateKey":@"":@"p":
			@"":-1:0:0:
			@"null":NO:@"":
			YES:NO:NO:NO:NO:NO:
			GeneratedScheme_GLOBAL:
			NO:SUPPersonalizationType_None:NO];
		[a_surrogateKey setColumn:@"p"];
		SUPAttributeMetaDataRBS* a_replayCounter = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			20004:
			[SUPDataType forName:@"long"]:@"decimal(20,0)":@"replayCounter":@"_rc":@"_rc":
			@"":-1:0:0:
			@"null":NO:@"":
			NO:NO:NO:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_replayCounter setColumn:@"_rc"];
		SUPAttributeMetaDataRBS* a_disableSubmit = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			20003:
			[SUPDataType forName:@"boolean"]:@"tinyint":@"disableSubmit":@"":@"_ds":
			@"":-1:0:0:
			@"null":NO:@"":
			NO:NO:NO:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_disableSubmit setColumn:@"_ds"];
 		
		[attributes addThis:a_id];
		[attributes addThis:a_employeeName];
		[attributes addThis:a_employeeID];
		[attributes addThis:a_employeePassword];
		[attributes addThis:a_address];
		[attributes addThis:a_department];
		[attributes addThis:a_position];
		[attributes addThis:a_manager];
		[attributes addThis:a_email];
		[attributes addThis:a_phone];
		[attributes addThis:a_picture];
		[attributes addThis:a_firstName];
		[attributes addThis:a_lastName];
		[attributes addThis:a_fax];
		[attributes addThis:a_updateManagerCalled];
		[attributes addThis:a_updatePasswordCalled];
		[attributes addThis:a_pending];
		[attributes addThis:a_pendingChange];
		[attributes addThis:a_replayPending];
		[attributes addThis:a_replayFailure];
		[attributes addThis:a_surrogateKey];
		[attributes addThis:a_replayCounter];
		[attributes addThis:a_disableSubmit];
		self.attributes = attributes;
		
		SUPAttributeMap * attributeMap = [SUPAttributeMap getInstance];
   		[attributeMap setAttributes:attributes];
	   	self.attributeMap = attributeMap;

 		SUPOperationMetaData* o_updateManager_0 = [SUPOperationMetaData createOperationMetaData:1:(SUPString)@"updateManager":[SUPDataType forName:@"void"]:true];
		[o_updateManager_0 setIsStatic:NO];
		[o_updateManager_0 setIsCreate:NO];
		[o_updateManager_0 setIsUpdate:YES];
		[o_updateManager_0 setIsDelete:NO]; 		
 		SUPOperationMetaData* o_update_0 = [SUPOperationMetaData createOperationMetaData:2:(SUPString)@"update":[SUPDataType forName:@"void"]:true];
		[o_update_0 setIsStatic:NO];
		[o_update_0 setIsCreate:NO];
		[o_update_0 setIsUpdate:YES];
		[o_update_0 setIsDelete:NO]; 		
 		SUPOperationMetaData* o_addEmployee_0 = [SUPOperationMetaData createOperationMetaData:3:(SUPString)@"addEmployee":[SUPDataType forName:@"void"]:true];
		[o_addEmployee_0 setIsStatic:NO];
		[o_addEmployee_0 setIsCreate:YES];
		[o_addEmployee_0 setIsUpdate:NO];
		[o_addEmployee_0 setIsDelete:NO]; 		
 		SUPOperationMetaData* o_delete_0 = [SUPOperationMetaData createOperationMetaData:4:(SUPString)@"delete":[SUPDataType forName:@"void"]:true];
		[o_delete_0 setIsStatic:NO];
		[o_delete_0 setIsCreate:NO];
		[o_delete_0 setIsUpdate:NO];
		[o_delete_0 setIsDelete:YES]; 		
 		SUPOperationMetaData* o_updatePassword_0 = [SUPOperationMetaData createOperationMetaData:5:(SUPString)@"updatePassword":[SUPDataType forName:@"void"]:true];
		[o_updatePassword_0 setIsStatic:NO];
		[o_updatePassword_0 setIsCreate:NO];
		[o_updatePassword_0 setIsUpdate:YES];
		[o_updatePassword_0 setIsDelete:NO]; 		
 		SUPOperationMetaData* o_findAll_0 = [SUPOperationMetaData createOperationMetaData:6:(SUPString)@"findAll":[SUPDataType forName:@"Users*"]:true];
		[o_findAll_0 setIsStatic:YES];
		[o_findAll_0 setIsCreate:NO];
		[o_findAll_0 setIsUpdate:NO];
		[o_findAll_0 setIsDelete:NO]; 		
 		SUPOperationMetaData* o_findByPrimaryKey_1 = [SUPOperationMetaData createOperationMetaData:7:(SUPString)@"findByPrimaryKey":[SUPDataType forName:@"Users"]:true];
	  	{
			SUPObjectList *parameters_list = nil;
	 		SUPParameterMetaData* p_findByPrimaryKey_id = [SUPParameterMetaData createParameterMetaData:1:(SUPString)@"id":[SUPDataType forName:@"int"]];
 			parameters_list = [SUPObjectList listWithCapacity:1];
			[parameters_list addThis:p_findByPrimaryKey_id];
			o_findByPrimaryKey_1.parameters = parameters_list;
	 	}
		[o_findByPrimaryKey_1 setIsStatic:YES];
		[o_findByPrimaryKey_1 setIsCreate:NO];
		[o_findByPrimaryKey_1 setIsUpdate:NO];
		[o_findByPrimaryKey_1 setIsDelete:NO]; 		
 		SUPOperationMetaData* o_findByEmployeeIDAndPassword_2 = [SUPOperationMetaData createOperationMetaData:8:(SUPString)@"findByEmployeeIDAndPassword":[SUPDataType forName:@"Users*"]:true];
	  	{
			SUPObjectList *parameters_list = nil;
	 		SUPParameterMetaData* p_findByEmployeeIDAndPassword_employeeID = [SUPParameterMetaData createParameterMetaData:1:(SUPString)@"employeeID":[SUPDataType forName:@"string?"]];
	 		SUPParameterMetaData* p_findByEmployeeIDAndPassword_employeePassword = [SUPParameterMetaData createParameterMetaData:2:(SUPString)@"employeePassword":[SUPDataType forName:@"string?"]];
 			parameters_list = [SUPObjectList listWithCapacity:2];
			[parameters_list addThis:p_findByEmployeeIDAndPassword_employeeID];
			[parameters_list addThis:p_findByEmployeeIDAndPassword_employeePassword];
			o_findByEmployeeIDAndPassword_2.parameters = parameters_list;
	 	}
		[o_findByEmployeeIDAndPassword_2 setIsStatic:YES];
		[o_findByEmployeeIDAndPassword_2 setIsCreate:NO];
		[o_findByEmployeeIDAndPassword_2 setIsUpdate:NO];
		[o_findByEmployeeIDAndPassword_2 setIsDelete:NO]; 		
 		SUPOperationMetaData* o_findByEmployeeID_1 = [SUPOperationMetaData createOperationMetaData:9:(SUPString)@"findByEmployeeID":[SUPDataType forName:@"Users*"]:true];
	  	{
			SUPObjectList *parameters_list = nil;
	 		SUPParameterMetaData* p_findByEmployeeID_employeeID = [SUPParameterMetaData createParameterMetaData:1:(SUPString)@"employeeID":[SUPDataType forName:@"string?"]];
 			parameters_list = [SUPObjectList listWithCapacity:1];
			[parameters_list addThis:p_findByEmployeeID_employeeID];
			o_findByEmployeeID_1.parameters = parameters_list;
	 	}
		[o_findByEmployeeID_1 setIsStatic:YES];
		[o_findByEmployeeID_1 setIsCreate:NO];
		[o_findByEmployeeID_1 setIsUpdate:NO];
		[o_findByEmployeeID_1 setIsDelete:NO]; 		
 		SUPOperationMetaData* o_refresh_0 = [SUPOperationMetaData createOperationMetaData:10:(SUPString)@"refresh":[SUPDataType forName:@"void"]:true];
		[o_refresh_0 setIsStatic:NO];
		[o_refresh_0 setIsCreate:NO];
		[o_refresh_0 setIsUpdate:NO];
		[o_refresh_0 setIsDelete:NO]; 		
 		SUPOperationMetaData* o__pk_0 = [SUPOperationMetaData createOperationMetaData:11:(SUPString)@"_pk":[SUPDataType forName:@"long?"]:true];
		[o__pk_0 setIsStatic:NO];
		[o__pk_0 setIsCreate:NO];
		[o__pk_0 setIsUpdate:NO];
		[o__pk_0 setIsDelete:NO]; 		
 		SUPOperationMetaData* o_submitPending_0 = [SUPOperationMetaData createOperationMetaData:12:(SUPString)@"submitPending":[SUPDataType forName:@"void"]:true];
		[o_submitPending_0 setIsStatic:NO];
		[o_submitPending_0 setIsCreate:NO];
		[o_submitPending_0 setIsUpdate:NO];
		[o_submitPending_0 setIsDelete:NO]; 		
 		SUPOperationMetaData* o_cancelPending_0 = [SUPOperationMetaData createOperationMetaData:13:(SUPString)@"cancelPending":[SUPDataType forName:@"void"]:true];
		[o_cancelPending_0 setIsStatic:NO];
		[o_cancelPending_0 setIsCreate:NO];
		[o_cancelPending_0 setIsUpdate:NO];
		[o_cancelPending_0 setIsDelete:NO]; 		
 		SUPOperationMetaData* o_submitPendingOperations_0 = [SUPOperationMetaData createOperationMetaData:14:(SUPString)@"submitPendingOperations":[SUPDataType forName:@"void"]:true];
		[o_submitPendingOperations_0 setIsStatic:YES];
		[o_submitPendingOperations_0 setIsCreate:NO];
		[o_submitPendingOperations_0 setIsUpdate:NO];
		[o_submitPendingOperations_0 setIsDelete:NO]; 		
 		SUPOperationMetaData* o_cancelPendingOperations_0 = [SUPOperationMetaData createOperationMetaData:15:(SUPString)@"cancelPendingOperations":[SUPDataType forName:@"void"]:true];
		[o_cancelPendingOperations_0 setIsStatic:YES];
		[o_cancelPendingOperations_0 setIsCreate:NO];
		[o_cancelPendingOperations_0 setIsUpdate:NO];
		[o_cancelPendingOperations_0 setIsDelete:NO]; 		
 		SUPOperationMetaData* o_save_0 = [SUPOperationMetaData createOperationMetaData:16:(SUPString)@"save":[SUPDataType forName:@"void"]:true];
		[o_save_0 setIsStatic:NO];
		[o_save_0 setIsCreate:NO];
		[o_save_0 setIsUpdate:NO];
		[o_save_0 setIsDelete:NO]; 		
 		SUPOperationMetaData* o_findWithQuery_1 = [SUPOperationMetaData createOperationMetaData:17:(SUPString)@"findWithQuery":[SUPDataType forName:@"Users*"]:true];
	  	{
			SUPObjectList *parameters_list = nil;
	 		SUPParameterMetaData* p_findWithQuery_query = [SUPParameterMetaData createParameterMetaData:1:(SUPString)@"query":[SUPDataType forName:@"com.sybase.persistence.Query"]];
 			parameters_list = [SUPObjectList listWithCapacity:1];
			[parameters_list addThis:p_findWithQuery_query];
			o_findWithQuery_1.parameters = parameters_list;
	 	}
		[o_findWithQuery_1 setIsStatic:YES];
		[o_findWithQuery_1 setIsCreate:NO];
		[o_findWithQuery_1 setIsUpdate:NO];
		[o_findWithQuery_1 setIsDelete:NO]; 		
 		SUPOperationMetaData* o_getSize_1 = [SUPOperationMetaData createOperationMetaData:18:(SUPString)@"getSize":[SUPDataType forName:@"int"]:true];
	  	{
			SUPObjectList *parameters_list = nil;
	 		SUPParameterMetaData* p_getSize_query = [SUPParameterMetaData createParameterMetaData:1:(SUPString)@"query":[SUPDataType forName:@"com.sybase.persistence.Query"]];
 			parameters_list = [SUPObjectList listWithCapacity:1];
			[parameters_list addThis:p_getSize_query];
			o_getSize_1.parameters = parameters_list;
	 	}
		[o_getSize_1 setIsStatic:YES];
		[o_getSize_1 setIsCreate:NO];
		[o_getSize_1 setIsUpdate:NO];
		[o_getSize_1 setIsDelete:NO]; 		
 
  		SUPObjectList *operations = [SUPObjectList listWithCapacity:18];
 		[operations addThis:o_updateManager_0];
 		[operations addThis:o_update_0];
 		[operations addThis:o_addEmployee_0];
 		[operations addThis:o_delete_0];
 		[operations addThis:o_updatePassword_0];
 		[operations addThis:o_findAll_0];
 		[operations addThis:o_findByPrimaryKey_1];
 		[operations addThis:o_findByEmployeeIDAndPassword_2];
 		[operations addThis:o_findByEmployeeID_1];
 		[operations addThis:o_refresh_0];
 		[operations addThis:o__pk_0];
 		[operations addThis:o_submitPending_0];
 		[operations addThis:o_cancelPending_0];
 		[operations addThis:o_submitPendingOperations_0];
 		[operations addThis:o_cancelPendingOperations_0];
 		[operations addThis:o_save_0];
 		[operations addThis:o_findWithQuery_1];
 		[operations addThis:o_getSize_1];
	 	self.operations = operations;
 	
		SUPOperationMap *operationMap = [SUPOperationMap getInstance];
		[operationMap setOperations:operations];
		self.operationMap = operationMap;		
		self.table = @"hr_suite_1_0_users";
		self.synchronizationGroup = @"default";

		SUPIndexMetaData *i_findByPrimaryKeyIndex = [[[SUPIndexMetaData alloc] init] autorelease];
		i_findByPrimaryKeyIndex.name = @"findByPrimaryKeyIndex";
		[i_findByPrimaryKeyIndex.attributes add:a_id];
	
		[self.indexList add:i_findByPrimaryKeyIndex];
			
		[self.keyList add:a_surrogateKey];


    }
    return self;
}
@end