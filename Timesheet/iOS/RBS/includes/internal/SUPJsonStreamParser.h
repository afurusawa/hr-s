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

#import "SUPBooleanUtil.h"
#import "SUPDateTimeUtil.h"
#import "SUPDateUtil.h"
#import "SUPJsonException.h"
#import "SUPJsonInputStream.h"
#import "SUPJsonNumber.h"
#import "SUPNumberUtil.h"
#import "SUPStringUtil.h"
#import "SUPCharList.h"
#import "SUPTimeUtil.h"
#import "SUPIntList.h"
#import "SUPStringList.h"

#import "SUPJsonStreamParserState.h"

@interface SUPJsonStreamParser : NSObject
{
    @protected
    SUPJsonStreamParserStateType _0;
    SUPNullableString _1;
    SUPChar _2;
    SUPJsonInputStream* _3;
    SUPIntList* _4;
    SUPInt _5;
    SUPBoolean _6;
    SUPInt _7;
}

+ (SUPJsonStreamParser*)getInstance;
- (SUPJsonStreamParser*)init;
- (void)setState:(SUPJsonStreamParserStateType)_state;
- (SUPJsonStreamParserStateType)state;
@property(readwrite,assign) SUPJsonStreamParserStateType state;
- (void)setToken:(SUPNullableString)_token;
- (SUPNullableString)token;
@property(readwrite,assign) SUPNullableString token;
- (void)setMaxStringSize:(SUPInt)_maxStringSize;
- (SUPInt)maxStringSize;
@property(readwrite,assign) SUPInt maxStringSize;
+ (SUPJsonStreamParser*)parserFromInputStream:(SUPJsonInputStream*)stream;
- (SUPJsonStreamParserStateType)nextState;

- (SUPJsonObject*)getNextObject;
- (SUPJsonArray*)getNextArray;

- (void)skipObject;
- (void)skipArray;

- (SUPJsonNumber*)getNumberValue;

- (SUPString)getFieldName;
- (SUPBoolean)getBooleanValue;
- (SUPNullableBoolean)getNullableBooleanValue;
- (SUPString)getStringValue;
- (SUPString)getNullableStringValue;
- (SUPBinary)getBinaryValue;
- (SUPNullableBinary)getNullableBinaryValue;
- (SUPChar)getCharValue;
- (SUPNullableChar)getNullableCharValue;
- (SUPByte)getByteValue;
- (SUPNullableByte)getNullableByteValue;
- (SUPShort)getShortValue;
- (SUPNullableShort)getNullableShortValue;
- (SUPInt)getIntValue;
- (SUPNullableInt)getNullableIntValue;
- (SUPLong)getLongValue;
- (SUPNullableLong)getNullableLongValue;
- (SUPInteger)getIntegerValue;
- (SUPNullableInteger)getNullableIntegerValue;
- (SUPDecimal)getDecimalValue;
- (SUPNullableDecimal)getNullableDecimalValue;
- (SUPFloat)getFloatValue;
- (SUPNullableFloat)getNullableFloatValue;
- (SUPDouble)getDoubleValue;
- (SUPNullableDouble)getNullableDoubleValue;
- (SUPDate)getDateValue;
- (SUPNullableDate)getNullableDateValue;
- (SUPTime)getTimeValue;
- (SUPNullableTime)getNullableTimeValue;
- (SUPDateTime)getDateTimeValue;
- (SUPNullableDateTime)getNullableDateTimeValue;
- (SUPJsonStreamParser*)finishInit;
- (void)initFields;
- (void)dealloc;

@end
