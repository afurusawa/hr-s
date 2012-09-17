//
//  DatabaseMetaData.h
//  clientrt
//
//  Created by Jane Yang on 1/19/12.
//  Copyright (c) 2012 Sybase, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SUPEntityMetaDataProtocol.h"

@protocol SUPDatabaseMetaDataProtocol <NSObject>
//@property(readwrite, retain, nonatomic) SUPObjectList* classList;
//@property(readwrite, retain, nonatomic) SUPObjectList* entityList;
//- (id)getClass:(SUPString)className;
- (id<SUPEntityMetaDataProtocol>)getEntity:(SUPString)className;
@end
