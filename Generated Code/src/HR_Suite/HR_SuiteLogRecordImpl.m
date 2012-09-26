/*
 Generated by Sybase Unwired Platform 
 Compiler version - 2.1.3.358
*/ 

#import "HR_SuiteLogRecordImpl.h"
#import "HR_SuiteLogRecordImplMetaData.h"
#import "SUPJsonObject.h"
#import "HR_SuiteHR_SuiteDB.h"
#import "SUPEntityDelegate.h"
#import "SUPEntityMetaDataRBS.h"
#import "SUPQuery.h"
#import "HR_SuiteKeyGenerator.h"
#import "HR_SuiteLocalKeyGenerator.h"

@implementation HR_SuiteLogRecordImpl

@synthesize level = _level;
@synthesize code = _code;
@synthesize eisCode = _eisCode;
@synthesize message = _message;
@synthesize component = _component;
@synthesize entityKey = _entityKey;
@synthesize operation = _operation;
@synthesize requestId = _requestId;
@synthesize timestamp = _timestamp;
@synthesize messageId = _messageId;

- (int64_t)messageId
{
    return _messageId;
}

- (void)setLevel:(int32_t)newLevel
{
    if (newLevel != self->_level)
    {
        self->_level = newLevel;
        self.isDirty = YES;
    }
}

- (void)setCode:(int32_t)newCode
{
    if (newCode != self->_code)
    {
        self->_code = newCode;
        self.isDirty = YES;
    }
}

- (void)setEisCode:(NSString*)newEisCode
{
    if (newEisCode != self->_eisCode)
    {
		[self->_eisCode release];
        self->_eisCode = [newEisCode retain];
        self.isDirty = YES;
    }
}

- (void)setMessage:(NSString*)newMessage
{
    if (newMessage != self->_message)
    {
		[self->_message release];
        self->_message = [newMessage retain];
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

- (void)setOperation:(NSString*)newOperation
{
    if (newOperation != self->_operation)
    {
		[self->_operation release];
        self->_operation = [newOperation retain];
        self.isDirty = YES;
    }
}

- (void)setRequestId:(NSString*)newRequestId
{
    if (newRequestId != self->_requestId)
    {
		[self->_requestId release];
        self->_requestId = [newRequestId retain];
        self.isDirty = YES;
    }
}

- (void)setTimestamp:(NSDate*)newTimestamp
{
    if (newTimestamp != self->_timestamp)
    {
		[self->_timestamp release];
        self->_timestamp = [newTimestamp retain];
        self.isDirty = YES;
    }
}

- (void)setMessageId:(int64_t)newMessageId
{
    if (newMessageId != self->_messageId)
    {
        self->_messageId = newMessageId;
        self.isNew = YES;
    }
}

static SUPEntityDelegate *g_HR_SuiteLogRecordImpl_delegate = nil;

+ (SUPEntityDelegate *) delegate
{
	@synchronized(self) {
		if (g_HR_SuiteLogRecordImpl_delegate == nil) {
			g_HR_SuiteLogRecordImpl_delegate = [[SUPEntityDelegate alloc] initWithName:@"HR_SuiteLogRecordImpl" clazz:[self class]
				metaData:[self metaData] dbDelegate:[HR_SuiteHR_SuiteDB delegate] database:[HR_SuiteHR_SuiteDB instance]];
		}
	}
	
	return [[g_HR_SuiteLogRecordImpl_delegate retain] autorelease];
}

static SUPEntityMetaDataRBS* HR_SuiteLogRecordImpl_META_DATA;

+ (SUPEntityMetaDataRBS*)metaData
{
    if (HR_SuiteLogRecordImpl_META_DATA == nil) {
		HR_SuiteLogRecordImpl_META_DATA = [[HR_SuiteLogRecordImplMetaData alloc] init];
	}
	
	return HR_SuiteLogRecordImpl_META_DATA;
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
        self.classMetaData = [HR_SuiteLogRecordImpl metaData];
        [self setEntityDelegate:(SUPEntityDelegate*)[HR_SuiteLogRecordImpl delegate]];
    }
    return self;    
}

- (void)dealloc
{
    if(_eisCode)
    {
        [_eisCode release];
        _eisCode = nil;
    }
    if(_message)
    {
        [_message release];
        _message = nil;
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
    if(_operation)
    {
        [_operation release];
        _operation = nil;
    }
    if(_requestId)
    {
        [_requestId release];
        _requestId = nil;
    }
    if(_timestamp)
    {
        [_timestamp release];
        _timestamp = nil;
    }
	[super dealloc];
}




+ (HR_SuiteLogRecordImpl*)find:(int64_t)id_
{
    SUPObjectList *keys = [SUPObjectList getInstance];
    [keys add:[NSNumber numberWithLong:id_]];
    return (HR_SuiteLogRecordImpl*)[(SUPEntityDelegate*)([[self class] delegate]) findEntityWithKeys:keys];
}

+ (SUPObjectList*)findWithQuery:(SUPQuery*)query
{
    return (SUPObjectList*)[(SUPEntityDelegate*)([[self class] delegate])  findWithQuery:query:[HR_SuiteLogRecordImpl class]];
}

- (int64_t)_pk
{
    return (int64_t)[[self i_pk] longValue];
}

+ (HR_SuiteLogRecordImpl*)load:(int64_t)id_
{
    return (HR_SuiteLogRecordImpl*)[(SUPEntityDelegate*)([[self class] delegate]) load:[NSNumber numberWithLong:id_]];
}

+ (HR_SuiteLogRecordImpl*)getInstance
{
    HR_SuiteLogRecordImpl* me = [[HR_SuiteLogRecordImpl alloc] init];
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
- (HR_SuiteLogRecordImpl*)getDownloadState
{
    return (HR_SuiteLogRecordImpl*)[self i_getDownloadState];
}

- (HR_SuiteLogRecordImpl*) getOriginalState
{
    return (HR_SuiteLogRecordImpl*)[self i_getOriginalState];
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
    case 267:
        return self.messageId;
    default:
         return [super getAttributeLong:id_];
    }
}

-(void) setAttributeLong:(int)id_:(SUPLong)v
{
    switch(id_)
    {
    case 267:
        self.messageId = v;
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
    case 270:
        return self.eisCode;
    case 271:
        return self.message;
    case 272:
        return self.component;
    case 273:
        return self.entityKey;
    case 274:
        return self.operation;
    case 275:
        return self.requestId;
    default:
         return [super getAttributeNullableString:id_];
    }
}

-(void) setAttributeNullableString:(int)id_:(SUPString)v
{
    switch(id_)
    {
    case 270:
        self.eisCode = v;
        break;;
    case 271:
        self.message = v;
        break;;
    case 272:
        self.component = v;
        break;;
    case 273:
        self.entityKey = v;
        break;;
    case 274:
        self.operation = v;
        break;;
    case 275:
        self.requestId = v;
        break;;
    default:
        [super setAttributeNullableString:id_:v];
        break;;
    }
}
-(SUPNullableDateTime) getAttributeNullableDateTime:(int)id_
{
    switch(id_)
    {
    case 276:
        return self.timestamp;
    default:
         return [super getAttributeNullableDateTime:id_];
    }
}

-(void) setAttributeNullableDateTime:(int)id_:(SUPNullableDateTime)v
{
    switch(id_)
    {
    case 276:
        self.timestamp = v;
        break;;
    default:
        [super setAttributeNullableDateTime:id_:v];
        break;;
    }
}
-(SUPInt) getAttributeInt:(int)id_
{
    switch(id_)
    {
    case 268:
        return self.level;
    case 269:
        return self.code;
    default:
         return [super getAttributeInt:id_];
    }
}

-(void) setAttributeInt:(int)id_:(SUPInt)v
{
    switch(id_)
    {
    case 268:
        self.level = v;
        break;;
    case 269:
        self.code = v;
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
   return [HR_SuiteLogRecordImpl findByEntity:@"LogRecordImpl":[self keyToString]];
}




- (NSString*)toString
{
	NSString* str = [NSString stringWithFormat:@"\
	LogRecordImpl = \n\
	    level = %i,\n\
	    code = %i,\n\
	    eisCode = %@,\n\
	    message = %@,\n\
	    component = %@,\n\
	    entityKey = %@,\n\
	    operation = %@,\n\
	    requestId = %@,\n\
	    timestamp = %@,\n\
	    pending = %i,\n\
	    pendingChange = %c,\n\
	    replayPending = %qi,\n\
	    replayFailure = %qi,\n\
	    messageId = %qi,\n\
	    replayCounter = %qi,\n\
	    disableSubmit = %i,\n\
	    isNew = %i,\n\
        isDirty = %i,\n\
        isDeleted = %i,\n\
	\n"
    	,self.level
    	,self.code
    	,self.eisCode
    	,self.message
    	,self.component
    	,self.entityKey
    	,self.operation
    	,self.requestId
    	,self.timestamp
    	,self.pending
    	,self.pendingChange
    	,self.replayPending
    	,self.replayFailure
    	,self.messageId
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


+ (SUPObjectList *)findByEntity:(NSString*)entityName:(NSString*)keyValue
{
    SUPQuery *query = [SUPAbstractEntityRBS getLogRecordQuery:entityName:keyValue];
    SUPObjectList *logList = [HR_SuiteLogRecordImpl findWithQuery:query];
    return logList;    
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