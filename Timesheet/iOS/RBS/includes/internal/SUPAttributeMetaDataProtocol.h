//
//  AttributeMetaData.h
//  clientrt
//
//  Created by Jane Yang on 1/19/12.
//  Copyright (c) 2012 Sybase, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sybase_sup.h"

@protocol SUPAttributeMetaDataProtocol <NSObject>
- (SUPInt) ident;
- (void) setIdent:(SUPInt)ident;
- (SUPDataType *)dataType;
- (void)setDataType:(SUPDataType*)dataType;
- (SUPString)name;
- (void)setName:(SUPString)name;
- (SUPString)column;
- (void)setColumn:(SUPString)column;
- (SUPInt)maxLength;
- (void)setMaxLength:(SUPInt)maxLength;
- (SUPInt)precision;
- (void)setPrecision:(SUPInt)precision;
- (SUPInt)scale;
- (void)setScale:(SUPInt)scale;
- (SUPBoolean)isKey;
- (void)setIsKey:(SUPBoolean)isKey;
- (SUPBoolean)isStatic;
- (void)setIsStatic:(SUPBoolean)isStatic;

- (SUPBoolean)isPersistent;
- (SUPBoolean)isBigAttribute;

@end
