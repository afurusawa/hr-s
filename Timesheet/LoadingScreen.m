//
//  LoadingScreen.m
//  LeaveRequests
//
//  Created by Andrew Furusawa on 9/27/12.
//  Copyright (c) 2012 Andrew Furusawa. All rights reserved.
//

#import "LoadingScreen.h"

@implementation LoadingScreen

static UIView *loadingScreen;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

+ (void)startLoadingScreenWithView:(UIView *)view
{
    loadingScreen = [[UIView alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height)];
    loadingScreen.backgroundColor = [UIColor grayColor];
    loadingScreen.alpha = .5;
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [activityIndicator setCenter:CGPointMake(loadingScreen.frame.size.width/2, loadingScreen.frame.size.height/2)];
    [activityIndicator startAnimating];
    [loadingScreen addSubview:activityIndicator];
    
    [view addSubview:loadingScreen];
}

+ (void)stopLoadingScreenWithView:(UIView *)view
{
    [view bringSubviewToFront:loadingScreen];
    [loadingScreen removeFromSuperview];
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
