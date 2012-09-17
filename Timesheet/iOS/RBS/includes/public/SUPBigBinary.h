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



#import "sybase_sup.h"
#import "SUPBigObjectExceptions.h"
#import "SUPBigData.h"
@class SUPAbstractEntity;

/*!
 @class SUPBigBinary
 @abstract  An object that allows access to a persistent string value that might be too big to fit in available memory. A streaming API is provided to allow the value to be accessed in chunks. 
 @discussion  This is an abstract class -- instances of the class will actually be instances of a subclass that implements the required operations for a specific client DB.
 */
@interface SUPBigBinary : SUPBigData
{

}

/*!
 @property     
 @abstract Indicates whether the value is null.
 @discussion Throws @link //apple_ref/occ/cl/SUPObjectNotSavedException SUPObjectNotSavedException @/link if this SUPBigBinary object is an attribute of an entity that has not yet been created in the database.
 @throws @link //apple_ref/occ/cl/SUPObjectNotSavedException SUPObjectNotSavedException @/link
 */
@property(readonly) BOOL isNull;
/*!
 @property     
 @abstract Gets the value length in bytes. 
 @discussion Throws @link //apple_ref/occ/cl/SUPObjectNotFoundException SUPObjectNotFoundException @/link if the value is null. Throws @link //apple_ref/occ/cl/SUPObjectNotSavedException SUPObjectNotSavedException @/link if this SUPBigBinary object is an attribute of an entity that has not yet been created in the database.
 @throws @link //apple_ref/occ/cl/SUPObjectNotFoundException SUPObjectNotFoundException @/link
 @throws @link //apple_ref/occ/cl/SUPObjectNotSavedException SUPObjectNotSavedException @/link
 */
@property(readonly) int64_t length;
/*!
 @property     
 @abstract Gets the stream position in bytes, or zero if the stream is not open. 
 @discussion Throws @link //apple_ref/occ/cl/SUPObjectNotFoundException SUPObjectNotFoundException @/link if the value is null. Throws @link //apple_ref/occ/cl/SUPObjectNotSavedException SUPObjectNotSavedException @/link if this SUPBigBinary object is an attribute of an entity that has not yet been created in the database. Throws @link //apple_ref/occ/cl/SUPStreamNotOpenException SUPStreamNotOpenException @/link if the stream is not open.
 @throws @link //apple_ref/occ/cl/SUPObjectNotFoundException SUPObjectNotFoundException @/link
 @throws @link //apple_ref/occ/cl/SUPObjectNotSavedException SUPObjectNotSavedException @/link
 @throws @link //apple_ref/occ/cl/SUPStreamNotOpenException SUPStreamNotOpenException @/link
 */
@property(readonly) int64_t position;
/*!
 @property     
 @abstract Gets or sets the complete value. 
 @discussion Throws @link //apple_ref/occ/cl/SUPObjectNotSavedException SUPObjectNotSavedException @/link if this SUPBigBinary object is an attribute of an entity that has not yet been created in the database. Throws @link //apple_ref/occ/cl/SUPStreamNotClosedException SUPStreamNotClosedException @/link if the stream is not closed.
 @discussion If the value is expected to be very large, consider using streaming to reduce the amount of memory needed by the application.
 @throws @link //apple_ref/occ/cl/SUPObjectNotSavedException SUPObjectNotSavedException @/link
 @throws @link //apple_ref/occ/cl/SUPStreamNotClosedException SUPStreamNotClosedException @/link
 
 */
@property(readwrite,retain,nonatomic) NSData* value;

- (SUPBigBinary*)init;

/*!
 @method     
 @abstract   Returns a new instance of SUPBigBinary.
 @result The SUPBigBinary.
 @discussion 
 */
+ (SUPBigBinary*)getInstance;

/*!
 @method     
 @abstract Closes the value stream. Any buffered writes will be automatically flushed. 
 @discussion Throws @link //apple_ref/occ/cl/SUPStreamNotOpenException SUPStreamNotOpenException @/link if the stream is not open.
 @throws @link //apple_ref/occ/cl/SUPStreamNotOpenException SUPStreamNotOpenException @/link
 */
- (void)close;

/*!
 @method     
 @abstract Flushes any buffered writes to the database. 
 @discussion Throws @link //apple_ref/occ/cl/SUPStreamNotOpenException SUPStreamNotOpenException @/link if the stream is not open. 
 @throws @link //apple_ref/occ/cl/SUPStreamNotOpenException SUPStreamNotOpenException @/link
 */
- (void)flush;

/*!
 @method     
 @abstract Opens the value for reading.
 @discussion Has no effect if the stream was already open for reading. If the stream was already open for writing, it is flushed before being reopened for reading. Throws @link //apple_ref/occ/cl/SUPObjectNotSavedException SUPObjectNotSavedException @/link if this SUPBigBinary object is an attribute of an entity that has not yet been created in the database. Throws @link //apple_ref/occ/cl/SUPObjectNotFoundException SUPObjectNotFoundException @/link if the value is null. 
 @throws @link //apple_ref/occ/cl/SUPObjectNotSavedException SUPObjectNotSavedException @/link
 @throws @link //apple_ref/occ/cl/SUPObjectNotFoundException SUPObjectNotFoundException @/link
 */
- (void)openForRead;

/*!
 @method     
 @abstract Opens the value for writing.
 @discussion Any previous contents of the value will be discarded. Throws @link //apple_ref/occ/cl/SUPObjectNotSavedException SUPObjectNotSavedException @/link if this SUPBigBinary object is an attribute of an entity that has not yet been created in the database.  
 @param  length When opening a value for writing, the expected length of the value in bytes. 
 @throws @link //apple_ref/occ/cl/SUPObjectNotSavedException SUPObjectNotSavedException @/link
 */
- (void)openForWrite:(int64_t)length;

/*!
 @method
 @abstract Reads and returns up to 'length' bytes (fewer if end of stream is reached). 
 @discussion Throws @link //apple_ref/occ/cl/SUPStreamNotOpenException SUPStreamNotOpenException @/link if the stream is not open for reading.
 @param length Maximum number of bytes to be read into the chunk.
 @result A chunk of data read from the stream, or a null value at end of stream.
 @throws @link //apple_ref/occ/cl/SUPStreamNotOpenException SUPStreamNotOpenException @/link
 */
- (NSData*)read:(int64_t)length;

/*!
 @method
 @abstract Reads a single byte from the stream. Returns -1 if end of stream has been reached. 
 @discussion Throws @link //apple_ref/occ/cl/SUPStreamNotOpenException SUPStreamNotOpenException @/link if the stream is not open for reading.
 @result A byte of data read from the stream, or -1 at end of stream.
 @throws @link //apple_ref/occ/cl/SUPStreamNotOpenException SUPStreamNotOpenException @/link
 */
- (int)readByte;

/*!
 @method
 @abstract Changes the stream position. 
 @discussion Throws @link //apple_ref/occ/cl/SUPStreamNotOpenException SUPStreamNotOpenException @/link if the stream is not open.
 @param newPosition New stream position in bytes, starting at zero for beginning of the value stream.
 @throws @link //apple_ref/occ/cl/SUPStreamNotOpenException SUPStreamNotOpenException @/link
 */
- (void)seek:(int64_t)newPosition;

/*!
 @method
 @abstract Writes 'data' to the stream at the current position. T
 @discussion The stream might be buffered, so use 'flush' or 'close' when you need to be certain that any buffered changes have been applied. Throws @link //apple_ref/occ/cl/SUPStreamNotOpenException SUPStreamNotOpenException @/link if the stream is not open for writing. Throws @link //apple_ref/occ/cl/SUPWriteAppendOnlyException SUPWriteAppendOnlyException @/link if the platform only supports appending to the end of a value and the current stream position preceeds the end of the value. Throws @link //apple_ref/occ/cl/SUPWriteOverLengthException SUPWriteOverLengthException @/link if the platform requires the length to be predetermined before write, and this write would result in exceeding the predetermined length.
 @param data Data chunk to be written to the stream.
 @throws @link //apple_ref/occ/cl/SUPStreamNotOpenException SUPStreamNotOpenException @/link
 @throws @link //apple_ref/occ/cl/SUPWriteAppendOnlyException SUPWriteAppendOnlyException @/link 
 @throws @link //apple_ref/occ/cl/SUPWriteOverLengthException SUPWriteOverLengthException @/link
 */
- (void)write:(NSData*)data;

/*!
 @method
 @abstract Writes 'data' to the stream at the current position. 
 @discussion The stream might be buffered, so use 'flush' or 'close' when you need to be certain that any buffered changes have been applied. Throws @link //apple_ref/occ/cl/SUPStreamNotOpenException SUPStreamNotOpenException @/link if the stream is not open for writing. Throws @link //apple_ref/occ/cl/SUPWriteAppendOnlyException SUPWriteAppendOnlyException @/link if the platform only supports appending to the end of a value and the current stream position preceeds the end of the value. Throws @link //apple_ref/occ/cl/SUPWriteOverLengthException SUPWriteOverLengthException @/link if the platform requires the length to be predetermined before write, and this write would result in exceeding the predetermined length.
 @param data Byte value to be written to the stream.
 @throws @link //apple_ref/occ/cl/SUPStreamNotOpenException SUPStreamNotOpenException @/link
 @throws @link //apple_ref/occ/cl/SUPWriteAppendOnlyException SUPWriteAppendOnlyException @/link 
 @throws @link //apple_ref/occ/cl/SUPWriteOverLengthException SUPWriteOverLengthException @/link
 */
- (void)writeByte:(signed char)data;

/*!
 @method copyToFile
 @abstract Writes the contents of this BigBinary object to a file.
 @discussion The file will be created if it does not exist, and overwritten if it does exist.  Throws @link //apple_ref/occ/cl/SUPObjectNotFoundException SUPObjectNotFoundException @/link if this object has not been saved in the database.  Throws @link //apple_ref/occ/cl/SUPStreamNotClosedException SUPStreamNotClosedException @/link if this object is already open.
 @param filePath The absolute path in the iOS filesystem
 @throws @link //apple_ref/occ/cl/SUPObjectNotFoundException SUPObjectNotFoundException @/link
 @throws @link //apple_ref/occ/cl/SUPStreamNotClosedException SUPStreamNotClosedException @/link
 */
- (void)copyToFile:(NSString*)filePath;

/*!
 @method copyFromFile
 @abstract Replaces the contents of this BigBinary object with the contents of the file passed in.......
 @discussion Throws @link //apple_ref/occ/cl/SUPObjectNotFoundException SUPObjectNotFoundException @/link if this object has not been saved in the database, or the file does not exist.  Throws @link //apple_ref/occ/cl/SUPStreamNotClosedException SUPStreamNotClosedException @/link if this object is already open.
 @param filePath The absolute path in the iOS filesystem
 @throws @link //apple_ref/occ/cl/SUPObjectNotFoundException SUPObjectNotFoundException @/link
 @throws @link //apple_ref/occ/cl/SUPStreamNotClosedException SUPStreamNotClosedException @/link
 */
- (void)copyFromFile:(NSString*)filePath;

 - (NSString*)description;


@end


