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


#import "sybase_sup.h"

@class SUPJsonObject;
@class SUPStringUtil;
@class SUPDataType;

#import "SUPDataValue.h"

@class SUPFloatValue;



/*!
 @class SUPFloatValue
 @abstract   This is a subclass of @link //apple_ref/occ/cl/SUPDataValue SUPDataValue @/link for use with SUPFloat attributes.
 @discussion This class and related classes are used in processing result sets from queries (@link //apple_ref/occ/cl/SUPQueryResultSet SUPQueryResultSet @/link).
 @discussion 
 */

@interface SUPFloatValue : SUPDataValue
{
    SUPFloat _value;
}

/*!
 @method     
 @abstract   Returns a new instance of the SUPFloatValue object.
 @result     The SUPFloatValue object.
 @discussion 
 */
+ (SUPFloatValue*)getInstance;

/*!
 @method     
 @abstract   (Deprecated) Returns a new instance of the SUPFloatValue object.
 @result     The SUPFloatValue object.
 @discussion This method is deprecated. use getInstance.
 */
+ (SUPFloatValue*)newInstance DEPRECATED_ATTRIBUTE NS_RETURNS_NON_RETAINED;

/*!
 @method     
 @abstract   Returns the initialized SUPFloatValue object.
 @result     The SUPFloatValue object.
 @discussion 
 */
- (SUPFloatValue*)init;

/*!
 @property     
 @abstract  The value.
 @discussion 
 */
@property(assign, nonatomic) SUPFloat value;

/*!
 @method     
 @abstract   Returns the typecode of the instance variable of type SUPFloat, contained by this SUPFloatValue object.
 @result     The typecode of the instance variable of type SUPFloat, contained by this SUPFloatValue object.
 @discussion 
 */
- (SUPInt)typeCode;

/*!
 @method     
 @abstract   Returns the value of the SUPFloat type instance variable as an SUPString.
 @result     The value of the instance variable as an SUPString.
 @discussion
 */
- (SUPString)toString;

/*!
 @method     
 @abstract   Deallocates the memory occupied by the SUPFloatValue object.
 @discussion
 */
- (void)dealloc;

@end

@interface SUPFloatValue(internal)

- (void)readJson:(SUPJsonObject*)_object_1:(SUPInt)_flags;
- (SUPJsonObject*)writeJson:(SUPInt)_flags;

@end

