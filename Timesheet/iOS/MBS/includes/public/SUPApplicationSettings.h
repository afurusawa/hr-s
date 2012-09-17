/*
 
 Copyright (c) Sybase, Inc. 2010   All rights reserved.                                    
 
 In addition to the license terms set out in the Sybase License Agreement for 
 the Sybase Unwired Platform ("Program"), the following additional or different 
 rights and accompanying obligations and restrictions shall apply to the source 
 code in this file ("Code").  Sybase grants you a limited, non-exclusive, 
 non-transferable, revocable license to use, reproduce, and modify the Code 
 solely for purposes of (i) maintaining the Code as reference material to better
 understand the operation of the Program, and (ii) development and testing of 
 applications created in connection with your licensed use of the Program.  
 The Code may not be transferred, sold, assigned, sublicensed or otherwise 
 conveyed (whether by operation of law or otherwise) to another party without 
 Sybase's prior written consent.  The following provisions shall apply to any 
 modifications you make to the Code: (i) Sybase will not provide any maintenance
 or support for modified Code or problems that result from use of modified Code;
 (ii) Sybase expressly disclaims any warranties and conditions, express or 
 implied, relating to modified Code or any problems that result from use of the 
 modified Code; (iii) SYBASE SHALL NOT BE LIABLE FOR ANY LOSS OR DAMAGE RELATING
 TO MODIFICATIONS MADE TO THE CODE OR FOR ANY DAMAGES RESULTING FROM USE OF THE 
 MODIFIED CODE, INCLUDING, WITHOUT LIMITATION, ANY INACCURACY OF DATA, LOSS OF 
 PROFITS OR DIRECT, INDIRECT, SPECIAL, INCIDENTAL OR CONSEQUENTIAL DAMAGES, EVEN
 IF SYBASE HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGES; (iv) you agree 
 to indemnify, hold harmless, and defend Sybase from and against any claims or 
 lawsuits, including attorney's fees, that arise from or are related to the 
 modified Code or from use of the modified Code. 
 
 */



#import <Foundation/Foundation.h>
#import "sybase_core.h"
#import "SUPConnectionUtil.h"


#define SUP_DOMAIN_NAME_PROP "DomainName"
#define SUP_CUSTOM1_PROP "Custom1"
#define SUP_CUSTOM2_PROP "Custom2"
#define SUP_CUSTOM3_PROP "Custom3"
#define SUP_CUSTOM4_PROP "Custom4"
#define SUP_UNKNOWN_PROP "Default"
#define SUP_CONNECTIONID_PROP "ConnectionId"

/*!
 @class
 @abstract  A class that supports the discovery of settings which have been received from the server after application registration and connection.
 @discussion  
 */
@interface SUPApplicationSettings : NSObject {
	
	@private
	NSMutableDictionary* dict;
	
}

/*!
 @property
 @abstract The connection ID.
 @discussion
 */
@property(readonly) SUPNullableString connectionId;
/*!
 @property
 @abstract Custom parameter 1.
 @discussion
 */
@property(readonly) SUPNullableString custom1;
/*!
 @property
 @abstract Custom parameter 2.
 @discussion
 */
@property(readonly) SUPNullableString custom2;
/*!
 @property
 @abstract Custom parameter 3.
 @discussion
 */
@property(readonly) SUPNullableString custom3;
/*!
 @property
 @abstract Custom parameter 4.
 @discussion
 */
@property(readonly) SUPNullableString custom4;
/*!
 @property
 @abstract The domain name.
 @discussion
 */
@property(readonly) SUPNullableString domainName;


/*!
 @function
 @abstract   returns a new instance of SUPApplicationSettings
 @discussion 
 @result     SUPApplicationSettings* instance
 */
+ (SUPApplicationSettings*)getInstance;


/*!
 @function
 @abstract   Get string property from configuration property for given property id.
 @param    propId = SUPConnectionPropertyType
 @result   NSString* value of the property 
 */

- (NSString*)getStringProperty:(SUPConnectionPropertyType)propId;

/*!
 @function
 @abstract   Get a Boolean property from configuration property for given property id.
 @param    propId = SUPConnectionPropertyType
 @result   BOOL value of the property 
 */

- (BOOL) getBooleanProperty:(SUPConnectionPropertyType)propId;

/*!
 @function
 @abstract   Get an int property from configuration property for given property id.
 @param    propId = SUPConnectionPropertyType
 @result   int value of the property 
 */

- (int) getIntegerProperty:(SUPConnectionPropertyType)propId;
/*!
 @function
 @abstract   If application settings are available, return true.  
 @result   
 */
- (BOOL) isApplicationSettingsAvailable;
@end


@interface SUPApplicationSettings  (internal)
- (void)addValueForKey:(SUPNullableString)value key:(SUPNullableString)key;



// CR # 705166 - making the following APIs internal according to this CRs

/*!
 @method     containsKey
 @abstract   Checks if a key occurs within this map.
 @param NSString* key
 @discussion 
 */
- (BOOL)containsKey :(NSString*)key;


/*!
 @method     containsValue
 @abstract   Checks if a value occurs within this map.
 @param NSString* value
 @discussion 
 */
- (BOOL)containsValue :(NSString*)value;

/*!
 @method     item
 @abstract   Returns the associated value with a key in this map
 @param NSString* key
 @result NSString* value
 @discussion 
 */
- (NSString*)item :(NSString*)key;

/*!
 @method     keys
 @abstract   Returns all the keys within this map.
 @param SUPStringList* keys
 @discussion 
 */
- (SUPStringList*)keys;

/*!
 @method     size
 @abstract   Returns the number of entries in this map.
 @result int32_t size of the map
 @discussion 
 */
- (int32_t)size;

/*!
 @method     values
 @abstract   Returns all the values within this map
 @param SUPStringList* values
 @discussion 
 */
- (SUPStringList*)values;






@end
