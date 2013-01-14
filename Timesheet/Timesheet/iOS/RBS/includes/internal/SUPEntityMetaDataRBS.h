#import "sybase_sup.h"
#import "SUPClassMetaDataRBS.h"
#import "SUPEntityMetaDataProtocol.h"

@class SUPDataType;
@class SUPObjectList;
@class SUPRelationshipMetaData;
#define AID_PENDING         20001
#define AID_PENDINGCHANGE   20002
#define AID_DISABLESUBMIT   20003
#define AID_REPLAYCOUNTER   20004
#define AID_REPLAYPENDING   20005
#define AID_REPLAYFAILURE   20006
#define AID_DOWNLOADSTATE   20007
#define AID_ORIGINALSTATE   20008

// Entity state attributes that are in memory
// Their ids starts from 15000;
#define AID_ISPENDING       15001
#define AID_ISCREATED       15002
#define AID_ISUPDATED       15003
#define AID_ISDIRTY         15004
#define AID_ISDELETED       15005

@interface SUPEntityMetaDataRBS : SUPClassMetaDataRBS<SUPEntityMetaDataProtocol>

@property(readwrite, assign, nonatomic) BOOL isClientOnly;
@property(readwrite, assign, nonatomic) BOOL isDynamic;
@property(readwrite, assign, nonatomic) BOOL isReplay;

@property(readwrite, retain, nonatomic) SUPString table;
@property(readwrite, retain, nonatomic) SUPString synchronizationGroup;
@property(readwrite, retain, nonatomic) SUPDataType *keyType;
@property(readwrite, retain, nonatomic) SUPObjectList *keyList;
@property(readwrite, retain, nonatomic) SUPObjectList *indexList;
@property(readwrite, retain, nonatomic) SUPObjectList *relationList;
@property(readwrite, retain, nonatomic) SUPObjectList *otherOperationEntities;
@property(readwrite, retain, nonatomic) NSMutableDictionary *relationMap;
@property(readwrite, retain, nonatomic) SUPAttributeMetaDataRBS *cascadeParent;
@property(readwrite, assign, nonatomic) NSString * keyClass;
- (SUPBoolean)isEntity;
- (SUPRelationshipMetaData *)getRelation:(NSString*)name;
@end
