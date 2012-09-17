/*
 
 Copyright (c) Sybase, Inc. 2012   All rights reserved.                                    
 
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


#import "sybase_sup.h"


/*!
 @class 
 @abstract A map associating keys of type string with values of type string.
 @discussion  
 */

@interface SUPStringProperties : NSObject
{
@private
    NSMutableDictionary *d;
}

- (SUPStringProperties*)init;
- (void)dealloc;

/*!
 @method
 @abstract   Returns a new instance of SUPStringProperties.
 @discussion
 @result The initalized SUPStringProperties.
 */
+ (SUPStringProperties*)getInstance;

/*!
 @method
 @abstract   Add a new key/value association to this map. If an association already exists for the key, it is replaced.
 @discussion If an attempt is made to add a null key, an SUPNullPointerException will be thrown.
 @param key The key string.
 @param value The value string.
 @throws SUPNullPointerException
 */
- (void)add:(NSString*)key withValue:(NSString*)value;

/*!
 @method
 @abstract   Removes all key/value associations from this map.
 @discussion
 */
- (void)clear;

/*!
 @method
 @abstract   Checks if a string is one of the keys in this map.
 @discussion
 @result True if the key occurs, false otherwise.
 */
- (BOOL)containsKey:(NSString*)key;

/*!
 @method
 @abstract   Checks if a string is one of the values in this  map.
 @discussion
 @result True if the value occurs, false otherwise.
 */
- (BOOL)containsValue:(NSString*)value;

/*!
 @method
 @abstract   Returns the string value for a key.
 @discussion
 @param key The key to search for.
 @result The string value for the key, or nil if the key is not in this map.
 */
- (NSString*)item:(NSString*)key;

/*!
 @method
 @abstract   Returns an SUPStringList of all keys in this map.
 @discussion
 @result A list of the keys; if the map is empty, an empty list.
 */
- (SUPStringList*)keys;

/*!
 @method
 @abstract   Returns an SUPStringList of all values in this map.
 @discussion
 @result A list of the values; if the map is empty, an empty list.
 */
- (SUPStringList*)values;

/*!
 @method
 @abstract   Removes a key/value pair from the map.
 @discussion  Attempting to remove a key not in the map will return with no effect.
 @param key The key to remove.
 */
- (void)remove:(NSString*)key;

/*!
 @method
 @abstract   Returns the number of key/value pairs in the map.
 @discussion
 @result The size of the map.
 */
- (int)size;



@end

@interface SUPStringProperties(internal)


- (void)add:(SUPString)key:(SUPString)value;
- (NSDictionary*)dictionary;
- (SUPStringProperties*)initWithDictionary:(NSDictionary*)dictionary;

@end