/*
 
 Copyright (c) Sybase, Inc. 2011   All rights reserved.                                    
 
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



#import "sybase_core.h"
#import "SUPPersistenceException.h"
#import "SUPObjectNotFoundException.h"

/*!
 @class SUPObjectNotSavedException
 @abstract   SUPObjectNotSavedException is thrown if an SUPBigBinary or SUPBigString method is called that requires the object to already exist in the database.
 @discussion 
 */

@interface SUPObjectNotSavedException : SUPPersistenceException
{
}

/*!
 @method     
 @abstract   Returns the SUPObjectNotSavedException object with "theMessage".
 @param theMessage The  message.
 @result The SUPObjectNotSavedException.
 @discussion 
 */
+ (SUPObjectNotSavedException*)withMessage:(SUPString)theMessage;


/*!
 @method     
 @abstract   Returns a new instance of SUPObjectNotSavedException object.
 @result The SUPObjectNotSavedException object.
 @discussion 
 */
+ (SUPObjectNotSavedException*)getInstance;

/*!
 @method     
 @abstract   Overrides Apple's NSException method name()
 @result String with the exception name.
 @discussion 
 */
- (NSString*)name;

@end

/*!
 @class SUPStreamNotOpenException
 @abstract   SUPStreamNotOpenException is thrown if an SUPBigBinary or SUPBigString method is called that requires the object to be open.
 @discussion 
 */

@interface SUPStreamNotOpenException : SUPPersistenceException
{
}

/*!
 @method     
 @abstract   Returns the SUPStreamNotOpenException object with "theMessage".
 @param theMessage The  message.
 @result The SUPStreamNotOpenException.
 @discussion 
 */
+ (SUPStreamNotOpenException*)withMessage:(SUPString)theMessage;

/*!
 @method     
 @abstract   Returns a new instance of SUPStreamNotOpenException object.
 @result The SUPStreamNotOpenException object.
 @discussion 
 */
+ (SUPStreamNotOpenException*)getInstance;

/*!
 @method     
 @abstract   Overrides Apple's NSException method name()
 @result String with the exception name.
 @discussion 
 */
- (NSString*)name;

@end

/*!
 @class SUPStreamNotClosedException
 @abstract   SUPStreamNotClosedException is thrown if an SUPBigBinary or SUPBigString method is called that requires the object to not be open.
 @discussion 
 */

@interface SUPStreamNotClosedException : SUPPersistenceException
{
}

/*!
 @method     
 @abstract   Returns the SUPStreamNotClosedException object with "theMessage".
 @param theMessage The  message.
 @result The SUPStreamNotClosedException.
 @discussion 
 */
+ (SUPStreamNotClosedException*)withMessage:(SUPString)theMessage;

/*!
 @method     
 @abstract   Returns a new instance of SUPStreamNotClosedException object.
 @result The SUPStreamNotClosedException object.
 @discussion 
 */
+ (SUPStreamNotClosedException*)getInstance;

/*!
 @method     
 @abstract   Overrides Apple's NSException method name()
 @result String with the exception name.
 @discussion 
 */
- (NSString*)name;

@end

/*!
 @class SUPWriteAppendOnlyException
 @abstract   SUPWriteAppendOnlyException is thrown if an SUPBigBinary or SUPBigString method is called that writes to the middle of a value where only appending is allowed by the underlying DB.
 @discussion 
 */

@interface SUPWriteAppendOnlyException : SUPPersistenceException
{
}

/*!
 @method     
 @abstract   Returns the SUPWriteAppendOnlyException object with "theMessage".
 @param theMessage The  message.
 @result The SUPWriteAppendOnlyException.
 @discussion 
 */
+ (SUPWriteAppendOnlyException*)withMessage:(SUPString)theMessage;

/*!
 @method     
 @abstract   Returns a new instance of SUPWriteAppendOnlyException object.
 @result The SUPWriteAppendOnlyException object.
 @discussion 
 */
+ (SUPWriteAppendOnlyException*)getInstance;

/*!
 @method     
 @abstract   Overrides Apple's NSException method name()
 @result String with the exception name.
 @discussion 
 */
- (NSString*)name;

@end

/*!
 @class SUPWriteOverLengthException
 @abstract   SUPWriteOverLengthException is thrown if an SUPBigBinary or SUPBigString method is called that writes past the fixed length allowed for the value by the underlying DB.
 @discussion 
 */

@interface SUPWriteOverLengthException : SUPPersistenceException
{
}

/*!
 @method     
 @abstract   Returns the SUPWriteOverLengthException object with "theMessage".
 @param theMessage The  message.
 @result The SUPWriteOverLengthException.
 @discussion 
 */
+ (SUPWriteOverLengthException*)withMessage:(SUPString)theMessage;

/*!
 @method     
 @abstract   Returns a new instance of SUPWriteOverLengthException object.
 @result The SUPWriteOverLengthException object.
 @discussion 
 */
+ (SUPWriteOverLengthException*)getInstance;

/*!
 @method     
 @abstract   Overrides Apple's NSException method name()
 @result String with the exception name.
 @discussion 
 */
- (NSString*)name;

@end

