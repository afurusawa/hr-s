//
//  LoginViewController.m
//  Timesheet
//
//  Created by Andrew Furusawa on 7/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LoginViewController.h"
#import "AppDelegate.h"
#import "HR_SuiteUsers.h"
#import "SUPQuery.h"
#import "HR_SuiteHR_SuiteDB.h"
#import "SUPApplication.h"

@implementation LoginViewController
{
    AppDelegate *d;
    HR_SuiteUsersList *SUPUsers;
    BOOL usernameAndPasswordIsCorrect;    
    BOOL revisit;
}

@synthesize incorrectLoginLabel;
@synthesize usernameField;
@synthesize passwordField;
@synthesize signInButton;



- (void)viewDidAppear:(BOOL)animated
{
    if (revisit) {
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Select a version:" message:nil delegate:self cancelButtonTitle:@"Demo Version" otherButtonTitles:@"Connect to SUP", nil];
        [message setAlertViewStyle:UIAlertViewStyleDefault];
        [message show];
    }
}



/****************************************************************************************************
 View Did Load
 ****************************************************************************************************/
- (void)viewDidLoad
{
    d = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    d.isSUPConnection = NO;
    revisit = NO;

    d.hr_users = [[NSMutableArray alloc] init];
    d.HR_Suite = [[NSMutableArray alloc] init];
    d.hr_tasks = [[NSMutableArray alloc] init];
    d.hr_taskmanagement = [[NSMutableArray alloc] init];
    d.hr_leaverequests = [[NSMutableArray alloc] init];
    d.hr_approvals = [[NSMutableArray alloc] init];
    
    [d createHRUsers];
    [d createHRTasks];
    [d createHRTaskManagement];
    [d createHRLeaveRequests];
    [d createHRTimesheetApprovals];
    [d createHRTimesheet];
    
    //Retrieving from SUP MBO doesn't work on viewDidLoad because SUP is still making a connection.
    [self.navigationController setNavigationBarHidden:YES];
    
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Select a version:" message:nil delegate:self cancelButtonTitle:@"Demo Version" otherButtonTitles:@"Connect to SUP", nil];
    [message setAlertViewStyle:UIAlertViewStyleDefault];
    [message show];    
}

- (void)viewDidUnload
{
    [self setPasswordField:nil];
    [self setUsernameField:nil];
    [self setSignInButton:nil];
    [self setIncorrectLoginLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    if(theTextField == self.usernameField || theTextField == self.passwordField) {
        [theTextField resignFirstResponder];
    }
    return YES;
}



/****************************************************************************************************
 Alert View - clicked button
 ****************************************************************************************************/
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    // left button is demo
    if (buttonIndex == 0) {        
        d.isSUPConnection = NO;
    }
    
    // right button is sup
    else if (buttonIndex == 1) {
        if (!d.isSUPConnection) {
            [d connectToSUP];
        }
        d.isSUPConnection = YES;
    }
}



/****************************************************************************************************
 Sign in button pressed
 ****************************************************************************************************/
- (IBAction)signInAction:(id)sender {
    
    d.user = usernameField.text; //store current employee id.
    
    /**********************/
    /*   SUP Connection   */
    /**********************/
    if (d.isSUPConnection) {
        
        SUPUsers = [HR_SuiteUsers findAll]; //load from SUP.
        
        if ([SUPUsers length] > 0)
        {
            usernameAndPasswordIsCorrect = NO;
            for (HR_SuiteUsers *supItem in SUPUsers)
            {

                if([supItem.employeeID isEqualToString:usernameField.text] && [supItem.employeePassword isEqualToString:passwordField.text]) {
                    NSLog(@"\n username=%@ \n password=%@", supItem.employeeID, supItem.employeePassword);
                    NSLog(@"Login was successful.");
                    
                    usernameAndPasswordIsCorrect = YES;
                    incorrectLoginLabel.hidden = YES;
                    [self performSegueWithIdentifier: @"toMain" sender: self];
                }
            }
            
            //If the username and/or password is wrong, set error condition.
            if (!usernameAndPasswordIsCorrect) {
                NSLog(@"Incorrect username and/or password");
                incorrectLoginLabel.hidden = NO;
                passwordField.text = nil;
            }
        }
    }
    
    /************/
    /*   DEMO   */
    /************/
    else {
        
        if (([usernameField.text isEqualToString:@"manager"] || [usernameField.text isEqualToString:@"user"]) && [passwordField.text isEqualToString:@"test"]) {
            incorrectLoginLabel.hidden = YES;
            [self performSegueWithIdentifier: @"toMain" sender: self];
        }
        
        else {
            incorrectLoginLabel.hidden = NO;
            usernameField.text = nil;
            passwordField.text = nil;
        }
    }

    revisit = YES;
}




@end
