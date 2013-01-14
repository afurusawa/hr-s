//
//  iPhoneUnderlyingAddEntryViewController.m
//  HRDirectory
//
//  Created by Alex Chiu on 11/28/12.
//  Copyright (c) 2012 Alex Chiu. All rights reserved.
//

#import "iPhoneUnderlyingAddEntryViewController.h"

@interface iPhoneUnderlyingAddEntryViewController ()

@end

@implementation iPhoneUnderlyingAddEntryViewController

@synthesize scrollView = _scrollView;
@synthesize lblUserWarning = _lblUserWarning;

@synthesize tfFirstName = _tfFirstName;
@synthesize tfLastName = _tfLastName;
@synthesize tfId = _tfId;
@synthesize tfPosition = _tfPosition;
@synthesize tfPhone = _tfPhone;
@synthesize tfEmail = _tfEmail;
@synthesize tfDepartment = _tfDepartment;
@synthesize tfUsername = _tfUsername;
@synthesize tfAddress = _tfAddress;
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
    
    self.lblUserWarning.hidden = YES;
    self.tfManager.enabled = NO; //Doesn't allow the textfield to be editable. Needs to select from a table
    
    //Starts out with no manager
    self.tfManager.text = @"None";
    
    //Prepares font and delegates for textfields
    [self prepareTextFields];
    
	// Do any additional setup after loading the view.
}

-(void)viewDidUnload
{
    [self setTfFirstName:nil];
    [self setTfLastName:nil];
    [self setTfPosition:nil];
    [self setTfPhone:nil];
    [self setTfEmail:nil];
    [self setTfId:nil];
    [self setScrollView:nil];
    [self setTfUsername:nil];
    [self setLblUserWarning:nil];
    [self setTfAddress:nil];
    [self setLblFirstName:nil];
    [self setLblLastName:nil];
    [self setLblId:nil];
    [self setLblPosition:nil];
    [self setLblDepartment:nil];
    [self setLblAddress:nil];
    [self setLblPhone:nil];
    [self setLblEmail:nil];
    [self setLblUsername:nil];
    [self setLblEmployeeInfo:nil];
    [self setLblManagerInfo:nil];
    [super viewDidUnload];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Set delegates for textFields and set fonts
-(void)prepareTextFields
{
    self.tfFirstName.delegate = self;
    self.tfLastName.delegate = self;
    self.tfId.delegate = self;
    self.tfId.keyboardType = UIKeyboardTypeNumberPad;
    self.tfDepartment.delegate = self;
    self.tfPosition.delegate = self;
    self.tfPhone.delegate = self;
    self.tfPhone.keyboardType = UIKeyboardTypePhonePad;
    self.tfEmail.delegate = self;
    self.tfEmail.keyboardType = UIKeyboardTypeEmailAddress;
    self.tfUsername.delegate = self;
    
    [self.tfFirstName setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:14]];
    [self.tfLastName setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:14]];
    [self.tfId setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:14]];
    [self.tfDepartment setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:14]];
    [self.tfPosition setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:14]];
    [self.tfPhone setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:14]];
    [self.tfEmail setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:14]];
    [self.tfUsername setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:14]];
    [self.tfAddress setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:14]];
    
    [self.lblEmployeeInfo setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:15]];
    [self.lblManagerInfo setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:15]];
    [self.lblFirstName setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:14]];
    [self.lblLastName setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:14]];
    [self.lblId setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:14]];
    [self.lblPhone setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:14]];
    [self.lblPosition setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:14]];
    [self.lblDepartment setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:14]];
    [self.lblAddress setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:14]];
    [self.lblEmail setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:14]];
    [self.lblUsername setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:14]];
    
    [self.tfAddress setBackgroundColor:[UIColor clearColor]];
}

#pragma mark - UITextFieldDelegate
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    //[textField selectAll:self];
    return YES;
}

//Setting it to go to the next text field if return is pressed.
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    if(textField.tag != 9)
    {
        int newTag = textField.tag +1;
        UITextField *tf = (UITextField *)[self.view viewWithTag:newTag];
        [tf becomeFirstResponder];
    }
    return YES;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    //Handles Delete
    if([string length] == 0)
        return YES;
    
    //Formats phone number
    if([textField isEqual:[self tfPhone]])
    {
        NSString *rawDigits = [self stripEverythingButNumbers:textField.text];
        int length = [rawDigits length];
        
        //Only allows characters and 10 digits
        if(![self characterIsDigit:[string characterAtIndex:0]] || length >=10)
            return NO;
        else
            textField.text = [self formatPhoneNumber:rawDigits];
    }
    
    //Only allows digits in id field
    if([textField isEqual:self.tfId])
    {
        if(![self characterIsDigit:[string characterAtIndex:0]])
            return NO;
    }
    
    return YES;
}


@end
