#import "sybase_sup.h"
#import "SUPAttributeMetaDataProtocol.h"

@class SUPObjectList;
@class SUPDataType;
@class SUPDataValue;
@class SUPAttributeMetaDataRBS;

typedef enum
{
    SUPPersonalizationType_Server,
    SUPPersonalizationType_Client,
    SUPPersonalizationType_Session,
    SUPPersonalizationType_None
} SUPPersonalizationType;

typedef 
enum
{
    GeneratedScheme_NONE,
    GeneratedScheme_GLOBAL,
    GeneratedScheme_LOCAL,
    GeneratedScheme_GUID
} GENERATED_SCHEME;
@interface SUPAttributeMetaDataRBS : NSObject<SUPAttributeMetaDataProtocol>
{
}

@property(readwrite, assign, nonatomic) SUPInt ident;
@property(readwrite, retain, nonatomic) SUPDataType *dataType;
@property(readwrite, retain, nonatomic) SUPString name;
@property(readwrite, retain, nonatomic) SUPString sqlType;
@property(readwrite, retain, nonatomic) SUPString column;
@property(readwrite, retain, nonatomic) SUPNullableString sqlDefault;
@property(readwrite, assign, nonatomic) SUPInt maxLength;
@property(readwrite, assign, nonatomic) SUPInt precision;
@property(readwrite, assign, nonatomic) SUPInt scale;
@property(readwrite, retain, nonatomic) SUPString defaultValue;
@property(readwrite, retain, nonatomic) SUPString defaultKey;
@property(readwrite, assign, nonatomic) SUPBoolean isKey;
@property(readwrite, assign, nonatomic) SUPBoolean isStatic;
@property(readwrite, assign, nonatomic) SUPBoolean isNullable;
@property(readwrite, assign, nonatomic) SUPBoolean isLazyLoad;
@property(readwrite, assign, nonatomic) SUPBoolean isAssociation;
@property(readwrite, assign, nonatomic) SUPBoolean isCascadeParent;
@property(readwrite, assign, nonatomic) GENERATED_SCHEME generatedScheme;
@property(readwrite, retain, nonatomic) SUPString shortName;
@property(readwrite, assign, nonatomic) SUPBoolean isSynchronizationParameters;

- (SUPBoolean)isPersistent;
- (SUPBoolean)isBigAttribute;
- (SUPBoolean)isList;
//+ (id)attributeMetaDataWith:(SUPInt)a_id:(SUPDataType*)a_typ:(SUPString)a_sqlType:(SUPString)a_name:(SUPString)a_shortName:(SUPString)a_column:(SUPNullableString)a_sqlDefault:(SUPInt)a_Length:(SUPInt)a_precision:(SUPInt)a_scale:(SUPDataValue *)a_defaultValue:(SUPBoolean)a_isKey:(SUPBoolean)a_isStatic:(SUPBoolean)a_isNullable:(SUPBoolean)a_isLazyLoad:(SUPBoolean)a_isAssociation:(SUPBoolean)a_isCascadeParent:(GENERATED_SCHEME)a_idSchema:(BOOL)a_isSyncParam;
+ (id)attributeMetaDataWith:(SUPInt)a_id:(SUPDataType*)a_typ:(SUPString)a_sqlType:(SUPString)a_name:(SUPString)a_shortName:(SUPString)a_column:(SUPNullableString)a_sqlDefault:(SUPInt)a_Length:(SUPInt)a_precision:(SUPInt)a_scale:(SUPString)a_defaultValue:(BOOL)a_defaultIsNull:(SUPString)a_defaultKey:(SUPBoolean)a_isKey:(SUPBoolean)a_isStatic:(SUPBoolean)a_isNullable:(SUPBoolean)a_isLazyLoad:(SUPBoolean)a_isAssociation:(SUPBoolean)a_isCascadeParent:(GENERATED_SCHEME)a_idSchema:(BOOL)a_isSyncParam:(SUPPersonalizationType) a_personalizationType:(BOOL)a_isEncrypted;
+ (id)getInstance;

@end

@interface SUPAttributeMetaDataRBS (internal)

- (SUPBoolean)isBigString;
- (SUPBoolean)isBigBinary;

@end
