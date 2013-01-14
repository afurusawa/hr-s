//
//  iPhoneUnderlyingEmployeeDetailsViewController.h
//  HRDirectory
//
//  Created by Alex Chiu on 10/2/12.
//  Copyright (c) 2012 Alex Chiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UnderlyingView.h"

@interface iPhoneUnderlyingEmployeeDetailsViewController : UnderlyingView <UITextFieldDelegate>
{
    BOOL editing;
}

@property (weak, nonatomic) IBOutlet UIButton *editSaveBtn;
@property (weak, nonatomic) IBOutlet UIButton *backCancelBtn;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;
@property (weak, nonatomic) IBOutlet UIButton *emailBtn;
@property (weak, nonatomic) IBOutlet UIButton *phoneBtn;
@property (weak, nonatomic) IBOutlet UIButton *btnManager;
@property (weak, nonatomic) IBOutlet UIButton *btnMap;

//Labels
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblSplitFirstName;
@property (weak, nonatomic) IBOutlet UILabel *lblSplitLastName;
@property (weak, nonatomic) IBOutlet UILabel *lblPosition;
@property (weak, nonatomic) IBOutlet UILabel *lblDepartment;
@property (weak, nonatomic) IBOutlet UILabel *lblAddress;
@property (weak, nonatomic) IBOutlet UILabel *lblPhone;
@property (weak, nonatomic) IBOutlet UILabel *lblEmail;
@property (weak, nonatomic) IBOutlet UILabel *lblManager;
@property (weak, nonatomic) IBOutlet UILabel *lblBasicInfo;
@property (weak, nonatomic) IBOutlet UILabel *lblContactInfo;

@property (weak, nonatomic) IBOutlet UIImageView *imagePortrait;
@property (weak, nonatomic) IBOutlet UITextField *tfPhoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *tfEmail;
@property (weak, nonatomic) IBOutlet UITextField *tfPosition;
@property (weak, nonatomic) IBOutlet UITextField *tfDepartment;
@property (weak, nonatomic) IBOutlet UILabel *lblViewAddress;
@property (weak, nonatomic) IBOutlet UITextView *tvAddress;

@property (weak, nonatomic) IBOutlet UITextField *tfManager;

-(void)enableEditing;
-(void)disableEditing;

@end
