//
//  RegisterView.m
//  Registration
//
//  Created by Isamu Iida on 2012/11/28.
//  Copyright (c) 2012年 Isamu Iida. All rights reserved.
//

#import "RegisterView.h"

@interface RegisterView ()

@property (weak, nonatomic) IBOutlet UITextField *fnameTF;
@property (weak, nonatomic) IBOutlet UITextField *lnameTF;
@property (weak, nonatomic) IBOutlet UITextField *companyTF;
@property (weak, nonatomic) IBOutlet UITextField *emailTF;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;

@end

@implementation RegisterView
@synthesize navbar, instructionLabel, bottomBar;


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
	[self.fnameTF setFont:[UIFont fontWithName:@"ProximaNova-Regular" size:14]];
	[self.lnameTF setFont:[UIFont fontWithName:@"ProximaNova-Regular" size:14]];
	[self.companyTF setFont:[UIFont fontWithName:@"ProximaNova-Regular" size:14]];
	[self.emailTF setFont:[UIFont fontWithName:@"ProximaNova-Regular" size:14]];
    
    //navbar title bg
    [navbar setBackgroundImage:[UIImage imageNamed:@"ts.topappbar-bg.png"] forBarMetrics:UIBarMetricsDefault];
    
    //bg
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"ts-bg-bg.png"]]];

    
    [instructionLabel setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:11]];
    
    //set view for iphone 4 or 5
    if (self.view.frame.size.height > 460) { //iphone5
        [bottomBar setCenter:CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height - 34)];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)submitRegistration:(id)sender {
	
	if ([self.fnameTF.text isEqualToString:@""] || [self.lnameTF.text isEqualToString:@""] || [self.companyTF.text isEqualToString:@""] || [self.emailTF.text isEqualToString:@""])
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Warning"
                                                       message:@"Please fill in all required information before submitting"
                                                      delegate:nil
                                             cancelButtonTitle:@"OK"
                                             otherButtonTitles:nil];
        [alert show];
        return;
    }


	NSString* url = [[NSString stringWithFormat:@"http://rapidconsultingusa.com/html5/register.php?submit=1&fname=%@&lname=%@&email=%@&company=%@&appname=Human Resources Suite", self.fnameTF.text, self.lnameTF.text, self.emailTF.text, self.companyTF.text] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	NSString *result;
	
	@try {
		NSError *err = nil;
		NSURLRequest *request= [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
		NSHTTPURLResponse *urlResponse = nil;
		NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&err];
		result = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
		
	}
	@catch (NSException *exception) {
		NSLog(@"Exception %@", exception );
	}
	
	if ([result isEqualToString:@"1"]) {
		UIAlertView *registerSuccess = [[UIAlertView alloc] initWithTitle:@"Registration Submitted" message:@"An email containing login information will be sent shortly. Please follow the instructions in the email to continue. Thank You!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
		[registerSuccess show];
	}
	else
	{
		UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Registration Failed!" message:@"Due to network issue, your request was not processed. Please try again..." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
		[alert show];
	}
	
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == self.companyTF)
    {
        [UIView beginAnimations:@"TEMP" context:NULL];
        [UIView setAnimationDuration:0.4];;
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:self.view cache:YES];
        [self.view setFrame:CGRectMake(0, -70, self.view.frame.size.width, self.view.frame.size.height)];
        [UIView commitAnimations];
    }
    else if (textField == self.emailTF)
    {
        [UIView beginAnimations:@"TEMP" context:NULL];
        [UIView setAnimationDuration:0.4];;
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:self.view cache:YES];
        [self.view setFrame:CGRectMake(0, -100, self.view.frame.size.width, self.view.frame.size.height)];
        [UIView commitAnimations];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == self.emailTF || textField == self.companyTF)
    {
        [UIView beginAnimations:@"TEMP" context:NULL];
        [UIView setAnimationDuration:0.4];;
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:self.view cache:YES];
        [self.view setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        [UIView commitAnimations];
    }
	
	if (textField == self.emailTF && self.emailTF.text.length > 0) {
		[self.submitButton setEnabled:YES];
        if([self emailValidation:self.emailTF.text] == 0) { //Wrong email format
			UIAlertView	*alertEmail = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"Wrong email format" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertEmail show];
			[self.submitButton setEnabled:NO];
        }
	}

}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    
	if (textField == self.lnameTF) {
		[self.companyTF becomeFirstResponder];
	}
	[textField resignFirstResponder];
	
    return YES;
}

- (BOOL) emailValidation: (NSString *) emailToValidate {
    if ([emailToValidate length] == 0) {
        return NO;
    }
    NSString *regexForEmailAddress = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailValidation = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regexForEmailAddress];
    return [emailValidation evaluateWithObject:emailToValidate];
}

- (void)viewDidUnload {
    [self setNavbar:nil];
    [self setGoBack:nil];
    [self setInstructionLabel:nil];
    [self setBottomBar:nil];
    [super viewDidUnload];
}
- (IBAction)goBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
