//
//  SUPKeyPackageName.h
//  clientrt
//
//  Created by Jane Yang on 11/9/11.
//  Copyright (c) 2011 Sybase, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SUPKeyPackageName : NSObject
{
    @private
    NSString *_key_name;
    NSString *_package_name;
    NSString *_user_name;
    NSString *_domain_name;
}
@property(readwrite, retain, nonatomic)NSString *key_name;
@property(readwrite, retain, nonatomic)NSString *package_name;
@property(readwrite, retain, nonatomic)NSString *user_name;
@property(readwrite, retain, nonatomic)NSString *domain_name;
@end
