#import "HR_SuiteLeaveRequestsMetaData.h"

#import "SUPRelationshipMetaData.h"
#import "SUPParameterMetaData.h"
#import "SUPIndexMetaData.h"
#import "SUPAttributeMap.h"
#import "SUPObjectList.h"
#import "SUPClassMap.h"
#import "SUPEntityMap.h"
#import "HR_SuiteLeaveRequests.h"
#import "SUPOperationMap.h"
#import "HR_SuiteHR_SuiteDB.h"
#import "SUPDataType.h"

@implementation HR_SuiteLeaveRequestsMetaData

+ (HR_SuiteLeaveRequestsMetaData*)getInstance
{
    return [[[HR_SuiteLeaveRequestsMetaData alloc] init] autorelease];
}

- (id)init
{
    if (self = [super init]) {
		self.id = 4;
		self.name = @"LeaveRequests";
		self.klass = [HR_SuiteLeaveRequests class];
 		self.allowPending = YES;;

		self.isClientOnly = NO;

		SUPObjectList *attributes = [SUPObjectList getInstance];
		SUPAttributeMetaDataRBS* a_id = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			9:
			[SUPDataType forName:@"int"]:@"integer":@"id":@"":@"a":
			@"":-1:0:0:
			@"null":NO:@"":
			NO:NO:NO:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_id setColumn:@"a"];
		SUPAttributeMetaDataRBS* a_employeeID = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			10:
			[SUPDataType forName:@"string?"]:@"varchar(1200)":@"employeeID":@"":@"b":
			@"":1200:0:0:
			@"null":NO:@"":
			NO:NO:YES:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_employeeID setColumn:@"b"];
		SUPAttributeMetaDataRBS* a_leaveType = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			11:
			[SUPDataType forName:@"string?"]:@"varchar(1200)":@"leaveType":@"":@"c":
			@"":1200:0:0:
			@"null":NO:@"":
			NO:NO:YES:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_leaveType setColumn:@"c"];
		SUPAttributeMetaDataRBS* a_startDate = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			12:
			[SUPDataType forName:@"string?"]:@"varchar(1200)":@"startDate":@"":@"d":
			@"":1200:0:0:
			@"null":NO:@"":
			NO:NO:YES:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_startDate setColumn:@"d"];
		SUPAttributeMetaDataRBS* a_endDate = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			13:
			[SUPDataType forName:@"string?"]:@"varchar(1200)":@"endDate":@"":@"e":
			@"":1200:0:0:
			@"null":NO:@"":
			NO:NO:YES:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_endDate setColumn:@"e"];
		SUPAttributeMetaDataRBS* a_reason = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			14:
			[SUPDataType forName:@"string?"]:@"varchar(1200)":@"reason":@"":@"f":
			@"":1200:0:0:
			@"null":NO:@"":
			NO:NO:YES:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_reason setColumn:@"f"];
		SUPAttributeMetaDataRBS* a_signCode = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			15:
			[SUPDataType forName:@"int?"]:@"integer":@"signCode":@"":@"g":
			@"":-1:0:0:
			@"null":NO:@"":
			NO:NO:YES:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_signCode setColumn:@"g"];
		SUPAttributeMetaDataRBS* a_timestamp = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			16:
			[SUPDataType forName:@"string?"]:@"varchar(1200)":@"timestamp":@"":@"h":
			@"":1200:0:0:
			@"null":NO:@"":
			NO:NO:YES:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_timestamp setColumn:@"h"];
		SUPAttributeMetaDataRBS* a_managerNotes = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			17:
			[SUPDataType forName:@"string?"]:@"varchar(1200)":@"managerNotes":@"":@"i":
			@"":1200:0:0:
			@"null":NO:@"":
			NO:NO:YES:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_managerNotes setColumn:@"i"];
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
			18:
			[SUPDataType forName:@"long"]:@"decimal(20,0)":@"surrogateKey":@"":@"j":
			@"":-1:0:0:
			@"null":NO:@"":
			YES:NO:NO:NO:NO:NO:
			GeneratedScheme_GLOBAL:
			NO:SUPPersonalizationType_None:NO];
		[a_surrogateKey setColumn:@"j"];
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
		[attributes addThis:a_employeeID];
		[attributes addThis:a_leaveType];
		[attributes addThis:a_startDate];
		[attributes addThis:a_endDate];
		[attributes addThis:a_reason];
		[attributes addThis:a_signCode];
		[attributes addThis:a_timestamp];
		[attributes addThis:a_managerNotes];
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

 		SUPOperationMetaData* o_updateSignCode_0 = [SUPOperationMetaData createOperationMetaData:1:(SUPString)@"updateSignCode":[SUPDataType forName:@"void"]:true];
		[o_updateSignCode_0 setIsStatic:NO];
		[o_updateSignCode_0 setIsCreate:NO];
		[o_updateSignCode_0 setIsUpdate:YES];
		[o_updateSignCode_0 setIsDelete:NO]; 		
 		SUPOperationMetaData* o_create_0 = [SUPOperationMetaData createOperationMetaData:2:(SUPString)@"create":[SUPDataType forName:@"void"]:true];
		[o_create_0 setIsStatic:NO];
		[o_create_0 setIsCreate:YES];
		[o_create_0 setIsUpdate:NO];
		[o_create_0 setIsDelete:NO]; 		
 		SUPOperationMetaData* o_findAll_0 = [SUPOperationMetaData createOperationMetaData:3:(SUPString)@"findAll":[SUPDataType forName:@"LeaveRequests*"]:true];
		[o_findAll_0 setIsStatic:YES];
		[o_findAll_0 setIsCreate:NO];
		[o_findAll_0 setIsUpdate:NO];
		[o_findAll_0 setIsDelete:NO]; 		
 		SUPOperationMetaData* o_findByPrimaryKey_1 = [SUPOperationMetaData createOperationMetaData:4:(SUPString)@"findByPrimaryKey":[SUPDataType forName:@"LeaveRequests"]:true];
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
 		SUPOperationMetaData* o_findRequestEntry_3 = [SUPOperationMetaData createOperationMetaData:5:(SUPString)@"findRequestEntry":[SUPDataType forName:@"LeaveRequests*"]:true];
	  	{
			SUPObjectList *parameters_list = nil;
	 		SUPParameterMetaData* p_findRequestEntry_employeeID = [SUPParameterMetaData createParameterMetaData:1:(SUPString)@"employeeID":[SUPDataType forName:@"string?"]];
	 		SUPParameterMetaData* p_findRequestEntry_startDate = [SUPParameterMetaData createParameterMetaData:2:(SUPString)@"startDate":[SUPDataType forName:@"string?"]];
	 		SUPParameterMetaData* p_findRequestEntry_endDate = [SUPParameterMetaData createParameterMetaData:3:(SUPString)@"endDate":[SUPDataType forName:@"string?"]];
 			parameters_list = [SUPObjectList listWithCapacity:3];
			[parameters_list addThis:p_findRequestEntry_employeeID];
			[parameters_list addThis:p_findRequestEntry_startDate];
			[parameters_list addThis:p_findRequestEntry_endDate];
			o_findRequestEntry_3.parameters = parameters_list;
	 	}
		[o_findRequestEntry_3 setIsStatic:YES];
		[o_findRequestEntry_3 setIsCreate:NO];
		[o_findRequestEntry_3 setIsUpdate:NO];
		[o_findRequestEntry_3 setIsDelete:NO]; 		
 		SUPOperationMetaData* o_findByEmployeeIDAndSubmission_2 = [SUPOperationMetaData createOperationMetaData:6:(SUPString)@"findByEmployeeIDAndSubmission":[SUPDataType forName:@"LeaveRequests*"]:true];
	  	{
			SUPObjectList *parameters_list = nil;
	 		SUPParameterMetaData* p_findByEmployeeIDAndSubmission_employeeID = [SUPParameterMetaData createParameterMetaData:1:(SUPString)@"employeeID":[SUPDataType forName:@"string?"]];
	 		SUPParameterMetaData* p_findByEmployeeIDAndSubmission_signCode = [SUPParameterMetaData createParameterMetaData:2:(SUPString)@"signCode":[SUPDataType forName:@"int?"]];
 			parameters_list = [SUPObjectList listWithCapacity:2];
			[parameters_list addThis:p_findByEmployeeIDAndSubmission_employeeID];
			[parameters_list addThis:p_findByEmployeeIDAndSubmission_signCode];
			o_findByEmployeeIDAndSubmission_2.parameters = parameters_list;
	 	}
		[o_findByEmployeeIDAndSubmission_2 setIsStatic:YES];
		[o_findByEmployeeIDAndSubmission_2 setIsCreate:NO];
		[o_findByEmployeeIDAndSubmission_2 setIsUpdate:NO];
		[o_findByEmployeeIDAndSubmission_2 setIsDelete:NO]; 		
 		SUPOperationMetaData* o_refresh_0 = [SUPOperationMetaData createOperationMetaData:7:(SUPString)@"refresh":[SUPDataType forName:@"void"]:true];
		[o_refresh_0 setIsStatic:NO];
		[o_refresh_0 setIsCreate:NO];
		[o_refresh_0 setIsUpdate:NO];
		[o_refresh_0 setIsDelete:NO]; 		
 		SUPOperationMetaData* o__pk_0 = [SUPOperationMetaData createOperationMetaData:8:(SUPString)@"_pk":[SUPDataType forName:@"long?"]:true];
		[o__pk_0 setIsStatic:NO];
		[o__pk_0 setIsCreate:NO];
		[o__pk_0 setIsUpdate:NO];
		[o__pk_0 setIsDelete:NO]; 		
 		SUPOperationMetaData* o_submitPending_0 = [SUPOperationMetaData createOperationMetaData:9:(SUPString)@"submitPending":[SUPDataType forName:@"void"]:true];
		[o_submitPending_0 setIsStatic:NO];
		[o_submitPending_0 setIsCreate:NO];
		[o_submitPending_0 setIsUpdate:NO];
		[o_submitPending_0 setIsDelete:NO]; 		
 		SUPOperationMetaData* o_cancelPending_0 = [SUPOperationMetaData createOperationMetaData:10:(SUPString)@"cancelPending":[SUPDataType forName:@"void"]:true];
		[o_cancelPending_0 setIsStatic:NO];
		[o_cancelPending_0 setIsCreate:NO];
		[o_cancelPending_0 setIsUpdate:NO];
		[o_cancelPending_0 setIsDelete:NO]; 		
 		SUPOperationMetaData* o_submitPendingOperations_0 = [SUPOperationMetaData createOperationMetaData:11:(SUPString)@"submitPendingOperations":[SUPDataType forName:@"void"]:true];
		[o_submitPendingOperations_0 setIsStatic:YES];
		[o_submitPendingOperations_0 setIsCreate:NO];
		[o_submitPendingOperations_0 setIsUpdate:NO];
		[o_submitPendingOperations_0 setIsDelete:NO]; 		
 		SUPOperationMetaData* o_cancelPendingOperations_0 = [SUPOperationMetaData createOperationMetaData:12:(SUPString)@"cancelPendingOperations":[SUPDataType forName:@"void"]:true];
		[o_cancelPendingOperations_0 setIsStatic:YES];
		[o_cancelPendingOperations_0 setIsCreate:NO];
		[o_cancelPendingOperations_0 setIsUpdate:NO];
		[o_cancelPendingOperations_0 setIsDelete:NO]; 		
 		SUPOperationMetaData* o_save_0 = [SUPOperationMetaData createOperationMetaData:13:(SUPString)@"save":[SUPDataType forName:@"void"]:true];
		[o_save_0 setIsStatic:NO];
		[o_save_0 setIsCreate:NO];
		[o_save_0 setIsUpdate:NO];
		[o_save_0 setIsDelete:NO]; 		
 		SUPOperationMetaData* o_findWithQuery_1 = [SUPOperationMetaData createOperationMetaData:14:(SUPString)@"findWithQuery":[SUPDataType forName:@"LeaveRequests*"]:true];
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
 		SUPOperationMetaData* o_getSize_1 = [SUPOperationMetaData createOperationMetaData:15:(SUPString)@"getSize":[SUPDataType forName:@"int"]:true];
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
 
  		SUPObjectList *operations = [SUPObjectList listWithCapacity:15];
 		[operations addThis:o_updateSignCode_0];
 		[operations addThis:o_create_0];
 		[operations addThis:o_findAll_0];
 		[operations addThis:o_findByPrimaryKey_1];
 		[operations addThis:o_findRequestEntry_3];
 		[operations addThis:o_findByEmployeeIDAndSubmission_2];
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
		self.table = @"hr_suite_1_0_leaverequests";
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