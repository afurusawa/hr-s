#import "HR_SuiteLogRecordImplMetaData.h"

#import "SUPRelationshipMetaData.h"
#import "SUPParameterMetaData.h"
#import "SUPIndexMetaData.h"
#import "SUPAttributeMap.h"
#import "SUPObjectList.h"
#import "SUPClassMap.h"
#import "SUPEntityMap.h"
#import "HR_SuiteLogRecordImpl.h"
#import "SUPOperationMap.h"
#import "HR_SuiteHR_SuiteDB.h"
#import "SUPDataType.h"

@implementation HR_SuiteLogRecordImplMetaData

+ (HR_SuiteLogRecordImplMetaData*)getInstance
{
    return [[[HR_SuiteLogRecordImplMetaData alloc] init] autorelease];
}

- (id)init
{
    if (self = [super init]) {
		self.id = 5;
		self.name = @"LogRecordImpl";
		self.klass = [HR_SuiteLogRecordImpl class];
 		self.allowPending = YES;;

		self.isClientOnly = NO;

		SUPObjectList *attributes = [SUPObjectList getInstance];
		SUPAttributeMetaDataRBS* a_level = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			60:
			[SUPDataType forName:@"int"]:@"integer":@"level":@"":@"e":
			@"":-1:0:0:
			@"null":NO:@"":
			NO:NO:NO:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_level setColumn:@"e"];
		SUPAttributeMetaDataRBS* a_code = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			61:
			[SUPDataType forName:@"int"]:@"integer":@"code":@"":@"f":
			@"":-1:0:0:
			@"null":NO:@"":
			NO:NO:NO:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_code setColumn:@"f"];
		SUPAttributeMetaDataRBS* a_eisCode = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			62:
			[SUPDataType forName:@"string?"]:@"varchar(10)":@"eisCode":@"":@"g":
			@"":10:0:0:
			@"null":NO:@"":
			NO:NO:YES:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_eisCode setColumn:@"g"];
		SUPAttributeMetaDataRBS* a_message = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			63:
			[SUPDataType forName:@"string?"]:@"varchar(2000)":@"message":@"":@"h":
			@"":2000:0:0:
			@"null":NO:@"":
			NO:NO:YES:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_message setColumn:@"h"];
		SUPAttributeMetaDataRBS* a_component = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			64:
			[SUPDataType forName:@"string?"]:@"varchar(200)":@"component":@"":@"i":
			@"":200:0:0:
			@"null":NO:@"":
			NO:NO:YES:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_component setColumn:@"i"];
		SUPAttributeMetaDataRBS* a_entityKey = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			65:
			[SUPDataType forName:@"string?"]:@"varchar(256)":@"entityKey":@"":@"j":
			@"":256:0:0:
			@"null":NO:@"":
			NO:NO:YES:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_entityKey setColumn:@"j"];
		SUPAttributeMetaDataRBS* a_operation = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			66:
			[SUPDataType forName:@"string?"]:@"varchar(100)":@"operation":@"":@"l":
			@"":100:0:0:
			@"null":NO:@"":
			NO:NO:YES:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_operation setColumn:@"l"];
		SUPAttributeMetaDataRBS* a_requestId = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			67:
			[SUPDataType forName:@"string?"]:@"varchar(100)":@"requestId":@"":@"m":
			@"":100:0:0:
			@"null":NO:@"":
			NO:NO:YES:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_requestId setColumn:@"m"];
		SUPAttributeMetaDataRBS* a_timestamp = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			68:
			[SUPDataType forName:@"dateTime?"]:@"datetime":@"timestamp":@"":@"n":
			@"":-1:0:0:
			@"null":NO:@"":
			NO:NO:YES:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_timestamp setColumn:@"n"];
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
		SUPAttributeMetaDataRBS* a_messageId = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			59:
			[SUPDataType forName:@"long"]:@"decimal(20,0)":@"messageId":@"":@"d":
			@"":-1:0:0:
			@"null":NO:@"":
			YES:NO:NO:NO:NO:NO:
			GeneratedScheme_GLOBAL:
			NO:SUPPersonalizationType_None:NO];
		[a_messageId setColumn:@"d"];
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
 		
		[attributes addThis:a_level];
		[attributes addThis:a_code];
		[attributes addThis:a_eisCode];
		[attributes addThis:a_message];
		[attributes addThis:a_component];
		[attributes addThis:a_entityKey];
		[attributes addThis:a_operation];
		[attributes addThis:a_requestId];
		[attributes addThis:a_timestamp];
		[attributes addThis:a_pending];
		[attributes addThis:a_pendingChange];
		[attributes addThis:a_replayPending];
		[attributes addThis:a_replayFailure];
		[attributes addThis:a_messageId];
		[attributes addThis:a_replayCounter];
		[attributes addThis:a_disableSubmit];
		self.attributes = attributes;
		
		SUPAttributeMap * attributeMap = [SUPAttributeMap getInstance];
   		[attributeMap setAttributes:attributes];
	   	self.attributeMap = attributeMap;

 		SUPOperationMetaData* o_create_0 = [SUPOperationMetaData createOperationMetaData:1:(SUPString)@"create":[SUPDataType forName:@"void"]:true];
		[o_create_0 setIsStatic:NO];
		[o_create_0 setIsCreate:YES];
		[o_create_0 setIsUpdate:NO];
		[o_create_0 setIsDelete:NO]; 		
 		SUPOperationMetaData* o_update_0 = [SUPOperationMetaData createOperationMetaData:2:(SUPString)@"update":[SUPDataType forName:@"void"]:true];
		[o_update_0 setIsStatic:NO];
		[o_update_0 setIsCreate:NO];
		[o_update_0 setIsUpdate:YES];
		[o_update_0 setIsDelete:NO]; 		
 		SUPOperationMetaData* o_delete_0 = [SUPOperationMetaData createOperationMetaData:3:(SUPString)@"delete":[SUPDataType forName:@"void"]:true];
		[o_delete_0 setIsStatic:NO];
		[o_delete_0 setIsCreate:NO];
		[o_delete_0 setIsUpdate:NO];
		[o_delete_0 setIsDelete:YES]; 		
 		SUPOperationMetaData* o_refresh_0 = [SUPOperationMetaData createOperationMetaData:4:(SUPString)@"refresh":[SUPDataType forName:@"void"]:true];
		[o_refresh_0 setIsStatic:NO];
		[o_refresh_0 setIsCreate:NO];
		[o_refresh_0 setIsUpdate:NO];
		[o_refresh_0 setIsDelete:NO]; 		
 		SUPOperationMetaData* o__pk_0 = [SUPOperationMetaData createOperationMetaData:5:(SUPString)@"_pk":[SUPDataType forName:@"long?"]:true];
		[o__pk_0 setIsStatic:NO];
		[o__pk_0 setIsCreate:NO];
		[o__pk_0 setIsUpdate:NO];
		[o__pk_0 setIsDelete:NO]; 		
 		SUPOperationMetaData* o_submitPending_0 = [SUPOperationMetaData createOperationMetaData:6:(SUPString)@"submitPending":[SUPDataType forName:@"void"]:true];
		[o_submitPending_0 setIsStatic:NO];
		[o_submitPending_0 setIsCreate:NO];
		[o_submitPending_0 setIsUpdate:NO];
		[o_submitPending_0 setIsDelete:NO]; 		
 		SUPOperationMetaData* o_cancelPending_0 = [SUPOperationMetaData createOperationMetaData:7:(SUPString)@"cancelPending":[SUPDataType forName:@"void"]:true];
		[o_cancelPending_0 setIsStatic:NO];
		[o_cancelPending_0 setIsCreate:NO];
		[o_cancelPending_0 setIsUpdate:NO];
		[o_cancelPending_0 setIsDelete:NO]; 		
 		SUPOperationMetaData* o_submitPendingOperations_0 = [SUPOperationMetaData createOperationMetaData:8:(SUPString)@"submitPendingOperations":[SUPDataType forName:@"void"]:true];
		[o_submitPendingOperations_0 setIsStatic:YES];
		[o_submitPendingOperations_0 setIsCreate:NO];
		[o_submitPendingOperations_0 setIsUpdate:NO];
		[o_submitPendingOperations_0 setIsDelete:NO]; 		
 		SUPOperationMetaData* o_cancelPendingOperations_0 = [SUPOperationMetaData createOperationMetaData:9:(SUPString)@"cancelPendingOperations":[SUPDataType forName:@"void"]:true];
		[o_cancelPendingOperations_0 setIsStatic:YES];
		[o_cancelPendingOperations_0 setIsCreate:NO];
		[o_cancelPendingOperations_0 setIsUpdate:NO];
		[o_cancelPendingOperations_0 setIsDelete:NO]; 		
 		SUPOperationMetaData* o_save_0 = [SUPOperationMetaData createOperationMetaData:10:(SUPString)@"save":[SUPDataType forName:@"void"]:true];
		[o_save_0 setIsStatic:NO];
		[o_save_0 setIsCreate:NO];
		[o_save_0 setIsUpdate:NO];
		[o_save_0 setIsDelete:NO]; 		
 		SUPOperationMetaData* o_findWithQuery_1 = [SUPOperationMetaData createOperationMetaData:11:(SUPString)@"findWithQuery":[SUPDataType forName:@"LogRecordImpl*"]:true];
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
 		SUPOperationMetaData* o_getSize_1 = [SUPOperationMetaData createOperationMetaData:12:(SUPString)@"getSize":[SUPDataType forName:@"int"]:true];
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
 
  		SUPObjectList *operations = [SUPObjectList listWithCapacity:12];
 		[operations addThis:o_create_0];
 		[operations addThis:o_update_0];
 		[operations addThis:o_delete_0];
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
		self.table = @"hr_suite_1_0_logrecordimpl";
		self.synchronizationGroup = @"system";

		SUPIndexMetaData *i_findByEntityTypeIndex = [[[SUPIndexMetaData alloc] init] autorelease];
		i_findByEntityTypeIndex.name = @"findByEntityTypeIndex";
		[i_findByEntityTypeIndex.attributes add:a_messageId];
		[i_findByEntityTypeIndex.attributes add:a_component];
	
		[self.indexList add:i_findByEntityTypeIndex];
			
		[self.keyList add:a_messageId];


    }
    return self;
}
@end