//
//  AddEntryViewController.h
//  HRDirectory
//
//  Created by Alex Chiu on 8/14/12.
//  Copyright (c) 2012 Alex Chiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UnderlyingView.h"
#import "HR_SuiteUsers.h"
#import "HR_SuiteHR_SuiteDB.h"

@interface AddEntryViewController : UnderlyingView <UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray *managersList;
    NSMutableArray *managersUsernameList;
    
    int managerIndex;
    BOOL usernameExists;
    NSString *managerUsername;
    __weak IBOutlet UITableView *managersTable;
}

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *lblUserWarning;

@property (weak, nonatomic) IBOutlet UITextField *tfFirstName;
@property (weak, nonatomic) IBOutlet UITextField *tfLastName;
@property (weak, nonatomic) IBOutlet UITextField *tfId;
@property (weak, nonatomic) IBOutlet UITextField *tfPosition;
@property (weak, nonatomic) IBOutlet UITextField *tfPhone;
@property (weak, nonatomic) IBOutlet UITextField *tfEmail;
@property (weak, nonatomic) IBOutlet UITextField *tfDepartment;
@property (weak, nonatomic) IBOutlet UITextField *tfUsername;
@property (weak, nonatomic) IBOutlet UITextField *tfAddress;
@property (weak, nonatomic) IBOutlet UITextField *tfManager;


- (IBAction)cancel:(id)sender;
- (IBAction)done:(id)sender;
- (IBAction)backgroundTouchedHideKeyboard:(id)sender;
- (IBAction)dropDownList:(id)sender;


@end
