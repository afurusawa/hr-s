//
//  LoginViewController.m
//  Timesheet
//
//  Created by Andrew Furusawa on 7/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LoginViewController.h"
#import "AppDelegate.h"
#import "RCToast.h"
#import "HR_SuiteUsers.h"
#import "SUPQuery.h"
#import "HR_SuiteHR_SuiteDB.h"
#import "SUPApplication.h"
#import "Recommend.h"

@implementation LoginViewController
{
    AppDelegate *d;
    NSUserDefaults *u;
    HR_SuiteUsersList *SUPUsers;
    BOOL usernameAndPasswordIsCorrect;    
    BOOL revisit;
    BOOL toggle;
}

@synthesize incorrectLoginLabel;
@synthesize usernameField;
@synthesize passwordField;
@synthesize signInButton, rememberMePressed, bottomBar, versionLabel;

// SUP ALERT VIEW CONTENT
#define ALERT_TITLE @"Welcome"
#define ALERT_MSG @"In order to securely access your SAP data from your iOS device, contact us to setup your backend connection to SAP or any other data source. For more information, email us at: info@rapidconsultingusa.com"
#define DEMO_BUTTON 0
#define SUP_BUTTON 1

- (void)viewDidAppear:(BOOL)animated
{
    if (revisit) {
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:ALERT_TITLE message:ALERT_MSG delegate:self cancelButtonTitle:@"Demo application" otherButtonTitles:@"Sign in using SUP", nil];
        [message setAlertViewStyle:UIAlertViewStyleDefault];
        [message show];
    }
}



/****************************************************************************************************
 View Did Load
 ****************************************************************************************************/
- (void)viewDidLoad
{
    //bg
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"ts-bg-bg.png"]]];
        
    d = (AppDelegate *)[[UIApplication sharedApplication] delegate]; //global data
    u = [NSUserDefaults standardUserDefaults]; //remember me
    
    // Initializations
    d.isSUPConnection = NO;
    d.firstrun = YES;
    revisit = NO;
    toggle = NO;
    
    // Demo data initializations
    d.hr_users = [[NSMutableArray alloc] init];
    d.HR_Suite = [[NSMutableArray alloc] init]; //timesheet
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
    
    // Retrieving from SUP MBO doesn't work on viewDidLoad because SUP is still making a connection.
    [self.navigationController setNavigationBarHidden:YES];
    
    // Alert view for selecting demo or sup
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:ALERT_TITLE message:ALERT_MSG delegate:self cancelButtonTitle:@"Demo application" otherButtonTitles:@"Sign in using SUP", nil];
    [message setAlertViewStyle:UIAlertViewStyleDefault];
    [message show];
    
    // Check if remembered
    if ([[u objectForKey:@"remember"] isEqualToString:@"yes"]) {
        toggle = YES;
        usernameField.text = [u stringForKey:@"username"]; 
        passwordField.text = [u stringForKey:@"password"];
        [self.rememberMePressed setImage:[UIImage imageNamed:@"hr-login-rememberme-btn-down.png"] forState:UIControlStateNormal];
    }
    else {
        [u setObject:@"no" forKey:@"remember"];
        [self.rememberMePressed setImage:[UIImage imageNamed:@"hr-login-rememberme-btn-up.png"] forState:UIControlStateNormal];
    }
    
    // Set view for iphone 4 or 5
    if (self.view.frame.size.height > 460) { //iphone5
        [bottomBar setCenter:CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height - 34)];
        
        Recommend *recommendView;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone  ) {
            recommendView = [[Recommend alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-92, 320, 92)];
            
        }
        else {
            recommendView = [[Recommend alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-102, 768, 92)];
        }
        [self.view insertSubview:recommendView belowSubview:[self.view.subviews objectAtIndex:8]];
    }
    else {
        
        Recommend *recommendView;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone  ) {
            recommendView = [[Recommend alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-92, 320, 92)];
            
        }
        else {
            recommendView = [[Recommend alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-102, 768, 92)];
        }
        [self.view insertSubview:recommendView belowSubview:[self.view.subviews objectAtIndex:8]];
    }
    
    // Set version number
    versionLabel.text = [NSString stringWithFormat:@"V%@ DEMO", [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]];
        
}

- (void)viewDidUnload
{
    [self setPasswordField:nil];
    [self setUsernameField:nil];
    [self setSignInButton:nil];
    [self setIncorrectLoginLabel:nil];
    [self setRememberMePressed:nil];
    [self setBottomBar:nil];
    [self setVersionLabel:nil];
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
    if (buttonIndex == DEMO_BUTTON) {        
        d.isSUPConnection = NO;
    }
    
    // right button is sup
    else if (buttonIndex == SUP_BUTTON) {
        if (!d.isSUPConnection && d.firstrun) {
            [LoadingScreen startLoadingScreenWithView:self.view];
            [d connectToSUP];
            [LoadingScreen stopLoadingScreenWithView:self.view];
            d.firstrun = NO;
        }
        d.isSUPConnection = YES;
    }
}



/****************************************************************************************************
 Sign in button pressed
 ****************************************************************************************************/
- (IBAction)signInAction:(id)sender {
    [self.usernameField resignFirstResponder];
    [self.passwordField resignFirstResponder];
    d.user = usernameField.text; //store current employee id.
    
    // remember username/password if applicable
    if (toggle) {
        [u setObject:usernameField.text forKey:@"username"]; NSLog(@"%@", [u stringForKey:@"username"]);
        [u setObject:passwordField.text forKey:@"password"];
        [u synchronize];
    }
    
    /**********************/
    /*   SUP Connection   */
    /**********************/
    if (d.isSUPConnection) {
        
        SUPUsers = [HR_SuiteUsers findAll]; //load from SUP.
        
        if ([SUPUsers length] > 0)
        {
            usernameAndPasswordIsCorrect = NO;
            for (HR_SuiteUsers *supItem in SUPUsers) {
                
                if([supItem.employeeID isEqualToString:usernameField.text] && [supItem.employeePassword isEqualToString:passwordField.text]) {
                    
                    usernameAndPasswordIsCorrect = YES;
                    [self performSegueWithIdentifier: @"toMain" sender: self];
                }
            }
            
            //If the username and/or password is wrong, set error condition.
            if (!usernameAndPasswordIsCorrect) {
                RCToast *t = [[RCToast alloc] init];
                [t showToastInView:self.view withMessage:@"Incorrect username and/or password"];
                NSLog(@"Incorrect username and/or password");
                //incorrectLoginLabel.hidden = NO;
                passwordField.text = nil;
            }
        }
    }
    
    /************/
    /*   DEMO   */
    /************/
    else {
//        NSString *tempUser = self.usernameField.text;
//        NSString *tempPass = self.passwordField.text;
//        
//        NSLog(@"Checking login in offline mode");
//        
//        AppDelegate *data = (AppDelegate *)[UIApplication sharedApplication].delegate;
//        NSDictionary *usernameAttempt = [data findByUsername:tempUser];
//        
//        if(usernameAttempt != nil)
//        {
//            NSString *thisUsername = [usernameAttempt objectForKey:@"employeeID"];
//            NSString *thisPassword = [usernameAttempt objectForKey:@"password"];
//            
//            //If password is correct
//            if([thisPassword isEqualToString:tempPass])
//            {
//                d.manager = 1;
//                data.user = [NSString stringWithString:thisUsername];
//                [self performSegueWithIdentifier: @"toMain" sender: self];
//            }
//            else{
//                RCToast *t = [[RCToast alloc] init];
//                [t showToastInView:self.view withMessage:@"Incorrect username and/or password"];
//                passwordField.text = nil;
//            }
//            
//        }
//        else {
//            RCToast *t = [[RCToast alloc] init];
//            [t showToastInView:self.view withMessage:@"Incorrect username and/or password"];
//            passwordField.text = nil;
//        }
        
        if ([usernameField.text isEqualToString:@"manager"]) { d.manager=1; }
        if (([usernameField.text isEqualToString:@"manager"] || [usernameField.text isEqualToString:@"user"]) && [passwordField.text isEqualToString:@"test"]) {
            [self performSegueWithIdentifier: @"toMain" sender: self];
        }
        
        else {
            RCToast *t = [[RCToast alloc] init];
            [t showToastInView:self.view withMessage:@"Incorrect username and/or password"];
            passwordField.text = nil;
        }
    }

    revisit = YES;
}




- (IBAction)rememberMePressed:(id)sender {
    u = [NSUserDefaults standardUserDefaults];
    toggle = !toggle;
    if (toggle) {
        [u setObject:@"yes" forKey:@"remember"];
        [self.rememberMePressed setImage:[UIImage imageNamed:@"hr-login-rememberme-btn-down.png"] forState:UIControlStateNormal];
    }
    else {
        [u setObject:@"no" forKey:@"remember"];
        [u removeObjectForKey:@"username"];
        [u removeObjectForKey:@"password"];
        [u synchronize];
        [self.rememberMePressed setImage:[UIImage imageNamed:@"hr-login-rememberme-btn-up.png"] forState:UIControlStateNormal];
    }
    
}

-(BOOL)checkIfOfflineManager:(NSString *)employee
{
    AppDelegate *data = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    for(NSDictionary *user in data.hr_users)
    {
        if([[user objectForKey:@"manager"] isEqualToString:employee])
        {
            return YES;
        }
    }
    return NO;
}

@end
