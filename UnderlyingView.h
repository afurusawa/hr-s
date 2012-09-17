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
}

-(void)startLoadingAnimations;
-(void)stopLoadingAnimations;

@end
