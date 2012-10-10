//
//  UnderlyingView.h
//  HRDirectory
//
//  Created by Alex Chiu on 8/14/12.
//  Copyright (c) 2012 Alex Chiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UnderlyingView : UIViewController
{
    UIActivityIndicatorView *indicator;
    UIView *loadingView;
    BOOL keyboardShown;
}

-(void)startLoadingAnimations;
-(void)stopLoadingAnimations;
-(NSString *)stripEverythingButNumbers:(NSString*)phoneNumber;
-(BOOL)characterIsDigit:(char)ch;
-(NSString*)formatNumber:(NSString*)mobileNumber;
-(int)getLength:(NSString*)mobileNumber;
-(NSString *)formatPhoneNumber:(NSString *)phoneNumber;


@end
