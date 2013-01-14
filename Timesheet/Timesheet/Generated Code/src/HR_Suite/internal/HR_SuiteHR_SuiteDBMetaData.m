#import "HR_SuiteHR_SuiteDBMetaData.h"

#import "SUPObjectList.h"
#import "SUPClassMap.h"
#import "SUPEntityMap.h"
#import "HR_SuiteJobManagement.h"
#import "HR_SuiteJobs.h"
#import "HR_SuiteLeaveRequests.h"
#import "HR_SuiteTimesheet.h"
#import "HR_SuiteTimesheetApprovals.h"
#import "HR_SuiteUsers.h"
#import "HR_SuiteLogRecordImpl.h"
#import "HR_SuiteOperationReplay.h"
#import "HR_SuiteSISSubscriptionKey.h"
#import "HR_SuiteSISSubscription.h"
#import "HR_SuitePackageProperties.h"
#import "HR_SuiteChangeLogKey.h"
#import "HR_SuiteChangeLogImpl.h"
#import "HR_SuiteOfflineAuthentication.h"
#import "HR_SuiteKeyPackageName.h"
#import "HR_SuitePersonalizationParameters.h"
#import "HR_SuiteKeyGenerator.h"
#import "HR_SuiteKeyGeneratorPK.h"
#import "HR_SuiteLocalKeyGenerator.h"
#import "HR_SuiteLocalKeyGeneratorPK.h"

@implementation HR_SuiteHR_SuiteDBMetaData

+ (HR_SuiteHR_SuiteDBMetaData*)getInstance
{
    return [[[HR_SuiteHR_SuiteDBMetaData alloc] init] autorelease];
}

- (id)init
{
    if (self = [super init]) {
		self.id = 0;
		self.databaseName = @"HR_SuiteHR_SuiteDB";
		self.packageName = @"HR_Suite";

		SUPObjectList *classList = [SUPObjectList listWithCapacity:21];
		[classList addThis:[HR_SuiteJobManagement metaData]];
		[HR_SuiteJobManagement delegate];
		[classList addThis:[HR_SuiteJobs metaData]];
		[HR_SuiteJobs delegate];
		[classList addThis:[HR_SuiteLeaveRequests metaData]];
		[HR_SuiteLeaveRequests delegate];
		[classList addThis:[HR_SuiteTimesheet metaData]];
		[HR_SuiteTimesheet delegate];
		[classList addThis:[HR_SuiteTimesheetApprovals metaData]];
		[HR_SuiteTimesheetApprovals delegate];
		[classList addThis:[HR_SuiteUsers metaData]];
		[HR_SuiteUsers delegate];
		[classList addThis:[HR_SuiteLogRecordImpl metaData]];
		[HR_SuiteLogRecordImpl delegate];
		[classList addThis:[HR_SuiteOperationReplay metaData]];
		[HR_SuiteOperationReplay delegate];
		[classList addThis:[HR_SuiteSISSubscriptionKey metaData]];
		[HR_SuiteSISSubscriptionKey delegate];
		[classList addThis:[HR_SuiteSISSubscription metaData]];
		[HR_SuiteSISSubscription delegate];
		[classList addThis:[HR_SuitePackageProperties metaData]];
		[HR_SuitePackageProperties delegate];
		[classList addThis:[HR_SuiteChangeLogKey metaData]];
		[HR_SuiteChangeLogKey delegate];
		[classList addThis:[HR_SuiteChangeLogImpl metaData]];
		[HR_SuiteChangeLogImpl delegate];
		[classList addThis:[HR_SuiteOfflineAuthentication metaData]];
		[HR_SuiteOfflineAuthentication delegate];
		[classList addThis:[HR_SuiteKeyPackageName metaData]];
		[HR_SuiteKeyPackageName delegate];
		[classList addThis:[HR_SuitePersonalizationParameters metaData]];
		[HR_SuitePersonalizationParameters delegate];
		[classList addThis:[HR_SuiteKeyGenerator metaData]];
		[HR_SuiteKeyGenerator delegate];
		[classList addThis:[HR_SuiteKeyGeneratorPK metaData]];
		[HR_SuiteKeyGeneratorPK delegate];
		[classList addThis:[HR_SuiteLocalKeyGenerator metaData]];
		[HR_SuiteLocalKeyGenerator delegate];
		[classList addThis:[HR_SuiteLocalKeyGeneratorPK metaData]];
		[HR_SuiteLocalKeyGeneratorPK delegate];
		self.classList = classList;
		SUPClassMap *classMap = [SUPClassMap getInstance];
		[classMap setClasses:classList];
		self.classMap = classMap;

		SUPObjectList *entityList = [SUPObjectList listWithCapacity:14];
		[entityList addThis:[HR_SuiteJobManagement metaData]];
		[HR_SuiteJobManagement delegate];
		[entityList addThis:[HR_SuiteJobs metaData]];
		[HR_SuiteJobs delegate];
		[entityList addThis:[HR_SuiteLeaveRequests metaData]];
		[HR_SuiteLeaveRequests delegate];
		[entityList addThis:[HR_SuiteTimesheet metaData]];
		[HR_SuiteTimesheet delegate];
		[entityList addThis:[HR_SuiteTimesheetApprovals metaData]];
		[HR_SuiteTimesheetApprovals delegate];
		[entityList addThis:[HR_SuiteUsers metaData]];
		[HR_SuiteUsers delegate];
		[entityList addThis:[HR_SuiteLogRecordImpl metaData]];
		[HR_SuiteLogRecordImpl delegate];
		[entityList addThis:[HR_SuiteOperationReplay metaData]];
		[HR_SuiteOperationReplay delegate];
		[entityList addThis:[HR_SuiteSISSubscription metaData]];
		[HR_SuiteSISSubscription delegate];
		[entityList addThis:[HR_SuitePackageProperties metaData]];
		[HR_SuitePackageProperties delegate];
		[entityList addThis:[HR_SuiteChangeLogImpl metaData]];
		[HR_SuiteChangeLogImpl delegate];
		[entityList addThis:[HR_SuiteOfflineAuthentication metaData]];
		[HR_SuiteOfflineAuthentication delegate];
		[entityList addThis:[HR_SuiteKeyGenerator metaData]];
		[HR_SuiteKeyGenerator delegate];
		[entityList addThis:[HR_SuiteLocalKeyGenerator metaData]];
		[HR_SuiteLocalKeyGenerator delegate];
		self.entityList = entityList;
	    SUPEntityMap *entityMap = [SUPEntityMap getInstance];
    	[entityMap setEntities:entityList];
	    self.entityMap = entityMap;
		SUPObjectList *attributes = [SUPObjectList listWithCapacity:7];
		self.name = @"HR_SuiteDB";
 
       	// Handle attributes
 		self.attributes = attributes;;
 		
 		SUPAttributeMap * attributeMap = [SUPAttributeMap getInstance];
    	[attributeMap setAttributes:attributes];
    	self.attributeMap = attributeMap;

 		// Handle operations
 		int operation_counter = 0;
 		operation_counter++;
 		SUPOperationMetaData* o_createDatabase_0 = [SUPOperationMetaData createOperationMetaData:operation_counter:(SUPString)@"createDatabase":[SUPDataType forName:@"void"]:true];
 		[o_createDatabase_0 setIsStatic:YES];
 		operation_counter++;
 		SUPOperationMetaData* o_cleanAllData_1 = [SUPOperationMetaData createOperationMetaData:operation_counter:(SUPString)@"cleanAllData":[SUPDataType forName:@"void"]:true];
  		{
 			int parameters_counter=0;
 			SUPObjectList *parameters_list = nil;
 			parameters_counter++;
 			SUPParameterMetaData* p_cleanAllData_p0 = [SUPParameterMetaData createParameterMetaData:parameters_counter:(SUPString)@"p0":[SUPDataType forName:@"boolean"]];
 			parameters_list = [SUPObjectList listWithCapacity:parameters_counter];
 			[parameters_list addThis:p_cleanAllData_p0];
 			o_cleanAllData_1.parameters = parameters_list;
 		}
 		[o_cleanAllData_1 setIsStatic:YES];
 		operation_counter++;
 		SUPOperationMetaData* o_cleanAllData_0 = [SUPOperationMetaData createOperationMetaData:operation_counter:(SUPString)@"cleanAllData":[SUPDataType forName:@"void"]:true];
 		[o_cleanAllData_0 setIsStatic:YES];
 		operation_counter++;
 		SUPOperationMetaData* o_getSyncUsername_0 = [SUPOperationMetaData createOperationMetaData:operation_counter:(SUPString)@"getSyncUsername":[SUPDataType forName:@"string"]:true];
 		[o_getSyncUsername_0 setIsStatic:YES];
 		operation_counter++;
 		SUPOperationMetaData* o_loginToSync_2 = [SUPOperationMetaData createOperationMetaData:operation_counter:(SUPString)@"loginToSync":[SUPDataType forName:@"void"]:true];
  		{
 			int parameters_counter=0;
 			SUPObjectList *parameters_list = nil;
 			parameters_counter++;
 			SUPParameterMetaData* p_loginToSync_p0 = [SUPParameterMetaData createParameterMetaData:parameters_counter:(SUPString)@"p0":[SUPDataType forName:@"string"]];
 			parameters_counter++;
 			SUPParameterMetaData* p_loginToSync_p1 = [SUPParameterMetaData createParameterMetaData:parameters_counter:(SUPString)@"p1":[SUPDataType forName:@"string"]];
 			parameters_list = [SUPObjectList listWithCapacity:parameters_counter];
 			[parameters_list addThis:p_loginToSync_p0];
 			[parameters_list addThis:p_loginToSync_p1];
 			o_loginToSync_2.parameters = parameters_list;
 		}
 		[o_loginToSync_2 setIsStatic:YES];
 		operation_counter++;
 		SUPOperationMetaData* o_onlineLogin_2 = [SUPOperationMetaData createOperationMetaData:operation_counter:(SUPString)@"onlineLogin":[SUPDataType forName:@"void"]:true];
  		{
 			int parameters_counter=0;
 			SUPObjectList *parameters_list = nil;
 			parameters_counter++;
 			SUPParameterMetaData* p_onlineLogin_p0 = [SUPParameterMetaData createParameterMetaData:parameters_counter:(SUPString)@"p0":[SUPDataType forName:@"string"]];
 			parameters_counter++;
 			SUPParameterMetaData* p_onlineLogin_p1 = [SUPParameterMetaData createParameterMetaData:parameters_counter:(SUPString)@"p1":[SUPDataType forName:@"string"]];
 			parameters_list = [SUPObjectList listWithCapacity:parameters_counter];
 			[parameters_list addThis:p_onlineLogin_p0];
 			[parameters_list addThis:p_onlineLogin_p1];
 			o_onlineLogin_2.parameters = parameters_list;
 		}
 		[o_onlineLogin_2 setIsStatic:YES];
 		operation_counter++;
 		SUPOperationMetaData* o_offlineLogin_2 = [SUPOperationMetaData createOperationMetaData:operation_counter:(SUPString)@"offlineLogin":[SUPDataType forName:@"boolean"]:true];
  		{
 			int parameters_counter=0;
 			SUPObjectList *parameters_list = nil;
 			parameters_counter++;
 			SUPParameterMetaData* p_offlineLogin_p0 = [SUPParameterMetaData createParameterMetaData:parameters_counter:(SUPString)@"p0":[SUPDataType forName:@"string"]];
 			parameters_counter++;
 			SUPParameterMetaData* p_offlineLogin_p1 = [SUPParameterMetaData createParameterMetaData:parameters_counter:(SUPString)@"p1":[SUPDataType forName:@"string"]];
 			parameters_list = [SUPObjectList listWithCapacity:parameters_counter];
 			[parameters_list addThis:p_offlineLogin_p0];
 			[parameters_list addThis:p_offlineLogin_p1];
 			o_offlineLogin_2.parameters = parameters_list;
 		}
 		[o_offlineLogin_2 setIsStatic:YES];
 		operation_counter++;
 		SUPOperationMetaData* o_synchronize_1 = [SUPOperationMetaData createOperationMetaData:operation_counter:(SUPString)@"synchronize":[SUPDataType forName:@"void"]:true];
  		{
 			int parameters_counter=0;
 			SUPObjectList *parameters_list = nil;
 			parameters_counter++;
 			SUPParameterMetaData* p_synchronize_p0 = [SUPParameterMetaData createParameterMetaData:parameters_counter:(SUPString)@"p0":[SUPDataType forName:@"string"]];
 			parameters_list = [SUPObjectList listWithCapacity:parameters_counter];
 			[parameters_list addThis:p_synchronize_p0];
 			o_synchronize_1.parameters = parameters_list;
 		}
 		[o_synchronize_1 setIsStatic:YES];
 		operation_counter++;
 		SUPOperationMetaData* o_submitPendingOperations_0 = [SUPOperationMetaData createOperationMetaData:operation_counter:(SUPString)@"submitPendingOperations":[SUPDataType forName:@"void"]:true];
 		[o_submitPendingOperations_0 setIsStatic:YES];
 		operation_counter++;
 		SUPOperationMetaData* o_synchronize_0 = [SUPOperationMetaData createOperationMetaData:operation_counter:(SUPString)@"synchronize":[SUPDataType forName:@"void"]:true];
 		[o_synchronize_0 setIsStatic:YES];
 		operation_counter++;
 		SUPOperationMetaData* o_submitPendingOperations_1 = [SUPOperationMetaData createOperationMetaData:operation_counter:(SUPString)@"submitPendingOperations":[SUPDataType forName:@"void"]:true];
  		{
 			int parameters_counter=0;
 			SUPObjectList *parameters_list = nil;
 			parameters_counter++;
 			SUPParameterMetaData* p_submitPendingOperations_p0 = [SUPParameterMetaData createParameterMetaData:parameters_counter:(SUPString)@"p0":[SUPDataType forName:@"string"]];
 			parameters_list = [SUPObjectList listWithCapacity:parameters_counter];
 			[parameters_list addThis:p_submitPendingOperations_p0];
 			o_submitPendingOperations_1.parameters = parameters_list;
 		}
 		[o_submitPendingOperations_1 setIsStatic:YES];
 		operation_counter++;
 		SUPOperationMetaData* o_cancelPendingOperations_0 = [SUPOperationMetaData createOperationMetaData:operation_counter:(SUPString)@"cancelPendingOperations":[SUPDataType forName:@"void"]:true];
 		[o_cancelPendingOperations_0 setIsStatic:YES];
 		operation_counter++;
 		SUPOperationMetaData* o_submitLogRecords_0 = [SUPOperationMetaData createOperationMetaData:operation_counter:(SUPString)@"submitLogRecords":[SUPDataType forName:@"void"]:true];
 		[o_submitLogRecords_0 setIsStatic:YES];
 		operation_counter++;
 		SUPOperationMetaData* o_deleteDatabase_0 = [SUPOperationMetaData createOperationMetaData:operation_counter:(SUPString)@"deleteDatabase":[SUPDataType forName:@"void"]:true];
 		[o_deleteDatabase_0 setIsStatic:YES];
 		operation_counter++;
 		SUPOperationMetaData* o_isSynchronized_1 = [SUPOperationMetaData createOperationMetaData:operation_counter:(SUPString)@"isSynchronized":[SUPDataType forName:@"boolean"]:true];
  		{
 			int parameters_counter=0;
 			SUPObjectList *parameters_list = nil;
 			parameters_counter++;
 			SUPParameterMetaData* p_isSynchronized_p0 = [SUPParameterMetaData createParameterMetaData:parameters_counter:(SUPString)@"p0":[SUPDataType forName:@"string"]];
 			parameters_list = [SUPObjectList listWithCapacity:parameters_counter];
 			[parameters_list addThis:p_isSynchronized_p0];
 			o_isSynchronized_1.parameters = parameters_list;
 		}
 		[o_isSynchronized_1 setIsStatic:YES];
 		operation_counter++;
 		SUPOperationMetaData* o_getLastSynchronizationTime_1 = [SUPOperationMetaData createOperationMetaData:operation_counter:(SUPString)@"getLastSynchronizationTime":[SUPDataType forName:@"dateTime"]:true];
  		{
 			int parameters_counter=0;
 			SUPObjectList *parameters_list = nil;
 			parameters_counter++;
 			SUPParameterMetaData* p_getLastSynchronizationTime_p0 = [SUPParameterMetaData createParameterMetaData:parameters_counter:(SUPString)@"p0":[SUPDataType forName:@"string"]];
 			parameters_list = [SUPObjectList listWithCapacity:parameters_counter];
 			[parameters_list addThis:p_getLastSynchronizationTime_p0];
 			o_getLastSynchronizationTime_1.parameters = parameters_list;
 		}
 		[o_getLastSynchronizationTime_1 setIsStatic:YES];
 		operation_counter++;
 		SUPOperationMetaData* o_getPersonalizationParameters_0 = [SUPOperationMetaData createOperationMetaData:operation_counter:(SUPString)@"getPersonalizationParameters":[SUPDataType forName:@"PersonalizationParameters"]:true];
 		[o_getPersonalizationParameters_0 setIsStatic:YES];
 
  		SUPObjectList *operations = [SUPObjectList listWithCapacity:operation_counter];
 		[operations addThis:o_createDatabase_0];
 		[operations addThis:o_cleanAllData_1];
 		[operations addThis:o_cleanAllData_0];
 		[operations addThis:o_getSyncUsername_0];
 		[operations addThis:o_loginToSync_2];
 		[operations addThis:o_onlineLogin_2];
 		[operations addThis:o_offlineLogin_2];
 		[operations addThis:o_synchronize_1];
 		[operations addThis:o_submitPendingOperations_0];
 		[operations addThis:o_synchronize_0];
 		[operations addThis:o_submitPendingOperations_1];
 		[operations addThis:o_cancelPendingOperations_0];
 		[operations addThis:o_submitLogRecords_0];
 		[operations addThis:o_deleteDatabase_0];
 		[operations addThis:o_isSynchronized_1];
 		[operations addThis:o_getLastSynchronizationTime_1];
 		[operations addThis:o_getPersonalizationParameters_0];
 		self.operations = operations;
 		
		SUPOperationMap *operationMap = [SUPOperationMap getInstance];
		[operationMap setOperations:operations];
		self.operationMap = operationMap;

		SUPStringList *publications = [SUPStringList getInstance];
		NSMutableDictionary *publicationsToEntities = [[[NSMutableDictionary alloc] init] autorelease];
		[publications add:@"default"];
		SUPObjectList *defaultEntities = [SUPObjectList getInstance];
		[defaultEntities add:[HR_SuiteJobManagement metaData]];
		[defaultEntities add:[HR_SuiteJobs metaData]];
		[defaultEntities add:[HR_SuiteLeaveRequests metaData]];
		[defaultEntities add:[HR_SuiteTimesheet metaData]];
		[defaultEntities add:[HR_SuiteTimesheetApprovals metaData]];
		[defaultEntities add:[HR_SuiteUsers metaData]];
		[defaultEntities add:[HR_SuiteLogRecordImpl metaData]];
		[defaultEntities add:[HR_SuiteOperationReplay metaData]];
		[defaultEntities add:[HR_SuiteSISSubscription metaData]];
		[defaultEntities add:[HR_SuitePackageProperties metaData]];
		[defaultEntities add:[HR_SuiteChangeLogImpl metaData]];
		[defaultEntities add:[HR_SuiteKeyGenerator metaData]];
		[publicationsToEntities setObject:defaultEntities forKey:@"default"];
		
		[publications add:@"unsubscribe"];
		SUPObjectList *unsubscribeEntities = [SUPObjectList getInstance];
		[unsubscribeEntities add:[HR_SuiteKeyGenerator metaData]];
		[publicationsToEntities setObject:unsubscribeEntities forKey:@"unsubscribe"];
		
		[publications add:@"system"];
		SUPObjectList *systemEntities = [SUPObjectList getInstance];
		[systemEntities add:[HR_SuiteLogRecordImpl metaData]];
		[systemEntities add:[HR_SuiteOperationReplay metaData]];
		[systemEntities add:[HR_SuiteSISSubscription metaData]];
		[systemEntities add:[HR_SuitePackageProperties metaData]];
		[systemEntities add:[HR_SuiteKeyGenerator metaData]];
		[publicationsToEntities setObject:systemEntities forKey:@"system"];
		
		[publications add:@"initialSync"];
		SUPObjectList *initialSyncEntities = [SUPObjectList getInstance];
		[initialSyncEntities add:[HR_SuitePackageProperties metaData]];
		[initialSyncEntities add:[HR_SuiteKeyGenerator metaData]];
		[publicationsToEntities setObject:initialSyncEntities forKey:@"initialSync"];
		
		self.publicationsMap = publicationsToEntities;
		self.publications = publications;
    }
    return self;
}

@end