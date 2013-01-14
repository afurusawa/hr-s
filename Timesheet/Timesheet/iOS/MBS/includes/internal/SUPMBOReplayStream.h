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



#import "SUPCircularBuffer.h"
#import "sup_json.h"

@class SUPAbstractEntity;
@class SUPConnectionProfile;

#define DEFAULT_SIZE 128*1024
#define INFINITE_SIZE -1

// Class representing a stream of JSON content that can be read by the iMO streaming implementation when a replay message
// is sent to the server
// We make it a subclass of SUPJsonInputStream to make it easy to attach to SUPJsonMessage objects that are passed to SUPQueueConnection

@interface SUPMBOReplayStream : SUPJsonInputStream
{
    SUPAbstractEntity * _mbo;
    SUPCircularBuffer *_cb;
    SUPConnectionProfile *_cp;
    NSMutableString * _logstring;
    int _logstringlengthremaining;
    BOOL _isStarted;
}

// True if the stream has been started
@property(readwrite,assign,nonatomic) BOOL isStarted;

// The parent MBO instance being sent
@property(readwrite,retain,nonatomic) SUPAbstractEntity * mbo;

// Circular buffer used internally
@property(readwrite,retain,nonatomic) SUPCircularBuffer * cb;

// Connection profile (needed for logging)
@property(readwrite,retain,nonatomic) SUPConnectionProfile *cp;

// Initialization methods
- (id)init;
- (id)initWithMBO:(SUPAbstractEntity *)theMbo andConnectionProfile:(SUPConnectionProfile*)connProfile;

- (void)dealloc;

// Used by the MBO and its children to write JSON content to the stream
- (void)writeStringToStream:(NSString*)str;

// Starts a thread that writes all the JSON content for the MBO to the stream
// Throws an exception if the mbo property has not been set
- (void)startStream;

// Read len bytes from the stream into buffer buf (buf must already be allocated)
- (int)readBytes:(unsigned char *)buf:(int)len;

// Convenience method to read a string from the stream
- (NSString*)readString:(int)len;

// Close the stream for writing when done
- (void)closeForWrite;

// Close the stream for reading when done
- (void)closeForRead;

- (BOOL)isOpenForRead;

@end
