//
//  SUPEntityMetaDataProtocol.h
//  clientrt
//
//  Created by Jane Yang on 1/19/12.
//  Copyright (c) 2012 Sybase, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SUPAttributeMetaDataProtocol.h"
#import "SUPAttributeMap.h"
#import "sybase_sup.h"

@protocol SUPEntityMetaDataProtocol <NSObject>
//
//@property(readwrite, retain, nonatomic) SUPObjectList* attributes;
//@property(readwrite, retain, nonatomic) SUPString table;
//@property(readwrite, retain, nonatomic) SUPAttributeMap* attributeMap;
- (SUPString) name;
- (void) setName:(SUPString)name;
- (SUPObjectList*)attributes;
- (void)setAttributes:(SUPObjectList *)attributes;
- (SUPString) table;
- (void)setTable:(SUPString)table;
- (SUPAttributeMap*)attributeMap;
- (void)setAttributeMap:(SUPAttributeMap *)attributeMap;
- (id<SUPAttributeMetaDataProtocol>)getAttribute:(SUPString)name;

@end
