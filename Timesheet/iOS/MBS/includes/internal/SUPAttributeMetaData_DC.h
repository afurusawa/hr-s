#import "sybase_sup.h"

@class SUPStringList;
@class SUPStringUtil;

#import "SUPAttributeMetaData.h"

@class SUPAttributeMetaData_DC;

@interface SUPAttributeMetaData_DC : SUPAttributeMetaData
{
}

+ (SUPAttributeMetaData_DC*)getInstance;
+ (SUPAttributeMetaData_DC*)createAttributeMetaData:(SUPInt)a_id:(SUPString)a_name:(SUPDataType*)a_type;

@end
