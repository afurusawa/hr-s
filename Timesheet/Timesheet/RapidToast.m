//
//  Toast.m
//  Hanalytics
//
//  Created by Fernando Aguilar on 9/25/12.
//  Copyright (c) 2012 Fernando Aguilar. All rights reserved.
//

#import "RapidToast.h"

@implementation RapidToast
@synthesize message = _message;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


+(void)toastWithMessage:(NSString*)message forView:(UIView*)view
{
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(40, 50, 240, 20)];


    [label setTextColor:[UIColor colorWithRed:42/255.0 green:106/255.0 blue:136/255.0 alpha:1]];
    [label setTextAlignment:UITextAlignmentCenter];
    [label setText:message];
    [label setBackgroundColor:[UIColor blackColor]];
    [label setAlpha:1];
    [label.layer setCornerRadius:10];
    
    //add the toast to the view
    [view addSubview:label];
    

    
    //remove the toast
    [UIView beginAnimations:@"fade toast" context:nil];
    [UIView setAnimationDelay:1.5];
    [UIView setAnimationDuration:1.5];
    label.alpha = 0.0;
    [UIView commitAnimations];
    
    [view bringSubviewToFront:label];
    [label removeFromSuperview];
}

+(void)toastWithMessage:(NSString*)message andFrame:(CGRect)frame forView:(UIView*)view
{
    
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    
    
    [label setTextColor:[UIColor whiteColor]];
    [label setTextAlignment:UITextAlignmentCenter];
    [label setText:message];
    [label setBackgroundColor:[UIColor blackColor]];
    [label setAlpha:1];
    [label.layer setCornerRadius:10];
    
    //add the toast to the view
    [view addSubview:label];
    
    
    
    //remove the toast
    [UIView beginAnimations:@"fade toast" context:nil];
    [UIView setAnimationDelay:1.5];
    [UIView setAnimationDuration:1.5];
    label.alpha = 0.0;
    [UIView commitAnimations];
}

+(void)toastWithMessage:(NSString*)message withBackgroundColor:(UIColor*)backgroundColor andTextColor:(UIColor*)textColor forView:(UIView*)view
{
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(150, 700, 454, 30)];
    
    
    [label setTextColor:textColor];
    [label setTextAlignment:UITextAlignmentCenter];
    [label setText:message];
    [label setBackgroundColor:backgroundColor];
    [label setAlpha:1];
    [label.layer setCornerRadius:10];

    //add the toast to the view
    [view addSubview:label];
    
    
    
    //remove the toast
    [UIView beginAnimations:@"fade toast" context:nil];
    [UIView setAnimationDelay:1.5];
    [UIView setAnimationDuration:1.5];
    label.alpha = 0.0;
    [UIView commitAnimations];
}

+(void)toastWithMessage:(NSString*)message withBackgroundColor:(UIColor*)backgroundColor andTextColor:(UIColor*)textColor andBorderColor:(UIColor*)borderColor forView:(UIView*)view
{
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(150, 700, 454, 30)];
    
    
    [label setTextColor:textColor];
    [label setTextAlignment:UITextAlignmentCenter];
    [label setText:message];
    [label setBackgroundColor:backgroundColor];
    [label setAlpha:1];
    [label.layer setBorderColor:borderColor.CGColor];
    [label.layer setBorderWidth:2];
    [label.layer setCornerRadius:10];

    //add the toast to the view
    [view addSubview:label];
    
    
    
    //remove the toast
    [UIView beginAnimations:@"fade toast" context:nil];
    [UIView setAnimationDelay:1.5];
    [UIView setAnimationDuration:1.5];
    label.alpha = 0.0;
    [UIView commitAnimations];
}

+(void)toastWithMessage:(NSString*)message withBackgroundColor:(UIColor*)backgroundColor andTextColor:(UIColor*)textColor andBorderColor:(UIColor*)borderColor andFrame:(CGRect)frame forView:(UIView*)view
{
    
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    
    
    [label setTextColor:textColor];
    [label setTextAlignment:UITextAlignmentCenter];
    [label setText:message];
    [label setBackgroundColor:backgroundColor];
    [label setAlpha:1];
    [label.layer setBorderWidth:2];
    [label.layer setBorderColor:borderColor.CGColor];
    [label.layer setCornerRadius:10];

    //add the toast to the view
    [view addSubview:label];
    
    
    
    //remove the toast
    [UIView beginAnimations:@"fade toast" context:nil];
    [UIView setAnimationDelay:1.5];
    [UIView setAnimationDuration:1.5];
    label.alpha = 0.0;
    [UIView commitAnimations];
}

+(void)toastWithMessage:(NSString*)message withBackgroundColor:(UIColor*)backgroundColor andTextColor:(UIColor*)textColor andBorderColor:(UIColor*)borderColor andCornerRadius:(CGFloat)radius forView:(UIView*)view
{
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(150, 700, 454, 30)];
    
    
    [label setTextColor:textColor];
    [label setTextAlignment:UITextAlignmentCenter];
    [label setText:message];
    [label setBackgroundColor:backgroundColor];
    [label setAlpha:1];
    [label.layer setBorderColor:borderColor.CGColor];
    [label.layer setBorderWidth:2];
    [label.layer setCornerRadius:radius];

    //add the toast to the view
    [view addSubview:label];
    
    
    
    //remove the toast
    [UIView beginAnimations:@"fade toast" context:nil];
    [UIView setAnimationDelay:1.5];
    [UIView setAnimationDuration:1.5];
    label.alpha = 0.0;
    [UIView commitAnimations];
}

+(void)toastWithMessage:(NSString*)message withBackgroundColor:(UIColor*)backgroundColor andTextColor:(UIColor*)textColor andBorderColor:(UIColor*)borderColor andBorderWidth:(CGFloat)borderWidth andCornerRadius:(CGFloat)radius forView:(UIView*)view
{
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(150, 700, 454, 30)];
    
    
    [label setTextColor:textColor];
    [label setTextAlignment:UITextAlignmentCenter];
    [label setText:message];
    [label setBackgroundColor:backgroundColor];
    [label setAlpha:1];
    [label.layer setBorderColor:borderColor.CGColor];
    [label.layer setBorderWidth:borderWidth];
    [label.layer setCornerRadius:radius];
    
    //add the toast to the view
    [view addSubview:label];
    
    
    
    //remove the toast
    [UIView beginAnimations:@"fade toast" context:nil];
    [UIView setAnimationDelay:1.5];
    [UIView setAnimationDuration:1.5];
    label.alpha = 0.0;
    [UIView commitAnimations];
}

+(void)toastWithMessage:(NSString*)message withBackgroundColor:(UIColor*)backgroundColor andTextColor:(UIColor*)textColor andBorderColor:(UIColor*)borderColor andBorderWidth:(CGFloat)borderWidth andCornerRadius:(CGFloat)radius andFrame:(CGRect)frame forView:(UIView*)view
{
    
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    
    
    [label setTextColor:textColor];
    [label setTextAlignment:UITextAlignmentCenter];
    [label setText:message];
    [label setBackgroundColor:backgroundColor];
    [label setAlpha:1];
    [label.layer setBorderColor:borderColor.CGColor];
    [label.layer setBorderWidth:borderWidth];
    [label.layer setCornerRadius:radius];
    
    //add the toast to the view
    [view addSubview:label];
    
    
    
    //remove the toast
    [UIView beginAnimations:@"fade toast" context:nil];
    [UIView setAnimationDelay:1.5];
    [UIView setAnimationDuration:1.5];
    label.alpha = 0.0;
    [UIView commitAnimations];
}

+(void)toastWithMessage:(NSString*)message withBackgroundImage:(NSString*)imageName andTextColor:(UIColor*)textColor andBorderColor:(UIColor*)borderColor andBorderWidth:(CGFloat)borderWidth andCornerRadius:(CGFloat)radius forView:(UIView*)view
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(150, 700, 454, 30)];
    
    
    [label setTextColor:textColor];
    [label setTextAlignment:UITextAlignmentCenter];
    [label setText:message];
    [label setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:imageName]]];
    [label setAlpha:1];
    [label.layer setBorderColor:borderColor.CGColor];
    [label.layer setBorderWidth:borderWidth];
    [label.layer setCornerRadius:radius];
    
    //add the toast to the view
    [view addSubview:label];
    
    
    
    //remove the toast
    [UIView beginAnimations:@"fade toast" context:nil];
    [UIView setAnimationDelay:1.5];
    [UIView setAnimationDuration:1.5];
    label.alpha = 0.0;
    [UIView commitAnimations];
}







/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
