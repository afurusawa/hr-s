/*
 Generated by Sybase Unwired Platform 
 Compiler version - 2.1.3.358
*/ 

#import "HR_SuiteTimesheetApprovals.h"
#import "HR_SuiteTimesheetApprovalsMetaData.h"
#import "SUPJsonObject.h"
#import "HR_SuiteHR_SuiteDB.h"
#import "SUPEntityDelegate.h"
#import "SUPEntityMetaDataRBS.h"
#import "SUPQuery.h"
#import "HR_SuiteKeyGenerator.h"
#import "HR_SuiteLocalKeyGenerator.h"
#import "HR_SuiteLogRecordImpl.h"

@implementation HR_SuiteTimesheetApprovals

@synthesize id_ = _id;
@synthesize date = _date;
@synthesize employeeID = _employeeID;
@synthesize signCode = _signCode;
@synthesize timestamp = _timestamp;
@synthesize managerNotes = _managerNotes;
@synthesize updateManagerCalled = _updateManagerCalled;
@synthesize surrogateKey = _surrogateKey;

- (int64_t)surrogateKey
{
    return _surrogateKey;
}

- (void)setId_:(int32_t)newId_
{
    if (newId_ != self->_id)
    {
        self->_id = newId_;
        self.isDirty = YES;
    }
}

- (void)setDate:(NSString*)newDate
{
    if (newDate != self->_date)
    {
		[self->_date release];
        self->_date = [newDate retain];
        self.isDirty = YES;
    }
}

- (void)setEmployeeID:(NSString*)newEmployeeID
{
    if (newEmployeeID != self->_employeeID)
    {
		[self->_employeeID release];
        self->_employeeID = [newEmployeeID retain];
        self.isDirty = YES;
    }
}

- (void)setSignCode:(NSNumber*)newSignCode
{
    if (newSignCode != self->_signCode)
    {
		[self->_signCode release];
        self->_signCode = [newSignCode retain];
        self.isDirty = YES;
    }
}

- (void)setTimestamp:(NSString*)newTimestamp
{
    if (newTimestamp != self->_timestamp)
    {
		[self->_timestamp release];
        self->_timestamp = [newTimestamp retain];
        self.isDirty = YES;
    }
}

- (void)setManagerNotes:(NSString*)newManagerNotes
{
    if (newManagerNotes != self->_managerNotes)
    {
		[self->_managerNotes release];
        self->_managerNotes = [newManagerNotes retain];
        self.isDirty = YES;
    }
}

- (void)setUpdateManagerCalled:(BOOL)newUpdateManagerCalled
{
    if (newUpdateManagerCalled != self->_updateManagerCalled)
    {
        self->_updateManagerCalled = newUpdateManagerCalled;
        self.isDirty = YES;
    }
}

- (void)setSurrogateKey:(int64_t)newSurrogateKey
{
    if (newSurrogateKey != self->_surrogateKey)
    {
        self->_surrogateKey = newSurrogateKey;
        self.isNew = YES;
    }
}

static SUPEntityDelegate *g_HR_SuiteTimesheetApprovals_delegate = nil;

+ (SUPEntityDelegate *) delegate
{
	@synchronized(self) {
		if (g_HR_SuiteTimesheetApprovals_delegate == nil) {
			g_HR_SuiteTimesheetApprovals_delegate = [[SUPEntityDelegate alloc] initWithName:@"HR_SuiteTimesheetApprovals" clazz:[self class]
				metaData:[self metaData] dbDelegate:[HR_SuiteHR_SuiteDB delegate] database:[HR_SuiteHR_SuiteDB instance]];
		}
	}
	
	return [[g_HR_SuiteTimesheetApprovals_delegate retain] autorelease];
}

static SUPEntityMetaDataRBS* HR_SuiteTimesheetApprovals_META_DATA;

+ (SUPEntityMetaDataRBS*)metaData
{
    if (HR_SuiteTimesheetApprovals_META_DATA == nil) {
		HR_SuiteTimesheetApprovals_META_DATA = [[HR_SuiteTimesheetApprovalsMetaData alloc] init];
	}
	
	return HR_SuiteTimesheetApprovals_META_DATA;
}

- (SUPClassMetaDataRBS*)getClassMetaData
{
    return [[self class] metaData];
}

- (void)clearRelationshipObjects
{
}

+ (NSObject<SUPCallbackHandler>*)callbackHandler
{
	return [[self delegate] callbackHandler];
}

+ (void)registerCallbackHandler:(NSObject<SUPCallbackHandler>*)newCallbackHandler
{
	[[self delegate] registerCallbackHandler:newCallbackHandler];
}
- (id) init
{
    if ((self = [super init]))
    {
        self.classMetaData = [HR_SuiteTimesheetApprovals metaData];
        [self setEntityDelegate:(SUPEntityDelegate*)[HR_SuiteTimesheetApprovals delegate]];
    }
    return self;    
}

- (void)dealloc
{
    if(_date)
    {
        [_date release];
        _date = nil;
    }
    if(_employeeID)
    {
        [_employeeID release];
        _employeeID = nil;
    }
    if(_signCode)
    {
        [_signCode release];
        _signCode = nil;
    }
    if(_timestamp)
    {
        [_timestamp release];
        _timestamp = nil;
    }
    if(_managerNotes)
    {
        [_managerNotes release];
        _managerNotes = nil;
    }
	[super dealloc];
}




+ (HR_SuiteTimesheetApprovals*)find:(int64_t)id_
{
    SUPObjectList *keys = [SUPObjectList getInstance];
    [keys add:[NSNumber numberWithLong:id_]];
    return (HR_SuiteTimesheetApprovals*)[(SUPEntityDelegate*)([[self class] delegate]) findEntityWithKeys:keys];
}

+ (SUPObjectList*)findWithQuery:(SUPQuery*)query
{
    return (SUPObjectList*)[(SUPEntityDelegate*)([[self class] delegate])  findWithQuery:query:[HR_SuiteTimesheetApprovals class]];
}

- (int64_t)_pk
{
    return (int64_t)[[self i_pk] longValue];
}

+ (HR_SuiteTimesheetApprovals*)load:(int64_t)id_
{
    return (HR_SuiteTimesheetApprovals*)[(SUPEntityDelegate*)([[self class] delegate]) load:[NSNumber numberWithLong:id_]];
}

+ (HR_SuiteTimesheetApprovals*)getInstance
{
    HR_SuiteTimesheetApprovals* me = [[HR_SuiteTimesheetApprovals alloc] init];
    [me autorelease];
    return me;
}
- (SUPString)getLastOperation
{
    if (self.pendingChange == 'C')
    {
        return @"create";
    }
    else if (self.pendingChange == 'D')
    {
        return @"delete";
    }
    else if (self.pendingChange == 'U')
    {
        return @"update";
    }
    return @"";

}
+ (void)submitPendingOperations
{
    [[[self class] delegate] submitPendingOperations];
}

+ (void)cancelPendingOperations
{
    [[[self class] delegate] cancelPendingOperations];
}
- (HR_SuiteTimesheetApprovals*)getDownloadState
{
    return (HR_SuiteTimesheetApprovals*)[self i_getDownloadState];
}

- (HR_SuiteTimesheetApprovals*) getOriginalState
{
    return (HR_SuiteTimesheetApprovals*)[self i_getOriginalState];
}
- (SUPJsonObject*)getAttributeJson:(int)id_
{
    switch(id_)
    {
        default:
        return [super getAttributeJson:id_];
    }

}
- (void)setAttributeJson:(int)id_:(SUPJsonObject*)value
{
    switch(id_)
    { 
        default:
            [super setAttributeJson:id_:value];
            break;
    }

}

-(SUPLong) getAttributeLong:(int)id_
{
    switch(id_)
    {
    case 245:
        return self.surrogateKey;
    default:
         return [super getAttributeLong:id_];
    }
}

-(void) setAttributeLong:(int)id_:(SUPLong)v
{
    switch(id_)
    {
    case 245:
        self.surrogateKey = v;
        break;;
    default:
        [super setAttributeLong:id_:v];
        break;;
    }
}
-(SUPNullableInt) getAttributeNullableInt:(int)id_
{
    switch(id_)
    {
    case 242:
        return self.signCode;
    default:
         return [super getAttributeNullableInt:id_];
    }
}

-(void) setAttributeNullableInt:(int)id_:(SUPNullableInt)v
{
    switch(id_)
    {
    case 242:
        self.signCode = v;
        break;;
    default:
        [super setAttributeNullableInt:id_:v];
        break;;
    }
}
-(SUPString) getAttributeNullableString:(int)id_
{
    switch(id_)
    {
    case 240:
        return self.date;
    case 241:
        return self.employeeID;
    case 243:
        return self.timestamp;
    case 244:
        return self.managerNotes;
    default:
         return [super getAttributeNullableString:id_];
    }
}

-(void) setAttributeNullableString:(int)id_:(SUPString)v
{
    switch(id_)
    {
    case 240:
        self.date = v;
        break;;
    case 241:
        self.employeeID = v;
        break;;
    case 243:
        self.timestamp = v;
        break;;
    case 244:
        self.managerNotes = v;
        break;;
    default:
        [super setAttributeNullableString:id_:v];
        break;;
    }
}
-(SUPBoolean) getAttributeBoolean:(int)id_
{
    switch(id_)
    {
    case 246:
        return self.updateManagerCalled;
    default:
         return [super getAttributeBoolean:id_];
    }
}

-(void) setAttributeBoolean:(int)id_:(SUPBoolean)v
{
    switch(id_)
    {
    case 246:
        self.updateManagerCalled = v;
        break;;
    default:
        [super setAttributeBoolean:id_:v];
        break;;
    }
}
-(SUPInt) getAttributeInt:(int)id_
{
    switch(id_)
    {
    case 239:
        return self.id_;
    default:
         return [super getAttributeInt:id_];
    }
}

-(void) setAttributeInt:(int)id_:(SUPInt)v
{
    switch(id_)
    {
    case 239:
        self.id_ = v;
        break;;
    default:
        [super setAttributeInt:id_:v];
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
- (SUPObjectList*)getLogRecords
{
   return [HR_SuiteLogRecordImpl findByEntity:@"TimesheetApprovals":[self keyToString]];
}




- (NSString*)toString
{
	NSString* str = [NSString stringWithFormat:@"\
	TimesheetApprovals = \n\
	    id = %i,\n\
	    date = %@,\n\
	    employeeID = %@,\n\
	    signCode = %@,\n\
	    timestamp = %@,\n\
	    managerNotes = %@,\n\
	    updateManagerCalled = %i,\n\
	    pending = %i,\n\
	    pendingChange = %c,\n\
	    replayPending = %qi,\n\
	    replayFailure = %qi,\n\
	    surrogateKey = %qi,\n\
	    replayCounter = %qi,\n\
	    disableSubmit = %i,\n\
	    isNew = %i,\n\
        isDirty = %i,\n\
        isDeleted = %i,\n\
	\n"
    	,self.id_
    	,self.date
    	,self.employeeID
    	,self.signCode
    	,self.timestamp
    	,self.managerNotes
    	,self.updateManagerCalled
    	,self.pending
    	,self.pendingChange
    	,self.replayPending
    	,self.replayFailure
    	,self.surrogateKey
    	,self.replayCounter
    	,self.disableSubmit
		,self.isNew
		,self.isDirty
		,self.isDeleted
	];
	return str;

}

- (NSString*)description
{
	return [self toString];
}
+ (SUPObjectList*)getPendingObjects
{
    return (SUPObjectList*)[(SUPEntityDelegate*)[[self class] delegate] getPendingObjects];
}

+ (SUPObjectList*)getPendingObjects:(int32_t)skip take:(int32_t)take
{
    return (SUPObjectList*)[(SUPEntityDelegate*)[[self class] delegate] getPendingObjects:skip:take];
}


/*!
  @method
  @abstract Generated instance method of type UPDATE
  @throws SUPPersistenceException
 */
- (void)updateSignCode
{
    self.isDirty = YES;
    self.updateManagerCalled = NO;
    [self update];
}

/*!
  @method
  @abstract Generated instance method of type UPDATE
  @throws SUPPersistenceException
 */
- (void)updateManager
{
    self.isDirty = YES;
    self.updateManagerCalled = NO;
    self.updateManagerCalled = YES;
    [self update];
}



+ (SUPObjectList*)findAll
{
	return [self findAll:0 take:INT_MAX]; 
}


	

+ (SUPObjectList*)findAll:(int32_t)skip take:(int32_t)take
{
	NSMutableString *sql = nil;
	NSMutableString *_selectSQL = nil;
	_selectSQL = [[[NSMutableString alloc] initWithCapacity:305] autorelease];
	[_selectSQL appendString:@" x.\"a\",x.\"b\",x.\"c\",x.\"d\",x.\"e\",x.\"f\",x.\"h\",x.\"_pf\",x.\"_pc\",x.\"_rp\",x.\"_rf\",x.\"g\",x.\"_rc\",x.\"_ds\" FROM \"hr_suite_1_0_timesheetapprovals\" x where (((x.\"_pf\" = 1 or not exists (select x_os.\"g\" from \"hr_suite_1_0_timesheetapprovals_os\" x_os where x_os.\"g\" = x.\"g\"))))"];
	sql = [[NSMutableString alloc] initWithFormat:@"select %@", _selectSQL];
	[sql autorelease];
	sql = [[NSMutableString alloc] initWithFormat:@"select %@", _selectSQL];
	[sql autorelease];
	SUPStringList *ids = [SUPStringList listWithCapacity:0];
	SUPObjectList *dts = [SUPObjectList getInstance];
	SUPObjectList* values = [SUPObjectList getInstance];
	return (SUPObjectList*)[[[self class] delegate] findWithSQL:sql withDataTypes:dts withValues:values withIDs:ids withSkip:skip withTake:take withClass:[HR_SuiteTimesheetApprovals class]];
}



+ (HR_SuiteTimesheetApprovals*)findByPrimaryKey:(int32_t)id_
{
	NSMutableString *sql = nil;
	NSMutableString *_selectSQL = nil;
	_selectSQL = [[[NSMutableString alloc] initWithCapacity:339] autorelease];
	[_selectSQL appendString:@"SELECT x.\"a\",x.\"b\",x.\"c\",x.\"d\",x.\"e\",x.\"f\",x.\"h\",x.\"_pf\",x.\"_pc\",x.\"_rp\",x.\"_rf\",x.\"g\",x.\"_rc\",x.\"_ds\" FROM \"hr_suite_1_0_timesheetapprovals\" x WHERE (((x.\"_pf\" = 1 or not exists (select x_os.\"g\" from \"hr_suite_1_0_timesheetapprovals_os\" x_os where x_os.\"g\" = x.\"g\")))) "
	                               "and ( x.\"a\" = ?)"];
	sql = [[NSMutableString alloc] initWithFormat:@"%@", _selectSQL];
	[sql autorelease];
	SUPStringList *ids = [SUPStringList listWithCapacity:0];
	SUPObjectList *dts = [SUPObjectList getInstance];
	[dts addObject:[SUPDataType forName:@"int"]];
	SUPObjectList* values = [SUPObjectList getInstance];
	[values addObject:[NSNumber numberWithInt:id_]];
	
	SUPObjectList* res = (SUPObjectList*)[[[self class] delegate] findWithSQL:sql withDataTypes:dts withValues:values withIDs:ids withClass:[HR_SuiteTimesheetApprovals class]];
	if(res && ([res size] > 0))
	{   
		HR_SuiteTimesheetApprovals* cus = (HR_SuiteTimesheetApprovals*)[res item:0];
	    return cus;
	}
	else
	    return nil;
}

/*!
  @method
  @abstract Generated class method 
  @param query
  @throws SUPPersistenceException
 */
+ (int32_t)getSize:(SUPQuery*)query
{
    return [(SUPEntityDelegate*)([[self class] delegate]) getSize:query];
}

@end