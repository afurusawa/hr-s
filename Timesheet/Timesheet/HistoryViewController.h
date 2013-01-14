//
//  HistoryViewController.h
//  Timesheet
//
//  Created by Andrew Furusawa on 8/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserWeekViewController.h"
#import "AppDelegate.h"

@interface HistoryViewController : UIViewController <SUPSyncStatusListener>

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentBar;
- (IBAction)segmentPressed:(id)sender;

- (IBAction)goBack:(id)sender;
@property (weak, nonatomic) IBOutlet UINavigationBar *navbar;

@end
