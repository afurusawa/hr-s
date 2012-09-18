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

@interface EmployeeDetailsViewController : UnderlyingView <UITextFieldDelegate, UIAlertViewDelegate, UITableViewDataSource, UITableViewDelegate>
{
    BOOL isManager;
    BOOL editing;
    
    NSMutableArray *managersList;
    NSMutableArray *managersUsernameList;
    NSString *managerUsername;
    __weak IBOutlet UITableView *managerTable;
}

@property (weak, nonatomic) IBOutlet UIButton *editBtn;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;
@property (weak, nonatomic) IBOutlet UIButton *dropDownBtn;

@property HR_SuiteUsers *thisEntry;
@property (weak, nonatomic) IBOutlet UIImageView *imagePortrait;
@property (weak, nonatomic) IBOutlet UITextField *tfEmployeeName;
@property (weak, nonatomic) IBOutlet UITextField *tfId;
@property (weak, nonatomic) IBOutlet UITextField *tfPhoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *tfEmail;
@property (weak, nonatomic) IBOutlet UITextField *tfPosition;
@property (weak, nonatomic) IBOutlet UITextField *tfDepartment;
@property (weak, nonatomic) IBOutlet UITextView *tvAddress;

@property (weak, nonatomic) IBOutlet UITextField *tfManager;
@property (weak, nonatomic) IBOutlet UITextField *tfMngPhone;
@property (weak, nonatomic) IBOutlet UITextField *tfMngFax;

- (IBAction)saveEdit:(id)sender;
- (IBAction)dropDownManagers:(id)sender;
- (IBAction)beginDeleteEmployee:(id)sender;
- (IBAction)editEntryOrCancel:(id)sender;

@end
