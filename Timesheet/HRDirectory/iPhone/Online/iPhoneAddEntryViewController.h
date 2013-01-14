//
//  iPhoneAddEntryViewController.h
//  HR_Suite
//
//  Created by Alex Chiu on 9/19/12.
//  Copyright (c) 2012 Alex Chiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HR_SuiteUsers.h"
#import "HR_SuiteHR_SuiteDB.h"
#import "iPhoneUnderlyingAddEntryViewController.h"
#import "ManagerListTableViewController.h"

@interface iPhoneAddEntryViewController : iPhoneUnderlyingAddEntryViewController <UITextFieldDelegate, ManagerListTableViewControllerDelegate>
{
    NSMutableArray *managersList;
    NSMutableArray *managersUsernameList;
    
    __weak IBOutlet UINavigationBar *navbar;
    int managerIndex;
    BOOL usernameExists;
    NSString *managerUsername;
}

- (IBAction)cancel:(id)sender;
- (IBAction)done:(id)sender;

@end
