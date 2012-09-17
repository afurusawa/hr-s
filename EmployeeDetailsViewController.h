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

@class EmployeeDetailsViewController;

@protocol EmployeeDetailsViewControllerDelegate <NSObject>

- (void)refreshView;

@end

@interface EmployeeDetailsViewController : UnderlyingView <UITextFieldDelegate, UIAlertViewDelegate, UITableViewDataSource, UITableViewDelegate>
{
    BOOL isManager;
    BOOL editing;
    
    
    NSString *managerUsername;
}
@property (weak, nonatomic) id <EmployeeDetailsViewControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIButton *editBtn;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;
@property (weak, nonatomic) IBOutlet UIButton *dropDownBtn;

@property (weak, nonatomic) IBOutlet UIImageView *imagePortrait;
@property (weak, nonatomic) IBOutlet UITextField *tfEmployeeName;
@property (weak, nonatomic) IBOutlet UITextField *tfId;
@property (weak, nonatomic) IBOutlet UITextField *tfPhoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *tfEmail;
@property (weak, nonatomic) IBOutlet UITextField *tfPosition;
@property (weak, nonatomic) IBOutlet UITextField *tfDepartment;
@property (weak, nonatomic) IBOutlet UITextView *tvAddress;

- (IBAction)editEntry:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *tfTopCompName;

@property (weak, nonatomic) IBOutlet UITextField *tfManager;
@property (weak, nonatomic) IBOutlet UITableView *managerTable;


@property (weak, nonatomic) IBOutlet UITextField *tfMngPhone; //?
@property (weak, nonatomic) IBOutlet UITextField *tfMngFax; //?

- (IBAction)saveEdit:(id)sender;
- (IBAction)dropDownManagers:(id)sender;

@end
