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

@interface iPhoneOfflineEmployeeDetailsViewController : iPhoneUnderlyingEmployeeDetailsViewController <UIAlertViewDelegate, UITableViewDataSource, UITableViewDelegate, MFMailComposeViewControllerDelegate>
{
    BOOL isManager;
    
    NSMutableArray *managersList;
    NSMutableArray *managersUsernameList;
    NSString *managerUsername;
    __weak IBOutlet UITableView *managerTable;
}

@property NSDictionary *thisEntry;

- (IBAction)saveEdit:(id)sender;
- (IBAction)dropDownManagers:(id)sender;
- (IBAction)beginDeleteEmployee:(id)sender;
- (IBAction)editEntryOrCancel:(id)sender;
- (IBAction)goBack:(id)sender;
- (IBAction)sendEmail:(id)sender;
- (IBAction)makeCall:(id)sender;
- (IBAction)callManager:(id)sender;

@end

