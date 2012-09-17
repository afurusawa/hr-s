//
//  UnderlyingView.m
//  HRDirectory
//
//  Created by Alex Chiu on 8/14/12.
//  Copyright (c) 2012 Alex Chiu. All rights reserved.
//

#import "UnderlyingView.h"

@implementation UnderlyingView

//Begins the loading animations
-(void)startLoadingAnimations
{
    indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    loadingView = [[UIView alloc] initWithFrame:[[self view] bounds]];
    
    //Loading View Asthetics
    [loadingView setBackgroundColor:[UIColor blackColor]];
    [loadingView setAlpha:0.2];
    
    
    indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    indicator.frame = CGRectMake(250,250, 325, 325);
    [[self view] addSubview:loadingView];
    [loadingView addSubview:indicator];
    
    [[self view] addSubview:indicator];
    
    [indicator startAnimating];
}

-(void)stopLoadingAnimations
{
    [indicator stopAnimating];
    [loadingView removeFromSuperview];
}
@end
