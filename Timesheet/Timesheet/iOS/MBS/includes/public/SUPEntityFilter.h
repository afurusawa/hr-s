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
 @abstract    Represents the allowed SUP entity filter values.  Used to filter dynamic queries to only return objects in particular states.
 @discussion  An int value of: 0, 1, 2, 4, 8, 16, 32, 64, 128, or 0xFFFF. Corresponds to NONE, PENDING, NOT_PENDING, CREATED, NOT_CREATED, UPDATED, NOT_UPDATED, DELETED, NOT_DELETED, ALL.
 */
@interface SUPEntityFilter : NSObject
{
}

/*!
 @enum
 @abstract Possible SUPEntityFilter values.
 @discussion
 */
typedef enum
{
    SUPEntityFilter_ALL = 217483647,
    SUPEntityFilter_NONE = 0,
    SUPEntityFilter_PENDING = 1,
    SUPEntityFilter_NOT_PENDING = 2,
    SUPEntityFilter_CREATED = 4,
    SUPEntityFilter_NOT_CREATED = 8,
    SUPEntityFilter_UPDATED = 16,
    SUPEntityFilter_NOT_UPDATED = 32,
    SUPEntityFilter_DELETED = 64,
    SUPEntityFilter_NOT_DELETED = 128    
} SUPEntityFilterType;

/*!
 @enum
 @abstract Possible SUPEntityFilter values (deprecated 1.5.3 definitions).
 @discussion
 */
typedef enum
{
    SUPEntityFilterALL = 217483647,
    SUPEntityFilterNONE = 0,
    SUPEntityFilterPENDING = 1,
    SUPEntityFilterNOT_PENDING = 2,
    SUPEntityFilterCREATED = 4,
    SUPEntityFilterNOT_CREATED = 8,
    SUPEntityFilterUPDATED = 16,
    SUPEntityFilterNOT_UPDATED = 32,
    SUPEntityFilterDELETED = 64,
    SUPEntityFilterNOT_DELETED = 128    
} SUPEntityFilterTypeDeprecated;

/*!
 @method     
 @abstract   Returns the entity filter value for ALL.
 @result An int describing the entity filter value.
 @discussion 
 */
+ (SUPInt)ALL;
/*!
 @method     
 @abstract   Returns the entity filter value for NONE.
 @result An int describing the entity filter value.
 @discussion 
 */
+ (SUPInt)NONE;
/*!
 @method     
 @abstract   Returns the entity filter value for PENDING.
 @result An int describing the entity filter value.
 @discussion 
 */
+ (SUPInt)PENDING;
/*!
 @method     
 @abstract   Returns the entity filter value for NOT_PENDING.
 @result An int describing the entity filter value.
 @discussion 
 */
+ (SUPInt)NOT_PENDING;
/*!
 @method     
 @abstract   Returns the entity filter value for CREATED.
 @result An int describing the entity filter value.
 @discussion 
 */
+ (SUPInt)CREATED;
/*!
 @method     
 @abstract   Returns the entity filter value for NOT_CREATED.
 @result An int describing the entity filter value.
 @discussion 
 */
+ (SUPInt)NOT_CREATED;
/*!
 @method     
 @abstract   Returns the entity filter value for UPDATED.
 @result An int describing the entity filter value.
 @discussion 
 */
+ (SUPInt)UPDATED;
/*!
 @method     
 @abstract   Returns the entity filter value for NOT_UPDATED.
 @result An int describing the entity filter value.
 @discussion 
 */
+ (SUPInt)NOT_UPDATED;
/*!
 @method     
 @abstract   Returns the entity filter value for DELETED.
 @result An int describing the entity filter value.
 @discussion 
 */
+ (SUPInt)DELETED;
/*!
 @method     
 @abstract   Returns the entity filter value for NOT_DELETED.
 @result An int describing the entity filter value.
 @discussion 
 */
+ (SUPInt)NOT_DELETED;

@end
