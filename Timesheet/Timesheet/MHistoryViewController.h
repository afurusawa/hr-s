//
//  MHistoryViewController.h
//  Timesheet
//
//  Created by Rapid Consulting on 8/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SUPSyncStatusListener.h"

@interface MHistoryViewController : UIViewController <SUPSyncStatusListener>

@property (weak, nonatomic) IBOutlet UITableView *historyTable;
@property (weak, nonatomic) IBOutlet UINavigationBar *navbar;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentBar;
- (IBAction)segmentPressed:(id)sender;
- (IBAction)goBack:(id)sender;

@end
