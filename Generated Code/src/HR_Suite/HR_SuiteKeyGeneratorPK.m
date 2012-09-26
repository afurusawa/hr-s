/*
 Generated by Sybase Unwired Platform 
 Compiler version - 2.1.3.358
*/ 

#import "HR_SuiteKeyGeneratorPK.h"
#import "HR_SuiteKeyGeneratorPKMetaData.h"
#import "SUPJsonObject.h"
#import "HR_SuiteHR_SuiteDB.h"
#import "SUPClassDelegate.h"
#import "SUPEntityMetaDataRBS.h"

@implementation HR_SuiteKeyGeneratorPK

@synthesize remoteId = _remoteId;
@synthesize batchId = _batchId;

static SUPClassDelegate *g_HR_SuiteKeyGeneratorPK_delegate = nil;

+ (SUPClassDelegate *) delegate
{
	@synchronized(self) {
		if (g_HR_SuiteKeyGeneratorPK_delegate == nil) {
			g_HR_SuiteKeyGeneratorPK_delegate = [[SUPClassDelegate alloc] initWithName:@"HR_SuiteKeyGeneratorPK" clazz:[self class]
				metaData:[self metaData] dbDelegate:[HR_SuiteHR_SuiteDB delegate] database:[HR_SuiteHR_SuiteDB instance]];
		}
	}
	
	return [[g_HR_SuiteKeyGeneratorPK_delegate retain] autorelease];
}

static SUPClassMetaDataRBS* HR_SuiteKeyGeneratorPK_META_DATA;

+ (SUPClassMetaDataRBS*)metaData
{
    if (HR_SuiteKeyGeneratorPK_META_DATA == nil) {
 	   	HR_SuiteKeyGeneratorPK_META_DATA = [[HR_SuiteKeyGeneratorPKMetaData alloc] init];
	}
	
	return HR_SuiteKeyGeneratorPK_META_DATA;
}

- (SUPClassMetaDataRBS*)getClassMetaData
{
    return [[self class] metaData];
}
- (id) init
{
    if ((self = [super init]))
    {
        self.classMetaData = (SUPEntityMetaDataRBS *)[HR_SuiteKeyGeneratorPK metaData];
        [self setClassDelegate:[[self class] delegate]];
        
    }
    return self;    
}

-(SUPLong) getAttributeLong:(int)id_
{
    switch(id_)
    {
    case 373:
        return self.batchId;
    default:
        return [super getAttributeLong:id_];
    }
}

-(void) setAttributeLong:(int)id_:(SUPLong)v
{
    switch(id_)
    {
    case 373:
        self.batchId = v;
        break;;
    default:
        [super setAttributeLong:id_:v];
        break;;
    }
}
-(SUPString) getAttributeString:(int)id_
{
    switch(id_)
    {
    case 372:
        return self.remoteId;
    default:
        return [super getAttributeString:id_];
    }
}

-(void) setAttributeString:(int)id_:(SUPString)v
{
    switch(id_)
    {
    case 372:
        self.remoteId = v;
        break;;
    default:
        [super setAttributeString:id_:v];
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
+ (HR_SuiteKeyGeneratorPK*)getInstance
{
    HR_SuiteKeyGeneratorPK* me = [[HR_SuiteKeyGeneratorPK alloc] init];
    [me autorelease];
    return me;
}
- (void)dealloc
{
    if(_remoteId)
    {
        [_remoteId release];
        _remoteId = nil;
    }
	[super dealloc];
}

@end