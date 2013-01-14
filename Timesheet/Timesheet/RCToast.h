//
//  RCToast.h
//  Hanalytics
//
//  Created by Fernando Aguilar on 9/25/12.
//  Copyright (c) 2012 Fernando Aguilar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface RCToast : UIView
@property UILabel *label;
@property NSString *message;
@property UIColor *textColor;
@property UIColor *backgroundColor;
@property UIColor *borderColor;
@property CGFloat borderWidth;
@property CGFloat cornerRadius;
@property CGPoint origin;
@property CGFloat length;

-(void)showToastInView:(UIView*)view withMessage:(NSString*)msg;
-(void)removeToast:(UIView*)view;

@end
