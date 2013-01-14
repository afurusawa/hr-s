//
//  Recommend.h
//
//  Created by Isamu Iida on 2012/12/05.
//  Copyright (c) 2012年 Isamu Iida. All rights reserved.
//
/*
 Set up recommend in viewcontroller
 
 1)add Recommend file to your project
 
 2) add framework to your project
 ->go to Build Phases
 
	Twitter.framework
	Social.framework
	Message.framework
 
 3) disable ARC
 ->go to Compile Sources
 
	NSData+Base64.m		-fno-objc-arc
 
 
 3) ****.h file
 
	#import "Recommend.h"
 
	****.m file
 
	copy and paste this code, then ajust position for your project
 
	Recommend *recommendView;
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone  ) {
		recommendView = [[Recommend alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-92, 320, 92)];
 
	}
	else {
		recommendView = [[Recommend alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-102, 768, 92)];
	}
 
	[self.view addSubview:recommendView];
 
	or
	[self.view insertSubview:recommendView belowSubview:[self.view.subviews objectAtIndex:#]];
 
 4) define 1 - 6

 */

#import <UIKit/UIKit.h>


#import <MessageUI/MFMailComposeViewController.h>
#import <Social/Social.h>
#import <Twitter/TWTweetComposeViewController.h>
#import "NSData+Base64.h"

//*** Mailcompose ***
//app name
#define appName @"Recruitment Manager"																//1
//subject
//option - don't need change
#define subject [NSString stringWithFormat:@"Experience %@",appName]
//app icon
#define imageFileName @"rm-login-recommend-star-btn.png"											//2
//appple store link
//#define applestoreURL @"https://itunes.apple.com/us/app/recruitment-manager/id552615389?mt=8&uo=4"

//apple store app name,no space,all lower case
#define appnameLink @"rectuitment-manager"															//3 CHANGE THIS TO MY APP NAME ONCE ON STORE
//apple store ID#
#define applestoreID @"552615389"																	//4

//*** Twitter ***
// app icon
#define twitterImage @"rm_settings_app_icon_ipad.png"												//5
//option - don't need change
#define twitterText [NSString stringWithFormat:@"Download %@",appName]
//#define twitterURL @"https://itunes.apple.com/us/app/recruitment-manager/id552615389?mt=8&uo=4"
#define twitterURL [NSString stringWithFormat:@"https://itunes.apple.com/us/app/%@/id%@?mt=8",appnameLink,applestoreID]

//*** Rate App ***
//#define rateAppURL @"itms-apps://itunes.apple.com/us/app/recruitment-manager/id552615389?mt=8&uo=4"
#define rateAppURL [NSString stringWithFormat:@"itms-apps://itunes.apple.com/us/app/%@/id%@?mt=8",appnameLink,applestoreID]

//***Nvigationbar color***
//option - don't need change
//default color
#define navigationColor nil																			//6
//or setTintColor
//#define navigationColor [UIColor colorWithRed:65/255.0f green:190/255.0f blue:220/255.0f alpha:1.0]


@interface Recommend : UIView

@property (nonatomic, weak) IBOutlet UIView *view;
@property (nonatomic, readonly) UIViewController *viewController;

@end
