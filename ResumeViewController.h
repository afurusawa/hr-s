//
//  ResumeViewController.h
//  HRDirectory
//
//  Created by Alex Chiu on 8/20/12.
//  Copyright (c) 2012 Alex Chiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UnderlyingView.h"

@interface ResumeViewController : UnderlyingView

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) NSString *resumeURL;

@end
