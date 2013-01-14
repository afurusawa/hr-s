//
//  Toast.h
//  Hanalytics
//
//  Created by Fernando Aguilar on 9/25/12.
//  Copyright (c) 2012 Fernando Aguilar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface RapidToast : UIView
@property UILabel *message;

+(void)toastWithMessage:(NSString*)message forView:(UIView*)view;

+(void)toastWithMessage:(NSString*)message andFrame:(CGRect)frame forView:(UIView*)view;

+(void)toastWithMessage:(NSString*)message withBackgroundColor:(UIColor*)backgroundColor andTextColor:(UIColor*)textColor forView:(UIView*)view;

+(void)toastWithMessage:(NSString*)message withBackgroundColor:(UIColor*)backgroundColor andTextColor:(UIColor*)textColor andBorderColor:(UIColor*)borderColor forView:(UIView*)view;

+(void)toastWithMessage:(NSString*)message withBackgroundColor:(UIColor*)backgroundColor andTextColor:(UIColor*)textColor andBorderColor:(UIColor*)borderColor andFrame:(CGRect)frame forView:(UIView*)view;

+(void)toastWithMessage:(NSString*)message withBackgroundColor:(UIColor*)backgroundColor andTextColor:(UIColor*)textColor andBorderColor:(UIColor*)borderColor andCornerRadius:(CGFloat)radius forView:(UIView*)view;

+(void)toastWithMessage:(NSString*)message withBackgroundColor:(UIColor*)backgroundColor andTextColor:(UIColor*)textColor andBorderColor:(UIColor*)borderColor andBorderWidth:(CGFloat)borderWidth andCornerRadius:(CGFloat)radius forView:(UIView*)view;

+(void)toastWithMessage:(NSString*)message withBackgroundColor:(UIColor*)backgroundColor andTextColor:(UIColor*)textColor andBorderColor:(UIColor*)borderColor andBorderWidth:(CGFloat)borderWidth andCornerRadius:(CGFloat)radius andFrame:(CGRect)frame forView:(UIView*)view;

+(void)toastWithMessage:(NSString*)message withBackgroundImage:(NSString*)imageName andTextColor:(UIColor*)textColor andBorderColor:(UIColor*)borderColor andBorderWidth:(CGFloat)borderWidth andCornerRadius:(CGFloat)radius forView:(UIView*)view;
@end
