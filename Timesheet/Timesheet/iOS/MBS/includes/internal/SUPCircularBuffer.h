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



// Thread safe circular buffer implementation

@interface SUPCircularBuffer : NSObject
{
    unsigned char * _buffer;
    int _rp;
    int _wp;
    int _size;
    BOOL _closedForRead;
    BOOL _closedForWrite;
}

// Returns number of bytes available for reading
@property(readonly) int available;

// Returns number of bytes available for writing
@property(readonly) int spaceLeft;

// Returns total size of buffer
@property(readonly) int size;

// Returns true if buffer is open for read
@property(readonly) BOOL isOpenForRead;

// Returns true if buffer is open for write
@property(readonly) BOOL isOpenForWrite;

// Initialize the buffer with default size (128K)
- (id)init;

// Initialize the buffer with the passed in size in bytes
- (id)initWithSize:(int)theSize;

- (void)dealloc;

// Reinitializes the buffer and reopens it for both reading and writing
- (void)clear;

// Close the buffer for writing (allows reader thread to know when input is done)
- (void)closeForWrite;

// Close the buffer for reading (allows writer thread to know if reader no longer needs bytes)
- (void)closeForRead;

// Attempt to read len bytes into buffer buf (it must already be allocated)
// Will block until bytes are available to be read, or until input stream is closed and there are no more bytes in the buffer
// Returns number of bytes actually read
// Will throw an exception if already closed for reading
- (int)readBytes:(unsigned char *)buf:(int)len;

// Write len bytes from buffer buf
// Will block until space is available and len bytes have been written
// Will return immediately if closed for reading
// Will throw an exception if already closed for writing
- (void)writeBytes:(unsigned char *)buf:(int)len;


@end
