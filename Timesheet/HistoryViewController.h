//
//  HistoryViewController.h
//  Timesheet
//
//  Created by Andrew Furusawa on 8/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserWeekViewController.h"

@interface HistoryViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *historyTable;
@property (weak, nonatomic) IBOutlet UITableView *lrhistoryTable;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentBar;
- (IBAction)segmentPressed:(id)sender;

@end
