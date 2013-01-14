//
//  SUPClientPersonalization.h
//  clientrt
//
//  Created by Jane Yang on 11/9/11.
//  Copyright (c) 2011 Sybase, Inc. All rights reserved.
//

#import "SUPAbstractPersonalization.h"
@class SUPClientPersonalizationDelegate;
@protocol SUPResultSetWrapper;

@interface SUPClientPersonalization : SUPAbstractPersonalization
{
    @private
    NSString    *_user;
    BOOL        _user_defined;
    NSString    *_description;
    long        _id;
    SUPClientPersonalizationDelegate    *_delegate;
    
}
@property(readwrite, retain, nonatomic)SUPClientPersonalizationDelegate    *delegate;
@property(readwrite, retain, nonatomic)NSString     *user;
@property(readwrite, retain, nonatomic)NSString     *description;
@property(readwrite, assign, nonatomic)long         id_;
@property(readwrite, assign, nonatomic)BOOL     user_defined;
- (id)init;
- (SUPClientPersonalization*)initWithDelegate:(SUPClientPersonalizationDelegate*)delegate;
- (long)_pk;
- (NSString*)keyToString;
//- (BOOL)equals:(id)that;
//- (int) hashCode;
- (void) copyAll:(SUPClientPersonalization*)entity;
- (void) bind:(id<SUPResultSetWrapper>)rs;
- (void) save;
- (void) create;
- (void) delete;
- (void) update;
- (void) dealloc;
@end
