//
//  TimesheetViewController.h
//  Timesheet
//
//  Created by Andrew Furusawa on 7/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimesheetViewController : UIViewController
{
//    NSUserDefaults *defaults;
//    NSString *currentUser;
}

//Managers (these don't need to be properties)
@property (strong, nonatomic) IBOutlet UIButton *MTimesheets;
@property (strong, nonatomic) IBOutlet UIButton *MLeaveRequests;
@property (strong, nonatomic) IBOutlet UIButton *MJobManager;
@property (strong, nonatomic) IBOutlet UIButton *MSettings;
@property (weak, nonatomic) IBOutlet UIButton *MHistory;

//Users
@property (strong, nonatomic) IBOutlet UIButton *UTimeEntry;
@property (strong, nonatomic) IBOutlet UIButton *ULeaveRequests;
@property (strong, nonatomic) IBOutlet UIButton *UHistory;
@property (strong, nonatomic) IBOutlet UIButton *USettings;

- (IBAction)timeEntry:(id)sender;

@property (weak, nonatomic) IBOutlet UITableView *notificationTable;





@end
