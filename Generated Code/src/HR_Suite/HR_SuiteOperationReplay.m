/*
 Generated by Sybase Unwired Platform 
 Compiler version - 2.1.3.231
*/ 

#import "HR_SuiteOperationReplay.h"
#import "HR_SuiteOperationReplayMetaData.h"
#import "SUPJsonObject.h"
#import "HR_SuiteHR_SuiteDB.h"
#import "SUPLocalEntityDelegate.h"
#import "SUPEntityMetaDataRBS.h"
#import "SUPQuery.h"
#import "HR_SuiteKeyGenerator.h"
#import "HR_SuiteLocalKeyGenerator.h"
#import "HR_SuiteLogRecordImpl.h"

@implementation HR_SuiteOperationReplay

@synthesize remoteId = _remoteId;
@synthesize component = _component;
@synthesize entityKey = _entityKey;
@synthesize attributes = _attributes;
@synthesize operation = _operation;
@synthesize parameters = _parameters;
@synthesize replayLog = _replayLog;
@synthesize exception = _exception;
@synthesize completed = _completed;
@synthesize requestId = _requestId;

- (int64_t)requestId
{
    return _requestId;
}

- (void)setRemoteId:(NSString*)newRemoteId
{
    if (newRemoteId != self->_remoteId)
    {
		[self->_remoteId release];
        self->_remoteId = [newRemoteId retain];
        self.isDirty = YES;
    }
}

- (void)setComponent:(NSString*)newComponent
{
    if (newComponent != self->_component)
    {
		[self->_component release];
        self->_component = [newComponent retain];
        self.isDirty = YES;
    }
}

- (void)setEntityKey:(NSString*)newEntityKey
{
    if (newEntityKey != self->_entityKey)
    {
		[self->_entityKey release];
        self->_entityKey = [newEntityKey retain];
        self.isDirty = YES;
    }
}

- (void)setAttributes:(NSString*)newAttributes
{
    if (newAttributes != self->_attributes)
    {
		[self->_attributes release];
        self->_attributes = [newAttributes retain];
        self.isDirty = YES;
    }
}

- (void)setOperation:(NSString*)newOperation
{
    if (newOperation != self->_operation)
    {
		[self->_operation release];
        self->_operation = [newOperation retain];
        self.isDirty = YES;
    }
}

- (void)setParameters:(NSString*)newParameters
{
    if (newParameters != self->_parameters)
    {
		[self->_parameters release];
        self->_parameters = [newParameters retain];
        self.isDirty = YES;
    }
}

- (void)setReplayLog:(NSString*)newReplayLog
{
    if (newReplayLog != self->_replayLog)
    {
		[self->_replayLog release];
        self->_replayLog = [newReplayLog retain];
        self.isDirty = YES;
    }
}

- (void)setException:(NSString*)newException
{
    if (newException != self->_exception)
    {
		[self->_exception release];
        self->_exception = [newException retain];
        self.isDirty = YES;
    }
}

- (void)setCompleted:(BOOL)newCompleted
{
    if (newCompleted != self->_completed)
    {
        self->_completed = newCompleted;
        self.isDirty = YES;
    }
}

- (void)setRequestId:(int64_t)newRequestId
{
    if (newRequestId != self->_requestId)
    {
        self->_requestId = newRequestId;
        self.isNew = YES;
    }
}

static SUPLocalEntityDelegate *g_HR_SuiteOperationReplay_delegate = nil;

+ (SUPLocalEntityDelegate *) delegate
{
	@synchronized(self) {
		if (g_HR_SuiteOperationReplay_delegate == nil) {
			g_HR_SuiteOperationReplay_delegate = [[SUPLocalEntityDelegate alloc] initWithName:@"HR_SuiteOperationReplay" clazz:[self class]
				metaData:[self metaData] dbDelegate:[HR_SuiteHR_SuiteDB delegate] database:[HR_SuiteHR_SuiteDB instance]];
		}
	}
	
	return [[g_HR_SuiteOperationReplay_delegate retain] autorelease];
}

static SUPEntityMetaDataRBS* HR_SuiteOperationReplay_META_DATA;

+ (SUPEntityMetaDataRBS*)metaData
{
    if (HR_SuiteOperationReplay_META_DATA == nil) {
		HR_SuiteOperationReplay_META_DATA = [[HR_SuiteOperationReplayMetaData alloc] init];
	}
	
	return HR_SuiteOperationReplay_META_DATA;
}

- (SUPClassMetaDataRBS*)getClassMetaData
{
    return [[self class] metaData];
}

- (void)clearRelationshipObjects
{
}

- (id) init
{
    if ((self = [super init]))
    {
        self.classMetaData = [HR_SuiteOperationReplay metaData];
        [self setEntityDelegate:(SUPEntityDelegate*)[HR_SuiteOperationReplay delegate]];
    }
    return self;    
}

- (void)dealloc
{
    if(_remoteId)
    {
        [_remoteId release];
        _remoteId = nil;
    }
    if(_component)
    {
        [_component release];
        _component = nil;
    }
    if(_entityKey)
    {
        [_entityKey release];
        _entityKey = nil;
    }
    if(_attributes)
    {
        [_attributes release];
        _attributes = nil;
    }
    if(_operation)
    {
        [_operation release];
        _operation = nil;
    }
    if(_parameters)
    {
        [_parameters release];
        _parameters = nil;
    }
    if(_replayLog)
    {
        [_replayLog release];
        _replayLog = nil;
    }
    if(_exception)
    {
        [_exception release];
        _exception = nil;
    }
	[super dealloc];
}




+ (HR_SuiteOperationReplay*)find:(int64_t)id_
{
    SUPObjectList *keys = [SUPObjectList getInstance];
    [keys add:[NSNumber numberWithLong:id_]];
    return (HR_SuiteOperationReplay*)[(SUPEntityDelegate*)([[self class] delegate]) findEntityWithKeys:keys];
}

- (int64_t)_pk
{
    return (int64_t)[[self i_pk] longValue];
}

+ (HR_SuiteOperationReplay*)load:(int64_t)id_
{
    return (HR_SuiteOperationReplay*)[(SUPEntityDelegate*)([[self class] delegate]) load:[NSNumber numberWithLong:id_]];
}

+ (HR_SuiteOperationReplay*)getInstance
{
    HR_SuiteOperationReplay* me = [[HR_SuiteOperationReplay alloc] init];
    [me autorelease];
    return me;
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

-(SUPLong) getAttributeLong:(int)id_
{
    switch(id_)
    {
    case 69:
        return self.requestId;
    default:
         return [super getAttributeLong:id_];
    }
}

-(void) setAttributeLong:(int)id_:(SUPLong)v
{
    switch(id_)
    {
    case 69:
        self.requestId = v;
        break;;
    default:
        [super setAttributeLong:id_:v];
        break;;
    }
}
-(SUPString) getAttributeNullableString:(int)id_
{
    switch(id_)
    {
    case 75:
        return self.replayLog;
    case 76:
        return self.exception;
    default:
         return [super getAttributeNullableString:id_];
    }
}

-(void) setAttributeNullableString:(int)id_:(SUPString)v
{
    switch(id_)
    {
    case 75:
        self.replayLog = v;
        break;;
    case 76:
        self.exception = v;
        break;;
    default:
        [super setAttributeNullableString:id_:v];
        break;;
    }
}
-(SUPString) getAttributeString:(int)id_
{
    switch(id_)
    {
    case 68:
        return self.remoteId;
    case 70:
        return self.component;
    case 71:
        return self.entityKey;
    case 72:
        return self.attributes;
    case 73:
        return self.operation;
    case 74:
        return self.parameters;
    default:
         return [super getAttributeString:id_];
    }
}

-(void) setAttributeString:(int)id_:(SUPString)v
{
    switch(id_)
    {
    case 68:
        self.remoteId = v;
        break;;
    case 70:
        self.component = v;
        break;;
    case 71:
        self.entityKey = v;
        break;;
    case 72:
        self.attributes = v;
        break;;
    case 73:
        self.operation = v;
        break;;
    case 74:
        self.parameters = v;
        break;;
    default:
        [super setAttributeString:id_:v];
        break;;
    }
}
-(SUPBoolean) getAttributeBoolean:(int)id_
{
    switch(id_)
    {
    case 77:
        return self.completed;
    default:
         return [super getAttributeBoolean:id_];
    }
}

-(void) setAttributeBoolean:(int)id_:(SUPBoolean)v
{
    switch(id_)
    {
    case 77:
        self.completed = v;
        break;;
    default:
        [super setAttributeBoolean:id_:v];
        break;;
    }
}
- (SUPObjectList*)getLogRecords
{
   return [HR_SuiteLogRecordImpl findByEntity:@"OperationReplay":[self keyToString]];
}




- (NSString*)toString
{
	NSString* str = [NSString stringWithFormat:@"\
	OperationReplay = \n\
	    remoteId = %@,\n\
	    component = %@,\n\
	    entityKey = %@,\n\
	    attributes = %@,\n\
	    operation = %@,\n\
	    parameters = %@,\n\
	    replayLog = %@,\n\
	    exception = %@,\n\
	    completed = %i,\n\
	    requestId = %qi,\n\
	    isNew = %i,\n\
        isDirty = %i,\n\
        isDeleted = %i,\n\
	\n"
    	,self.remoteId
    	,self.component
    	,self.entityKey
    	,self.attributes
    	,self.operation
    	,self.parameters
    	,self.replayLog
    	,self.exception
    	,self.completed
    	,self.requestId
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
  @abstract Generated class method 
  @throws SUPPersistenceException
 */
+ (void)replay
{
    //replay
    // TODO: implement
    NSException *exception = [NSException exceptionWithName:@"NotImplementedException" reason:@"" userInfo:nil];
    @throw exception;
}

/*!
  @method
  @abstract Generated instance method 
  @throws SUPPersistenceException
 */
- (void)mbsReplay
{
    //mbsReplay
    // TODO: implement
    NSException *exception = [NSException exceptionWithName:@"NotImplementedException" reason:@"" userInfo:nil];
    @throw exception;
}

/*!
  @method
  @abstract Generated instance method 
  @throws SUPPersistenceException
 */
- (void)saveErrorInfo
{
    //saveErrorInfo
    // TODO: implement
    NSException *exception = [NSException exceptionWithName:@"NotImplementedException" reason:@"" userInfo:nil];
    @throw exception;
}



+ (SUPObjectList*)findReadyToReplay:(NSString*)remoteId
{
	return [self findReadyToReplay:remoteId skip:0 take:INT_MAX]; 
}


	

+ (SUPObjectList*)findReadyToReplay:(NSString*)remoteId skip:(int32_t)skip take:(int32_t)take
{
	NSMutableString *sql = nil;
	NSMutableString *_selectSQL = nil;
	_selectSQL = [[[NSMutableString alloc] initWithCapacity:209] autorelease];
	[_selectSQL appendString:@" r.\"a\",r.\"c\",r.\"d\",r.\"e\",r.\"f\",r.\"g\",r.\"h\",r.\"i\",r.\"j\",r.\"b\" from \"hr_suite_1_0_operationreplay\" r where r.\"a\" = ? and r.\"j\" = 0 and r.\"l\" = 0 and r.\"m\" is null order by r.\"b\""];
	sql = [[NSMutableString alloc] initWithFormat:@"select %@", _selectSQL];
	[sql autorelease];
	SUPStringList *ids = [SUPStringList listWithCapacity:0];
	SUPObjectList *dts = [SUPObjectList getInstance];
	[dts addObject:[SUPDataType forName:@"string"]];
	SUPObjectList* values = [SUPObjectList getInstance];
	[values addObject:remoteId];
	return (SUPObjectList*)[[[self class] delegate] findWithSQL:sql withDataTypes:dts withValues:values withIDs:ids withSkip:skip withTake:take withClass:[HR_SuiteOperationReplay class]];
}



+ (SUPObjectList*)findAsyncOperationToReplay:(NSString*)remoteId
{
	return [self findAsyncOperationToReplay:remoteId skip:0 take:INT_MAX]; 
}


	

+ (SUPObjectList*)findAsyncOperationToReplay:(NSString*)remoteId skip:(int32_t)skip take:(int32_t)take
{
	NSMutableString *sql = nil;
	NSMutableString *_selectSQL = nil;
	_selectSQL = [[[NSMutableString alloc] initWithCapacity:213] autorelease];
	[_selectSQL appendString:@" r.\"a\",r.\"c\",r.\"d\",r.\"e\",r.\"f\",r.\"g\",r.\"h\",r.\"i\",r.\"j\",r.\"b\" from \"hr_suite_1_0_operationreplay\" r where r.\"a\" = ? and r.\"j\" = 0 and r.\"l\" = 0 and r.\"m\" is not null order by r.\"b\""];
	sql = [[NSMutableString alloc] initWithFormat:@"select %@", _selectSQL];
	[sql autorelease];
	SUPStringList *ids = [SUPStringList listWithCapacity:0];
	SUPObjectList *dts = [SUPObjectList getInstance];
	[dts addObject:[SUPDataType forName:@"string"]];
	SUPObjectList* values = [SUPObjectList getInstance];
	[values addObject:remoteId];
	return (SUPObjectList*)[[[self class] delegate] findWithSQL:sql withDataTypes:dts withValues:values withIDs:ids withSkip:skip withTake:take withClass:[HR_SuiteOperationReplay class]];
}



+ (SUPObjectList*)findReadyToFinish
{
	return [self findReadyToFinish:0 take:INT_MAX]; 
}


	

+ (SUPObjectList*)findReadyToFinish:(int32_t)skip take:(int32_t)take
{
	NSMutableString *sql = nil;
	NSMutableString *_selectSQL = nil;
	_selectSQL = [[[NSMutableString alloc] initWithCapacity:157] autorelease];
	[_selectSQL appendString:@" r.\"a\",r.\"c\",r.\"d\",r.\"e\",r.\"f\",r.\"g\",r.\"h\",r.\"i\",r.\"j\",r.\"b\" from \"hr_suite_1_0_operationreplay\" r where r.\"j\" = 1 order by r.\"b\""];
	sql = [[NSMutableString alloc] initWithFormat:@"select %@", _selectSQL];
	[sql autorelease];
	sql = [[NSMutableString alloc] initWithFormat:@"select %@", _selectSQL];
	[sql autorelease];
	SUPStringList *ids = [SUPStringList listWithCapacity:0];
	SUPObjectList *dts = [SUPObjectList getInstance];
	SUPObjectList* values = [SUPObjectList getInstance];
	return (SUPObjectList*)[[[self class] delegate] findWithSQL:sql withDataTypes:dts withValues:values withIDs:ids withSkip:skip withTake:take withClass:[HR_SuiteOperationReplay class]];
}

@end