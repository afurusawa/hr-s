#import "sybase_sup.h"
#import "SUPAttributeMetaDataProtocol.h"

@class SUPObjectList;
@class SUPDataType;

@class SUPAttributeMetaData;

@interface SUPAttributeMetaData : NSObject<SUPAttributeMetaDataProtocol>
{
    SUPInt _ident;
    SUPString _name;
    SUPDataType* _dataType;
    SUPInt _maxLength;
    SUPInt _precision;
    SUPInt _scale;
    SUPNullableString _column;
    SUPBoolean _isKey;
    SUPBoolean _isDynamic;
    SUPBoolean _isReplay;
    SUPBoolean _isStatic;
}

+ (SUPAttributeMetaData*)getInstance;
- (id)init;
+ (SUPObjectList*)EMPTY_LIST;
@property(readwrite, assign, nonatomic) SUPInt ident;
@property(readwrite, retain, nonatomic) SUPString name;
@property(readwrite, retain, nonatomic) SUPDataType* dataType;
@property(readwrite, assign, nonatomic) SUPInt maxLength;
@property(readwrite, assign, nonatomic) SUPInt precision;
@property(readwrite, assign, nonatomic) SUPInt scale;
@property(readwrite, retain, nonatomic) SUPNullableString column;
@property(readwrite, assign, nonatomic) SUPBoolean isKey;
@property(readwrite, assign, nonatomic) SUPBoolean isDynamic;
@property(readwrite, assign, nonatomic) SUPBoolean isReplay;
@property(readwrite, assign, nonatomic) SUPBoolean isStatic;
- (SUPBoolean)isPersistent;
- (SUPBoolean)isBigAttribute;
- (SUPAttributeMetaData*)finishInit;
- (void)initFields;
- (void)dealloc;

@end
