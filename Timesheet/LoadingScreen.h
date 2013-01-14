//
//  LoadingScreen.h
//  LeaveRequests
//
//  Created by Andrew Furusawa on 9/27/12.
//  Copyright (c) 2012 Andrew Furusawa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadingScreen : UIView

+ (void)startLoadingScreenWithView:(UIView *)view;
+ (void)stopLoadingScreenWithView:(UIView *)view;
@end
