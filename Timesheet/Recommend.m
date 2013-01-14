//
//  Recommend.m
//
//  Created by Isamu Iida on 2012/12/05.
//  Copyright (c) 2012年 Isamu Iida. All rights reserved.
//

#import "Recommend.h"

//image folder location(don't need change)
#define ImageFolder [NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.app", [[NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Info" ofType:@"plist"]] objectForKey:@"CFBundleExecutable"]]]

@implementation Recommend
@synthesize viewController;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
		if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
			[[NSBundle mainBundle] loadNibNamed:@"Recommend_iphone" owner:self options:nil];

		}
		else {
			[[NSBundle mainBundle] loadNibNamed:@"Recommend_ipad" owner:self options:nil];
		}
		[self addSubview:self.view];
	}
    return self;
}

- (UIViewController *)viewController {
    UIResponder *responder = self;
    while (![responder isKindOfClass:[UIViewController class]]) {
        responder = [responder nextResponder];
        if (nil == responder) {
            break;
        }
    }
    return (UIViewController *)responder;
}

- (void)showMailCompose{
	
    if ([MFMailComposeViewController canSendMail]) {
		
        MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
        mailer.mailComposeDelegate = (id)self;
		[mailer.navigationBar setTintColor:navigationColor];
		[mailer setSubject:subject];
        NSMutableString *emailBody = [NSMutableString string];
		NSString *pathImageFile = [NSString stringWithFormat:@"%@/%@", ImageFolder,imageFileName];
		NSData *imageData = [NSData dataWithContentsOfFile:pathImageFile];
		NSString *base64String = [imageData base64EncodedString];
		[emailBody appendString:[NSString stringWithFormat:@"<div><h4>Download the app from the App Store : <a href='https://itunes.apple.com/us/app/%@/id%@?mt=8&uo=4' target='itunes_store'>%@ - Rapid Consulting</a></h4></div>",appnameLink,applestoreID,appName]];
		[emailBody appendString:@"<div>&ensp;</div>"];
		[emailBody appendString:[NSString stringWithFormat:@"<img src='data:image/gif;base64,%@'>", base64String]];
        [mailer setMessageBody:emailBody isHTML:YES];
		[self.viewController presentViewController:mailer animated:YES completion:^{}];
		
    } else {
		
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mail Failure" message:@"Your device doesn't support in-app email" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
		
    }
	
}

- (void)mailComposeController: (MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
	
    [controller dismissViewControllerAnimated:YES completion:^{}];
	
}
- (void)showTwitter {

	BOOL _isExistSocialFramework;
	_isExistSocialFramework = (NSClassFromString(@"SLComposeViewController") != nil);

    if(_isExistSocialFramework) {
        SLComposeViewController *vc = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
		// Set sending text
		[vc addImage:[UIImage imageNamed:twitterImage]];
		[vc setInitialText:twitterText];
		[vc addURL:[NSURL URLWithString:twitterURL]];
//		[vc addURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://itunes.apple.com/us/app/%@/%@?mt=8",appnameLink,applestoreID]]];

		// event hander definition
        vc.completionHandler = ^(SLComposeViewControllerResult res) {
            if (res == SLComposeViewControllerResultCancelled) {
                // Cancel
            }
            else if (res == SLComposeViewControllerResultDone) {
                // done!
            }
        };
		[self.viewController presentViewController:vc animated:YES completion:nil];
    }
    else {
		// Social.framework is unavailable
		// Twitter  (Device is not iOS6)
		TWTweetComposeViewController *vc = [[TWTweetComposeViewController alloc] init];
		// Set sending text
		[vc addImage:[UIImage imageNamed:twitterImage]];
		[vc setInitialText:twitterText];
		[vc addURL:[NSURL URLWithString:twitterURL]];
//		[vc addURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://itunes.apple.com/us/app/%@/%@?mt=8",appnameLink,applestoreID]]];

		
		// event hander definition
		vc.completionHandler = ^(TWTweetComposeViewControllerResult res) {
			if (res == TWTweetComposeViewControllerResultCancelled) {
			}
			else if (res == TWTweetComposeViewControllerResultDone) {
			}
		};
		[self.viewController presentViewController:vc animated:YES completion:nil];
	}
}

- (void)showRateApp {
	
	UIAlertView *rateAlert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"Rate %@",appName ] message:[NSString stringWithFormat:@"When you rate this app, you leave %@ and open the App Store",appName] delegate:self cancelButtonTitle:@"Rate Now" otherButtonTitles:@"Cancel", nil];
	[rateAlert show];
	
}

-(void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
	
	if (buttonIndex == 0) {
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:rateAppURL]];
	}
}

- (IBAction)shareAndrateButonAction:(id)sender {
	
	UIButton *button = (UIButton *)sender;
	
	switch (button.tag) {
		case 1:
			[self showMailCompose];
			break;
			
		case 2:
			[self showTwitter];
			break;
			
		case 3:
			[self showRateApp];
			break;
			
		default:
			break;
	}
	
}
#pragma mark - Bottom recommendView animation

- (IBAction)upView:(id)sender {

	UIButton *button = (UIButton *)sender;
	[self bottomUpAnimation:self.view];
	[button removeTarget:self action:@selector(upView:) forControlEvents:UIControlEventTouchUpInside];
	[button addTarget:self action:@selector(downView:) forControlEvents:UIControlEventTouchUpInside];

}

- (IBAction)downView:(id)sender {
	
	UIButton *button = (UIButton *)sender;
	[self bottomDownAnimation:self.view];
	[button removeTarget:self action:@selector(downView:) forControlEvents:UIControlEventTouchUpInside];
	[button addTarget:self action:@selector(upView:) forControlEvents:UIControlEventTouchUpInside];

}

- (void)bottomUpAnimation:(UIView *)view {

	[UIView beginAnimations:@"TEMP" context:NULL];
	[UIView setAnimationDuration:0.4];;
	[UIView setAnimationBeginsFromCurrentState:YES];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
	[UIView setAnimationTransition:UIViewAnimationTransitionNone forView:self.view cache:YES];
	[view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y -36, view.frame.size.width, view.frame.size.height)];
	[UIView commitAnimations];

}

- (void)bottomDownAnimation:(UIView *)view {
	
	[UIView beginAnimations:@"TEMP" context:NULL];
	[UIView setAnimationDuration:0.4];;
	[UIView setAnimationBeginsFromCurrentState:YES];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
	[UIView setAnimationTransition:UIViewAnimationTransitionNone forView:self.view cache:YES];
	[view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y +36, view.frame.size.width, view.frame.size.height)];
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
