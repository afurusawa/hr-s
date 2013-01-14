//
//  HomeViewController.h
//  Timesheet
//
//  Created by Andrew Furusawa on 7/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeViewController : UIViewController
- (IBAction)logout:(id)sender;
- (IBAction)openHRDirectory:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *mainView;

- (IBAction)toTimesheet:(id)sender;
@property (weak, nonatomic) IBOutlet UINavigationBar *navbar;
- (IBAction)reportBug:(id)sender;

@end
