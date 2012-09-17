#import "sybase_sup.h"

#import "SUPClassWithMetaData.h"
#import "SUPAbstractEntityRBS.h"
#import "SUPMobileBusinessObject.h"
#import "SUPEntityDelegate.h"


@class SUPEntityMetaDataRBS;
@class SUPEntityDelegate;
@class SUPClassMetaDataRBS;
@class SUPQuery;

// public interface declaration, can be used by application. 
/*!
 @class HR_SuiteUsers
 @abstract This class is part of package "HR_Suite:1.0"
 @discussion Generated by Sybase Unwired Platform, compiler version 2.1.3.231
*/

@interface HR_SuiteUsers : SUPAbstractEntityRBS<SUPMobileBusinessObject, SUPClassWithMetaData>
{
@private
    int32_t _id;
    NSString* _employeeName;
    NSString* _employeeID;
    NSString* _employeePassword;
    NSString* _address;
    NSString* _department;
    NSString* _position;
    NSString* _manager;
    NSString* _email;
    NSString* _phone;
    NSString* _picture;
    NSString* _firstName;
    NSString* _lastName;
    NSString* _fax;
    BOOL _updateManagerCalled;
    int64_t _surrogateKey;
}

@property(assign,nonatomic) int32_t id_;
@property(retain,nonatomic) NSString* employeeName;
@property(retain,nonatomic) NSString* employeeID;
@property(retain,nonatomic) NSString* employeePassword;
@property(retain,nonatomic) NSString* address;
@property(retain,nonatomic) NSString* department;
@property(retain,nonatomic) NSString* position;
@property(retain,nonatomic) NSString* manager;
@property(retain,nonatomic) NSString* email;
@property(retain,nonatomic) NSString* phone;
@property(retain,nonatomic) NSString* picture;
@property(retain,nonatomic) NSString* firstName;
@property(retain,nonatomic) NSString* lastName;
@property(retain,nonatomic) NSString* fax;
@property(assign,nonatomic) BOOL updateManagerCalled;
@property(assign,nonatomic) int64_t surrogateKey;

+ (SUPEntityMetaDataRBS*)metaData;
+ (SUPEntityDelegate *)delegate;
+ (void) registerCallbackHandler:(NSObject<SUPCallbackHandler>*)handler;
+ (NSObject<SUPCallbackHandler>*)callbackHandler;
- (SUPClassMetaDataRBS*)getClassMetaData;
/*!
  @method 
  @abstract Sets relationship attributes to null to save memory (they will be retrieved from the DB on the next getter call or property reference)
  @discussion
  @throws SUPPersistenceException
 */
- (void)clearRelationshipObjects;
- (id) init;
- (void)dealloc;
/*!
  @method 
  @abstract Returns the entity for the primary key value passed in, or null if the entity is not found.
  @discussion
  @throws SUPPersistenceException
 */
+ (HR_SuiteUsers*)find:(int64_t)id_;
/*!
  @method 
  @abstract Returns an SUPObjectList of entity rows satisfying this query
  @discussion
  @throws SUPPersistenceException
 */
+ (SUPObjectList*)findWithQuery:(SUPQuery*)query;
/*!
  @method 
  @abstract Returns the primary key for this entity.
  @discussion
 */
- (int64_t)_pk;
/*!
  @method 
  @abstract Returns the entity for the primary key value passed in; throws an exception if the entity is not found.
  @discussion
  @throws SUPPersistenceException
 */
+ (HR_SuiteUsers*)load:(int64_t)id;
/*!
  @method 
  @abstract Returns an SUPObjectList of log records for this entity.
  @discussion
  @throws SUPPersistenceException
 */
- (SUPObjectList*)getLogRecords;
/*!
  @method 
  @abstract Creates a new autoreleased instance of this class
  @discussion
 */
+ (HR_SuiteUsers*)getInstance;
/*!
  @method 
  @abstract Return a string description of this entity.
  @discussion
 */
- (NSString*)toString;
/*!
  @method 
  @abstract Return a string description of this entity.
  @discussion
 */
- (NSString*)description;
+ (void) submitPendingOperations;
+ (void) cancelPendingOperations;
- (SUPString)getLastOperation;
+ (SUPObjectList*)getPendingObjects;
+ (SUPObjectList*)getPendingObjects:(int32_t)skip take:(int32_t)take;
/*!
  @method
  @abstract Generated instance method of type UPDATE
  @throws SUPPersistenceException
 */
- (void)updateManager;
/*!
  @method
  @abstract Generated instance method of type CREATE
  @throws SUPPersistenceException
 */
- (void)addEmployee;
/*!
  @method
  @abstract Generated from an object query defined in the Eclipse tooling project for this package
  @throws SUPPersistenceException
 */

+ (SUPObjectList*)findAll;

/*!
  @method
  @abstract Generated from an object query defined in the Eclipse tooling project for this package
  @param skip
  @param take
  @throws SUPPersistenceException
 */

+ (SUPObjectList*)findAll:(int32_t)skip take:(int32_t)take;
/*!
  @method
  @abstract Generated from an object query defined in the Eclipse tooling project for this package
  @param id_
  @throws SUPPersistenceException
 */

+ (HR_SuiteUsers*)findByPrimaryKey:(int32_t)id_;
/*!
  @method
  @abstract Generated from an object query defined in the Eclipse tooling project for this package
  @param employeeID
  @param employeePassword
  @throws SUPPersistenceException
 */

+ (SUPObjectList*)findByEmployeeIDAndPassword:(NSString*)employeeID withEmployeePassword:(NSString*)employeePassword;

/*!
  @method
  @abstract Generated from an object query defined in the Eclipse tooling project for this package
  @param employeeID
  @param employeePassword
  @param skip
  @param take
  @throws SUPPersistenceException
 */

+ (SUPObjectList*)findByEmployeeIDAndPassword:(NSString*)employeeID withEmployeePassword:(NSString*)employeePassword skip:(int32_t)skip take:(int32_t)take;
/*!
  @method
  @abstract Generated from an object query defined in the Eclipse tooling project for this package
  @param employeeID
  @throws SUPPersistenceException
 */

+ (SUPObjectList*)findByEmployeeID:(NSString*)employeeID;

/*!
  @method
  @abstract Generated from an object query defined in the Eclipse tooling project for this package
  @param employeeID
  @param skip
  @param take
  @throws SUPPersistenceException
 */

+ (SUPObjectList*)findByEmployeeID:(NSString*)employeeID skip:(int32_t)skip take:(int32_t)take;
/*!
  @method
  @abstract Generated class method 
  @param query
  @throws SUPPersistenceException
 */
+ (int32_t)getSize:(SUPQuery*)query;


@end
typedef SUPObjectList HR_SuiteUsersList;

// internal methods declaration, only used by generated code.
@interface HR_SuiteUsers(internal)


- (SUPJsonObject*)getAttributeJson:(int)id_;
- (void)setAttributeJson:(int)id_:(SUPJsonObject*)value;

-(SUPLong) getAttributeLong:(int)id_;
-(void) setAttributeLong:(int)id_:(SUPLong)v;
-(SUPString) getAttributeNullableString:(int)id_;
-(void) setAttributeNullableString:(int)id_:(SUPString)v;
-(SUPBoolean) getAttributeBoolean:(int)id_;
-(void) setAttributeBoolean:(int)id_:(SUPBoolean)v;
-(SUPInt) getAttributeInt:(int)id_;
-(void) setAttributeInt:(int)id_:(SUPInt)v;
@end