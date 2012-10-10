//
//  UnderlyingEmployeeDetailsViewController.m
//  HRDirectory
//
//  Created by Alex Chiu on 10/1/12.
//  Copyright (c) 2012 Alex Chiu. All rights reserved.
//

#import "UnderlyingEmployeeDetailsViewController.h"
#import "MapViewController.h"

@interface UnderlyingEmployeeDetailsViewController ()

@end

@implementation UnderlyingEmployeeDetailsViewController

@synthesize editBtn = _editBtn;
@synthesize saveBtn = _saveBtn;
@synthesize scrollView = _scrollView;
@synthesize deleteBtn = _deleteBtn;
@synthesize dropDownBtn = _dropDownBtn;
@synthesize imagePortrait = _imagePortrait;

//TextFields for Employee Information
@synthesize tfEmployeeName = _tfEmployeeName;
@synthesize tfPhoneNumber = _tfPhoneNumber;
@synthesize tfEmail = _tfEmail;
@synthesize tfPosition = _tfPosition;
@synthesize tfDepartment = _tfDepartment;
@synthesize tvAddress = _tvAddress;

//TextField for Manager Information
@synthesize tfManager = _tfManager;
@synthesize tfMngPhone = _tfMngPhone;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setTFDelegates];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [self setTfEmployeeName:nil];
    [self setTfPosition:nil];
    [self setTfPhoneNumber:nil];
    [self setTfEmail:nil];
    [self setTfDepartment:nil];
    [self setTfManager:nil];
    [self setImagePortrait:nil];
    [self setTfMngPhone:nil];
    [self setEditBtn:nil];
    [self setSaveBtn:nil];
    [self setScrollView:nil];
    [self setDeleteBtn:nil];
    [self setTvAddress:nil];
    [self setEmailBtn:nil];
    [self setAddressBtn:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Disables the textfields to disallow editing
-(void)disableEditing
{
    UIColor *color = [UIColor colorWithRed:(0/255.0) green:(109/255.0) blue:(255.0/255.0) alpha:1.0]; //For clickable objects
    
    self.tfEmployeeName.enabled = NO;
    
    self.tfPhoneNumber.enabled = NO;
    
    self.tfEmail.enabled = NO;
    [self.tfEmail setTextColor:color];
    self.emailBtn.hidden = NO;
    
    self.tfPosition.enabled = NO;
    self.tfDepartment.enabled = NO;
    
    self.tvAddress.editable = NO;
    [self.tvAddress setTextColor:color];
    self.addressBtn.hidden = NO;
    
    self.tfManager.enabled = NO;
    
    self.tfMngPhone.enabled = NO;
    
    [self disableBorders];
    
    self.saveBtn.hidden = YES;
    self.dropDownBtn.hidden = YES;
    
    //When disabling edit, change edit button back to the edit icon
    [self.editBtn setImage:[UIImage imageNamed:@"rm_edit_button_up.png"] forState:UIControlStateNormal];
    editing = NO;
}

//Enables the textfields to enable editing
-(void)enableEditing
{
    UIColor *color = [UIColor colorWithRed:23/255 green:59/255 blue:76/255 alpha:1.0]; //Color when editing
    
    self.tfPhoneNumber.enabled = YES;
    
    self.tfEmail.enabled = YES;
    [self.tfEmail setTextColor:color];
    self.emailBtn.hidden = YES;
    
    self.tfPosition.enabled = YES;
    self.tfDepartment.enabled = YES;
    
    self.tvAddress.editable = YES;
    [self.tvAddress setTextColor:color];
    self.addressBtn.hidden = YES;
    
    [self enableBorders];
    
    self.dropDownBtn.hidden = NO;
    self.saveBtn.hidden = NO;
    
    //When enabling edit, change edit button to the cancel icon
    [self.editBtn setImage:[UIImage imageNamed:@"rm_cancel_button_up.png"] forState:UIControlStateNormal];
    editing = YES;
}

-(void)enableBorders
{
    UIColor *color = [UIColor colorWithRed:(229.0/255.0) green:(229.0/255.0) blue:(229.0/255.0) alpha:1.0];
    self.tfPhoneNumber.backgroundColor = color;
    self.tfEmail.backgroundColor = color;
    self.tfPosition.backgroundColor = color;
    self.tfDepartment.backgroundColor = color;
    self.tvAddress.backgroundColor = color;
    self.tfManager.backgroundColor = color;
}

//Called when disabling editing
-(void)disableBorders
{
    self.tfPhoneNumber.backgroundColor = [UIColor clearColor];
    self.tfEmail.backgroundColor = [UIColor clearColor];
    self.tfPosition.backgroundColor = [UIColor clearColor];
    self.tfDepartment.backgroundColor = [UIColor clearColor];
    self.tvAddress.backgroundColor = [UIColor clearColor];
    self.tfManager.backgroundColor = [UIColor clearColor];
}

//Sets the delegates of all the textfields
-(void)setTFDelegates
{
    self.tfPhoneNumber.delegate = self;
    self.tfPhoneNumber.keyboardType = UIKeyboardTypePhonePad;
    self.tfEmail.delegate = self;
    self.tfEmail.keyboardType = UIKeyboardTypeEmailAddress;
    self.tfPosition.delegate = self;
    self.tfDepartment.delegate = self;
    
    self.tfManager.delegate = self;
    self.tfMngPhone.delegate = self;
}

#pragma mark - UITextFieldDelegate
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    //[textField selectAll:self];
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"Return pressed");
    [textField resignFirstResponder];
    return YES;
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    return YES;
}

@end
