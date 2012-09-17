//
//  UDayViewController.h
//  Timesheet
//
//  Created by Rapid Consulting on 8/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JobViewController.h"

@class UDayViewController;

@protocol UDayViewControllerDelegate <NSObject>
- (void)reloadView;
@end

@interface UDayViewController : UIViewController <JobViewControllerDelegate, UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *dayTable;
- (IBAction)addTask:(id)sender;
- (IBAction)removeTask:(id)sender;
- (IBAction)donePressed:(id)sender;
- (IBAction)switchPressed:(id)sender;
- (IBAction)hoursEntered:(id)sender;
- (IBAction)hoursBeginEditing:(id)sender;

- (IBAction)addTask_iPhone:(id)sender;

@property (weak, nonatomic) IBOutlet UISwitch *lockSwitch;
@property (weak, nonatomic) IBOutlet UITextField *hoursField;
@property (weak, nonatomic) id <UDayViewControllerDelegate> delegate;
- (IBAction)hoursEntered:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *dayLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalHours;
@property (weak, nonatomic) IBOutlet UIButton *doneButton;
@property (weak, nonatomic) IBOutlet UIButton *addTaskButton;

@end
