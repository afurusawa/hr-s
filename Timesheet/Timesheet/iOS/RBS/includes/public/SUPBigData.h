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


#import "SUPBigObjectExceptions.h"

@class SUPAbstractEntity;
@class SUPAbstractLocalEntity;
@class SUPAbstractEntityRBS;


@interface SUPBigData : NSObject
{
@protected
    BOOL _isOpen;
    BOOL _isOpenForWriting;
    int64_t _length;
    int64_t _position;

    NSMutableDictionary* _delegate;
    Class _dbClass;
    Class _mboClass;
    NSString* _attributeName;
    
    // this is for mbs
    SUPAbstractEntity* _mbo;    

    // this is for rbs
    SUPAbstractLocalEntity* _rbsMbo;
    BOOL _lengthRefresh;
    id _rs;


}


@property(nonatomic, readwrite)BOOL isOpen;
@property(nonatomic, readwrite)BOOL isOpenForWriting;
@property(nonatomic, retain)SUPString attributeName;


// Internal properties used by any underlying DB implementation class
@property(readwrite,assign,nonatomic) Class dbClass;
@property(readwrite,assign,nonatomic) Class mboClass;
@property(readwrite,assign,nonatomic) SUPAbstractEntity* mbo;
@property(readwrite,assign,nonatomic) SUPAbstractLocalEntity* rbsMbo;
@property(readwrite,retain,nonatomic) NSMutableDictionary *delegate;



@end

@interface SUPBigData (internal)
- (bool) isOS;
- (void)internalSetDataLength:(int64_t)length;
- (void)internalSetDataPosition:(int64_t)position;
- (BOOL)containsKey:(NSString*)name;
- (void)setString:(NSString*)name:(NSString*)value;
- (NSString*)getString:(NSString*)name;
- (void)setBoolean:(NSString*)name:(BOOL)value;
- (BOOL)getBoolean:(NSString*)name;
- (void)setLong:(NSString*)name:(int64_t)value;
- (int64_t)getLong:(NSString*)name;
- (void)setInt:(NSString*)name:(int32_t)value;
- (int32_t)getInt:(NSString*)name;

- (void)checkIfInitialized;

@end




