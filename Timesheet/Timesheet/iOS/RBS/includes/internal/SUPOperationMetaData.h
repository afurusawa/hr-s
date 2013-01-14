#import "sybase_sup.h"
#import "SUPObjectList.h"
#import "SUPParameterMetaData.h"

@interface SUPOperationMetaData : NSObject

+ (SUPOperationMetaData*)createOperationMetaData:(SUPInt)o_id:(SUPString)o_name:(SUPDataType*)o_type:(bool)o_isStatic;
+ (SUPOperationMetaData*)getInstance;

@property(readwrite, assign) SUPInt id;
@property(readwrite, retain) SUPString name;
@property(readwrite, retain) SUPString displayName;
@property(readwrite, retain) SUPObjectList* parameters;
@property(readwrite, retain) SUPDataType* returnType;
@property(readwrite, assign) SUPBoolean isCreate;
@property(readwrite, assign) SUPBoolean isUpdate;
@property(readwrite, assign) SUPBoolean isDelete;
@property(readwrite, assign) SUPBoolean isReplay;
@property(readwrite, assign) SUPBoolean isStatic;

- (SUPParameterMetaData*)getParameter:(SUPString)name;
- (SUPOperationMetaData*)finishInit;
- (void)dealloc;
@end
