#import "sybase_sup.h"
#import "SUPPackageMetaDataRBS.h"
#import "SUPDatabaseMetaDataProtocol.h"

@interface SUPDatabaseMetaDataRBS : SUPPackageMetaDataRBS<SUPDatabaseMetaDataProtocol>
{
}

+ (SUPDatabaseMetaDataRBS*)getInstance;

@property(readwrite, retain, nonatomic) SUPString databaseName;
@property(readwrite, retain, nonatomic) SUPString databaseFile;
@property(readwrite, retain, nonatomic) SUPStringList* publications;
@property(readwrite, retain, nonatomic) NSMutableDictionary* publicationsMap;
- (SUPObjectList*)getEntitiesByPublication:(NSString*)publicationName;
@end
