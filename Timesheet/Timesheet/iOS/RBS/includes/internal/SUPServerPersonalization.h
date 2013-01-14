//
//  SUPServerPersonalization.h
//  clientrt
//
//  Created by Jane Yang on 11/9/11.
//  Copyright (c) 2011 Sybase, Inc. All rights reserved.
//

#import "SUPAbstractPersonalization.h"

@protocol SUPResultSetWrapper;
@protocol SUPCallbackHandler;
@class SUPServerPersonalizationDelegate;

@interface SUPServerPersonalization : SUPAbstractPersonalization
{
    @protected
    SUPServerPersonalizationDelegate *_delegate;
    BOOL    _user_defined;
    NSString    *_package_script_version;
    NSString    *_user_name;
    NSString    *_package_name;
    NSString    *_domain_name;
    BOOL        _isOsEntity;
}
@property(readwrite, retain, nonatomic)SUPServerPersonalizationDelegate *delegate;
@property(readwrite, retain, nonatomic)NSString * package_script_version;
@property(readwrite, retain, nonatomic)NSString * user_name;
@property(readwrite, retain, nonatomic)NSString * package_name;
@property(readwrite, retain, nonatomic)NSString * domain_name;
@property(readwrite, assign, nonatomic)BOOL user_defined;
@property(readwrite, assign, nonatomic)BOOL isOsEntity;

+ (void)registerCallbackHandler:(NSObject<SUPCallbackHandler> *)newCallbackHandler;
+ (NSObject<SUPCallbackHandler> *)callbackHandler;
- (SUPServerPersonalization*)initWithDelegate:(SUPServerPersonalizationDelegate*)dlg;
- (void) bind:(id<SUPResultSetWrapper>)rs;
- (void)dealloc;
@end
