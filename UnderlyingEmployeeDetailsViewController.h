//
//  UnderlyingEmployeeDetailsViewController.h
//  HRDirectory
//
//  Created by Alex Chiu on 10/1/12.
//  Copyright (c) 2012 Alex Chiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UnderlyingView.h"

@interface UnderlyingEmployeeDetailsViewController : UnderlyingView <UITextFieldDelegate>
{
    BOOL editing;
}

@property (weak, nonatomic) IBOutlet UIButton *editBtn;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;
@property (weak, nonatomic) IBOutlet UIButton *dropDownBtn;
@property (weak, nonatomic) IBOutlet UIButton *emailBtn;
@property (weak, nonatomic) IBOutlet UIButton *addressBtn;

@property (weak, nonatomic) IBOutlet UIImageView *imagePortrait;
@property (weak, nonatomic) IBOutlet UITextField *tfEmployeeName;
@property (weak, nonatomic) IBOutlet UITextField *tfPhoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *tfEmail;
@property (weak, nonatomic) IBOutlet UITextField *tfPosition;
@property (weak, nonatomic) IBOutlet UITextField *tfDepartment;
@property (weak, nonatomic) IBOutlet UITextView *tvAddress;

@property (weak, nonatomic) IBOutlet UITextField *tfManager;
@property (weak, nonatomic) IBOutlet UITextField *tfMngPhone;

-(void)enableEditing;
-(void)disableEditing;

@end
