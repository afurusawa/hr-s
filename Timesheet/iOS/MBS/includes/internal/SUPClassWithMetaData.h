#import "sybase_sup.h"

@class SUPClassMetaDataRBS;

@protocol SUPClassWithMetaData

- (SUPClassMetaDataRBS*)getClassMetaData;

@end
