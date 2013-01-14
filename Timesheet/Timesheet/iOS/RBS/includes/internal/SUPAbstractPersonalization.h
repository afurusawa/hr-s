//
//  SUPAbstractPersonalization.h
//  clientrt
//
//  Created by Jane Yang on 11/4/11.
//  Copyright (c) 2011 Sybase, Inc. All rights reserved.
//

#import "SUPAbstractEntityRBS.h"

@interface SUPAbstractPersonalization : SUPAbstractEntityRBS
{
    @protected
    NSString *_key_name;
    NSString *_value;
}
@property(readwrite,retain,nonatomic) NSString *key_name;
@property(readwrite,retain,nonatomic) NSString *value;
- (BOOL)getUser_defined;
- (id)init;
- (void)dealloc;
@end
