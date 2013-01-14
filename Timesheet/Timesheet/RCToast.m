//
//  Toast.m
//  Hanalytics
//
//  Created by Fernando Aguilar on 9/25/12.
//  Copyright (c) 2012 Fernando Aguilar. All rights reserved.
//

#import "RCToast.h"

@implementation RCToast
@synthesize label = _label;
@synthesize message = _message;
@synthesize textColor = _textColor;
@synthesize backgroundColor = _backgroundColor;
@synthesize borderColor = _borderColor;
@synthesize borderWidth = _borderWidth;
@synthesize cornerRadius = _cornerRadius;
@synthesize origin = _origin;
@synthesize length = _length;

-(id)init
{
    if(self){
        self.message = @"RCTOAST";
        self.textColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor colorWithRed:59/255.0 green:170/255.0 blue:200/255.0 alpha:1];
        self.borderColor = [UIColor blackColor];
        self.borderWidth = 2;
        self.cornerRadius = 5;
        self.length = 280;
        self.origin = CGPointMake(20, 380);
    }
    
    return self;
}


-(void)showToastInView:(UIView *)view withMessage:(NSString *)msg
{
    
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(self.origin.x, self.origin.y, self.length, 25)];
    
    [self.label setNumberOfLines:2];
    [self.label setLineBreakMode:NSLineBreakByWordWrapping];
    [self.label setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:13]];
    [self.label setTextColor:self.textColor];
    [self.label setTextAlignment:NSTextAlignmentCenter];
    [self.label setText:msg];
    [self.label setBackgroundColor:self.backgroundColor];
    [self.label setAlpha:1];
    [self.label.layer setCornerRadius:self.cornerRadius];
    
    //add the toast to the view
    [view addSubview:self.label];
    
    
    
    //fade the toast away
    [UIView beginAnimations:@"fade toast" context:nil];
    [UIView setAnimationDelay:1.0];
    [UIView setAnimationDuration:1.25];
    self.label.alpha = 0.0;
    [UIView commitAnimations];
    
    //remove the toast from the superview
    [self performSelector:@selector(removeToast:) withObject:view afterDelay:3.1];

}

-(void)removeToast:(UIView*) view
{
    [view bringSubviewToFront:self.label];
    [self.label removeFromSuperview];
}





@end
