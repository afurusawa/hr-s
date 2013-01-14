//
//  iPhoneOfflineEmployeeDetailsViewController.h
//  HRDirectory
//
//  Created by Alex Chiu on 9/19/12.
//  Copyright (c) 2012 Alex Chiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UnderlyingView.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "iPhoneUnderlyingEmployeeDetailsViewController.h"
#import "ManagerListTableViewController.h"

@interface iPhoneOfflineEmployeeDetailsViewController : iPhoneUnderlyingEmployeeDetailsViewController <UIAlertViewDelegate, MFMailComposeViewControllerDelegate, ManagerListTableViewControllerDelegate>
{
    BOOL isManager;
    
    __weak IBOutlet UINavigationBar *navbar;
    NSMutableArray *managersList;
    NSMutableArray *managersUsernameList;
    NSString *managerUsername;
}

@property NSDictionary *thisEntry;

- (IBAction)beginDeleteEmployee:(id)sender;
- (IBAction)editEntryOrSave:(id)sender;
- (IBAction)goBackOrCancel:(id)sender;
- (IBAction)sendEmail:(id)sender;
- (IBAction)makeCall:(id)sender;

@end

