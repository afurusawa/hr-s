//
//  iPhoneEmployeeDetailsViewController.h
//  HR_Suite
//
//  Created by Alex Chiu on 9/19/12.
//  Copyright (c) 2012 Alex Chiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "MapViewController.h"
#import "HR_SuiteUsers.h"
#import "HR_SuiteHR_SuiteDB.h"
#import "AppDelegate.h"
#import "iPhoneUnderlyingEmployeeDetailsViewController.h"
#import "ManagerListTableViewController.h"


@interface iPhoneEmployeeDetailsViewController : iPhoneUnderlyingEmployeeDetailsViewController <UIAlertViewDelegate, MFMailComposeViewControllerDelegate, ManagerListTableViewControllerDelegate>
{
    BOOL isManager;
    
    __weak IBOutlet UINavigationBar *navbar;
    NSMutableArray *managersList;
    NSMutableArray *managersUsernameList;
    NSString *managerUsername;
}

@property HR_SuiteUsers *thisEntry;

- (IBAction)dropDownManagers:(id)sender;
- (IBAction)beginDeleteEmployee:(id)sender;
- (IBAction)editEntryOrSave:(id)sender;
- (IBAction)goBackOrCancel:(id)sender;
- (IBAction)sendEmail:(id)sender;
- (IBAction)makeCall:(id)sender;
- (IBAction)callManager:(id)sender;


@end