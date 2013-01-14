//
//  SUPAbstractROEntity.h
//  clientrt
//
//  Created by Jane Yang on 10/3/11.
//  Copyright 2011 Sybase, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sybase_sup.h"
#import "SUPAbstractLocalEntity.h"


@interface SUPAbstractROEntity : SUPAbstractLocalEntity
- (SUPAbstractLocalEntity*)i_getDownloadState;
@end
