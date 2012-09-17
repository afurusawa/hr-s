#import "sybase_sup.h"

@class SUPClassMap;
@class SUPEntityMap;
@class SUPEntityMetaDataRBS;
@class SUPServiceMap;
@class SUPServiceMetaData;

#import "SUPClassMetaDataRBS.h"

@interface SUPPackageMetaDataRBS : SUPClassMetaDataRBS

+ (SUPPackageMetaDataRBS*)getInstance;

@property(readwrite, retain, nonatomic) SUPObjectList* classList;
@property(readwrite, retain, nonatomic) SUPObjectList* entityList;
@property(readwrite, retain, nonatomic) SUPObjectList* serviceList;
@property(readwrite, retain, nonatomic) SUPClassMap* classMap;
@property(readwrite, retain, nonatomic) SUPEntityMap* entityMap;
@property(readwrite, retain, nonatomic) SUPServiceMap* serviceMap;
@property(readwrite, retain, nonatomic) NSString* packageName;

- (SUPClassMetaDataRBS*)getClass:(SUPString)className;
- (SUPEntityMetaDataRBS*)getEntity:(SUPString)className;
- (SUPServiceMetaData*)getService:(SUPString)className;
@end
