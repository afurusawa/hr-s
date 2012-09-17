/*
 Generated by Sybase Unwired Platform 
 Compiler version - 2.1.3.231
*/ 

#import "HR_SuitePackageProperties.h"
#import "HR_SuitePackagePropertiesMetaData.h"
#import "SUPJsonObject.h"
#import "HR_SuiteHR_SuiteDB.h"
#import "SUPEntityDelegate.h"
#import "SUPEntityMetaDataRBS.h"
#import "SUPQuery.h"
#import "HR_SuiteKeyGenerator.h"
#import "HR_SuiteLocalKeyGenerator.h"
#import "HR_SuiteLogRecordImpl.h"

@implementation HR_SuitePackageProperties

@synthesize value = _value;
@synthesize key = _key;

- (NSString*)value
{

    return _value;
}




- (NSString*)key
{
    return _key;
}

- (void)setValue:(NSString*)newValue
{
    if (newValue != self->_value)
    {
		[self->_value release];
        self->_value = [newValue retain];
        self.isDirty = YES;
    }
}

- (void)setKey:(NSString*)newKey
{
    if (newKey != self->_key)
    {
		[self->_key release];
        self->_key = [newKey retain];
        self.isNew = YES;
    }
}

static SUPEntityDelegate *g_HR_SuitePackageProperties_delegate = nil;

+ (SUPEntityDelegate *) delegate
{
	@synchronized(self) {
		if (g_HR_SuitePackageProperties_delegate == nil) {
			g_HR_SuitePackageProperties_delegate = [[SUPEntityDelegate alloc] initWithName:@"HR_SuitePackageProperties" clazz:[self class]
				metaData:[self metaData] dbDelegate:[HR_SuiteHR_SuiteDB delegate] database:[HR_SuiteHR_SuiteDB instance]];
		}
	}
	
	return [[g_HR_SuitePackageProperties_delegate retain] autorelease];
}

static SUPEntityMetaDataRBS* HR_SuitePackageProperties_META_DATA;

+ (SUPEntityMetaDataRBS*)metaData
{
    if (HR_SuitePackageProperties_META_DATA == nil) {
		HR_SuitePackageProperties_META_DATA = [[HR_SuitePackagePropertiesMetaData alloc] init];
	}
	
	return HR_SuitePackageProperties_META_DATA;
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
        self.classMetaData = [HR_SuitePackageProperties metaData];
        [self setEntityDelegate:(SUPEntityDelegate*)[HR_SuitePackageProperties delegate]];
    }
    return self;    
}

- (void)dealloc
{
    if(_value)
    {
        [_value release];
        _value = nil;
    }
    if(_key)
    {
        [_key release];
        _key = nil;
    }
	[super dealloc];
}




+ (HR_SuitePackageProperties*)find:(NSString*)id_
{
    SUPObjectList *keys = [SUPObjectList getInstance];
    [keys add:id_];
    return (HR_SuitePackageProperties*)[(SUPEntityDelegate*)([[self class] delegate]) findEntityWithKeys:keys];
}

+ (SUPObjectList*)findWithQuery:(SUPQuery*)query
{
    return (SUPObjectList*)[(SUPEntityDelegate*)([[self class] delegate])  findWithQuery:query:[HR_SuitePackageProperties class]];
}

- (NSString*)_pk
{
    return (NSString*)[self i_pk];
}

+ (HR_SuitePackageProperties*)load:(NSString*)id_
{
    return (HR_SuitePackageProperties*)[(SUPEntityDelegate*)([[self class] delegate]) load:id_];
}

+ (HR_SuitePackageProperties*)getInstance
{
    HR_SuitePackageProperties* me = [[HR_SuitePackageProperties alloc] init];
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
- (HR_SuitePackageProperties*)getDownloadState
{
    return (HR_SuitePackageProperties*)[self i_getDownloadState];
}

- (HR_SuitePackageProperties*) getOriginalState
{
    return (HR_SuitePackageProperties*)[self i_getOriginalState];
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

-(SUPString) getAttributeString:(int)id_
{
    switch(id_)
    {
    case 104:
        return self.value;
    case 103:
        return self.key;
    default:
         return [super getAttributeString:id_];
    }
}

-(void) setAttributeString:(int)id_:(SUPString)v
{
    switch(id_)
    {
    case 104:
        self.value = v;
        break;;
    case 103:
        self.key = v;
        break;;
    default:
        [super setAttributeString:id_:v];
        break;;
    }
}
- (SUPObjectList*)getLogRecords
{
   return [HR_SuiteLogRecordImpl findByEntity:@"PackageProperties":[self keyToString]];
}




- (NSString*)toString
{
	NSString* str = [NSString stringWithFormat:@"\
	PackageProperties = \n\
	    value = %@,\n\
	    pending = %i,\n\
	    pendingChange = %c,\n\
	    replayPending = %qi,\n\
	    replayFailure = %qi,\n\
	    key = %@,\n\
	    replayCounter = %qi,\n\
	    disableSubmit = %i,\n\
	    isNew = %i,\n\
        isDirty = %i,\n\
        isDeleted = %i,\n\
	\n"
    	,self.value
    	,self.pending
    	,self.pendingChange
    	,self.replayPending
    	,self.replayFailure
    	,self.key
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
  @abstract Generated class method 
  @param query
  @throws SUPPersistenceException
 */
+ (int32_t)getSize:(SUPQuery*)query
{
    return [(SUPEntityDelegate*)([[self class] delegate]) getSize:query];
}

@end