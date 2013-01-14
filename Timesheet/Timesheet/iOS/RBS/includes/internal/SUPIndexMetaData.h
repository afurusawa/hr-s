//
//  SUPIndexMetaData.h
//  clientrt
//
//  Created by Scott Kovatch on 8/9/11.
//  Copyright 2011 Sybase. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SUPObjectList.h"

@interface SUPIndexMetaData : NSObject {

}

@property (assign, nonatomic) BOOL unique;
@property (retain, nonatomic) SUPObjectList *attributes;
@property (retain, nonatomic) NSString *name;
@end
