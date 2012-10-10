//
//  EmployeeDetailsViewController.h
//  HRDirectory
//
//  Created by Alex Chiu on 8/8/12.
//  Copyright (c) 2012 Alex Chiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UnderlyingView.h"
#import "HR_SuiteUsers.h"
#import "HR_SuiteHR_SuiteDB.h"
#import "AppDelegate.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "UnderlyingEmployeeDetailsViewController.h"
#import "MapViewController.h"

@interface EmployeeDetailsViewController : UnderlyingEmployeeDetailsViewController <UIAlertViewDelegate, UITableViewDataSource, UITableViewDelegate, MFMailComposeViewControllerDelegate>
{
    BOOL isManager;
    
    NSMutableArray *managersList;
    NSMutableArray *managersUsernameList;
    NSString *managerUsername;
    __weak IBOutlet UITableView *managerTable;
}

@property HR_SuiteUsers *thisEntry;

- (IBAction)saveEdit:(id)sender;
- (IBAction)dropDownManagers:(id)sender;
- (IBAction)beginDeleteEmployee:(id)sender;
- (IBAction)editEntryOrCancel:(id)sender;
- (IBAction)sendEmail:(id)sender;
- (IBAction)goToMap:(id)sender;

@end
