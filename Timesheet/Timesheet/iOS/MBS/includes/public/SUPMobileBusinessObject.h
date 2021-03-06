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

#import "SUPObjectList.h"

#import "SUPBusinessObject.h"

/*!
 @protocol
 @abstract    This protocol is implemented by SUP mobile business objects (MBOs or entities) that communicate with the server and support the pending state pattern.
 @discussion  
 */

@protocol SUPMobileBusinessObject<SUPBusinessObject>
/*!
    @method     
    @abstract   check if the object's __pending flag is turned on or not
                i.e. has pending change or not
    @discussion 
    @result YES - it is pending
            NO -  there is no pending changes.
*/

- (SUPBoolean)isPending;
/*!
    @method     
    @abstract   check if the object's __pending flag is turned on or not
                and pending operation is "create"
    @discussion 
    @result YES - it is pending with operation "create"
            NO -  there is not.
*/

- (BOOL)isCreated;
/*!
    @method     
    @abstract   check if the object's __pending flag is turned on or not
                and pending operation is "update"
    @discussion 
        @result YES - it is pending with operation "update"
            NO -  there is not.
*/

- (BOOL)isUpdated;
/*!
    @method     
    @abstract   check if the object's __pending flag is turned on or not
                and pending operation is "delete"
    @discussion 
        @result YES - it is pending with operation "delete"
            NO -  there is not.
*/

- (BOOL)isDeleted;
/*!
    @method     
    @abstract   cancel the local pending changes that have not been submitted to the server.
    @discussion 
*/

- (void)cancelPending;
/*!
    @method     
    @abstract   submit the pending changes of the object to the server.
    @discussion 
*/

- (void)submitPending;
/*!
    @method     
    @abstract   retrieve a list of log records for this MBO.
    @discussion 
*/

- (SUPObjectList*)getLogRecords;

@end
