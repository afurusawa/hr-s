//
//  iPhoneUnderlyingEmployeeDetailsViewController.m
//  HRDirectory
//
//  Created by Alex Chiu on 10/2/12.
//  Copyright (c) 2012 Alex Chiu. All rights reserved.
//

#import "iPhoneUnderlyingEmployeeDetailsViewController.h"

@interface iPhoneUnderlyingEmployeeDetailsViewController ()

@end

@implementation iPhoneUnderlyingEmployeeDetailsViewController

@synthesize scrollView = _scrollView;
@synthesize deleteBtn = _deleteBtn;
@synthesize imagePortrait = _imagePortrait;

//TextFields for Employee Information
@synthesize tfPhoneNumber = _tfPhoneNumber;
@synthesize tfEmail = _tfEmail;
@synthesize tfPosition = _tfPosition;
@synthesize tfDepartment = _tfDepartment;
@synthesize tvAddress = _tvAddress;

//TextField for Manager Information
@synthesize tfManager = _tfManager;


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
    [self setTfPosition:nil];
    [self setTfPhoneNumber:nil];
    [self setTfEmail:nil];
    [self setTfDepartment:nil];
    [self setTfManager:nil];
    [self setImagePortrait:nil];
    [self setScrollView:nil];
    [self setDeleteBtn:nil];
    [self setTvAddress:nil];
    [self setEmailBtn:nil];
    [self setPhoneBtn:nil];
    [self setLblPosition:nil];
    [self setLblDepartment:nil];
    [self setLblAddress:nil];
    [self setLblPhone:nil];
    [self setLblEmail:nil];
    [self setLblManager:nil];
    [self setLblName:nil];
    [self setLblName:nil];
    [self setLblBasicInfo:nil];
    [self setLblContactInfo:nil];
    [self setBtnManager:nil];
    [self setBtnMap:nil];
    [self setLblSplitFirstName:nil];
    [self setLblSplitLastName:nil];
    [self setLblAddress:nil];
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

    self.tfPhoneNumber.enabled = NO;
    [self.tfPhoneNumber setTextColor:color];
    self.phoneBtn.hidden = NO;
    
    self.tfEmail.enabled = NO;
    [self.tfEmail setTextColor:color];
    self.emailBtn.hidden = NO;
    
    self.tfPosition.enabled = NO;
    self.tfDepartment.enabled = NO;
    
    self.lblViewAddress.hidden = NO;
    [self.lblViewAddress setTextColor:color];
    self.tvAddress.hidden = YES;
    self.tvAddress.editable = NO;
    //[self.tvAddress setTextColor:color];
    
    self.tfManager.enabled = NO;
    
    self.btnMap.hidden = NO;
    
    [self.btnManager setHidden:YES];
    
    //When disabling edit, change edit button back to the edit icon
    [self.editSaveBtn setImage:[UIImage imageNamed:@"ts.topappbar-edit-btn-up.png"] forState:UIControlStateNormal];
    //Change the cancel button to back
    [self.backCancelBtn setImage:[UIImage imageNamed:@"ts.topappbar-back-btn-up.png"] forState:UIControlStateNormal];
    
    editing = NO;
}

//Enables the textfields to enable editing
-(void)enableEditing
{
    UIColor *color = [UIColor colorWithRed:111/255.0 green:114/255.0 blue:118/255.0 alpha:1.0]; //Color when editing
    
    self.tfPhoneNumber.enabled = YES;
    [self.tfPhoneNumber setTextColor:color];
    self.phoneBtn.hidden = YES;
    
    self.tfEmail.enabled = YES;
    [self.tfEmail setTextColor:color];
    self.emailBtn.hidden = YES;
    
    self.tfPosition.enabled = YES;
    self.tfDepartment.enabled = YES;
    
    self.lblViewAddress.hidden = YES;
    self.tvAddress.hidden = NO;
    self.tvAddress.editable = YES;
    [self.tvAddress setTextColor:color];
    
    self.btnMap.hidden = YES;

//    [self.btnManager setHidden:NO];
    
    //When enabling edit, change edit button to the Done icon
    [self.editSaveBtn setImage:[UIImage imageNamed:@"ts.topappbar-done-btn-up.png"] forState:UIControlStateNormal];
    //Change the back button to Cancel
    [self.backCancelBtn setImage:[UIImage imageNamed:@"ts.topappbar-cancel-btn-up.png"] forState:UIControlStateNormal];
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
//Also sets up the fonts for lbls
-(void)setTFDelegates
{
    self.tfPhoneNumber.delegate = self;
    self.tfPhoneNumber.keyboardType = UIKeyboardTypePhonePad;
    
    self.tfEmail.delegate = self;
    self.tfEmail.keyboardType = UIKeyboardTypeEmailAddress;
    
    self.tfPosition.delegate = self;
    self.tfDepartment.delegate = self;
    
    self.tfManager.delegate = self;
    
    [self.lblViewAddress setAdjustsFontSizeToFitWidth:NO];
    [self.lblViewAddress setNumberOfLines:0];
    
    //Setting fonts for labels because can't do custom fonts in storyboard
    [self.lblName setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:28]];
    [self.lblSplitFirstName setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:20]];
    [self.lblSplitLastName setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:20]];
    [self.lblPosition setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:14]];
    [self.lblDepartment setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:14]];
    [self.lblAddress setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:14]];
    [self.lblPhone setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:14]];
    [self.lblEmail setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:14]];
    [self.lblManager setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:14]];
    [self.lblBasicInfo setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:14]];
    [self.lblContactInfo setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:14]];
    
    //Setting font for textfields
    [self.tfPosition setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:14]];
    [self.tfDepartment setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:14]];
    [self.tvAddress setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:14]];
    [self.lblViewAddress setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:14]];
    [self.tfPhoneNumber setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:14]];
    [self.tfEmail setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:14]];
    [self.tfManager setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:14]];
    
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
