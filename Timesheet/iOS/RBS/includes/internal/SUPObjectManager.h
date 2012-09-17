#import "sybase_sup.h"

@class SUPObjectList;
@class SUPAttributeMetaDataRBS;
@class SUPClassMetaDataRBS;
@class SUPOperationMetaData;

@protocol SUPObjectManager

- (id)newObject:(SUPClassMetaDataRBS*)_theClass_1;
- (id)getValue:(id)_theObject_1:(SUPAttributeMetaDataRBS*)_attribute_2;
- (void)setValue:(id)_theObject_1:(SUPAttributeMetaDataRBS*)_attribute_2:(id)_value_3;
- (id)invoke:(id)_theObject_1:(SUPOperationMetaData*)_operation_2:(SUPObjectList*)_parameters_3;

@end
