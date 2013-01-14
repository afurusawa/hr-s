//
//  HomeViewController.m
//  Timesheet
//
//  Created by Andrew Furusawa on 7/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HomeViewController.h"
#import "HR_SuiteUsers.h"
#import "SUPQuery.h"
#import "AppDelegate.h"
#import "JMC.h"

@implementation HomeViewController
{
    AppDelegate *d;
}
@synthesize navbar, mainView;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    d = (AppDelegate *)[[UIApplication sharedApplication] delegate];

    //navbar title bg
    [navbar setBackgroundImage:[UIImage imageNamed:@"ts.topappbar-bg.png"] forBarMetrics:UIBarMetricsDefault];
    
    //bg
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"ts-bg-bg.png"]]];
    
    RCToast *t = [[RCToast alloc] init];
    [t showToastInView:self.view withMessage:@"Login successful!"];
    
    //set view for iphone 4 or 5
    //NSLog(@"size = %f", self.view.frame.size.height);
    if (self.view.frame.size.height > 460) { //iphone5
        [mainView setCenter:CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2)];
    }
    [mainView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"ts-bg-bg.png"]]];
}


- (void)viewDidUnload
{
    [self setNavbar:nil];
    [self setMainView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)logout:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)openHRDirectory:(id)sender
{
    
    NSString *segueIdentifier;
    
    segueIdentifier = (d.isSUPConnection) ? @"onlineHRDSegue" : @"offlineHRDSegue";

    d.isManager = (d.isSUPConnection) ? [self isAManagerSUP] : [self isAManagerOffline];
    
    [self performSegueWithIdentifier:segueIdentifier sender:self];
}

- (IBAction)toTimesheet:(id)sender {

    // SUP version
    if (d.isSUPConnection) {
        HR_SuiteUsersList *list = [HR_SuiteUsers findAll]; //load from SUP.
        if ([list length] > 0) {
            
            BOOL isManager = NO;
            d.manager = 0;
            for (HR_SuiteUsers *supItem in list) {
                
                //If the user is a manager, display the manager view.
                if ([supItem.manager isEqualToString:d.user]) {
                    isManager = YES;
                    d.manager = 1;
                }
            }
            
            if (isManager) {
                [self performSegueWithIdentifier:@"toManager" sender:self];
            }
            else {
                [self performSegueWithIdentifier:@"toUser" sender:self];
            }
        }
    }
    
    // Demo version
    else {
        d.manager = 0;
        for (NSDictionary *item in d.hr_users) {
            if ([[item objectForKey:@"manager"] isEqualToString:d.user]) {
                d.manager = 1;
            }
        }
        if (d.manager) {
            [self performSegueWithIdentifier:@"toManager" sender:self];
        }
        else {
            [self performSegueWithIdentifier:@"toUser" sender:self];
        }
    }
}

-(BOOL)isAManagerSUP
{
    HR_SuiteUsersList *users = [HR_SuiteUsers findAll];
    
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    for(HR_SuiteUsers *person in users)
    {
        if([person.manager isEqualToString:appDelegate.user])
        {
            return YES;
        }
    }
    return NO;
}

-(BOOL)isAManagerOffline
{
    AppDelegate *data = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSString *employee = data.user;
    
    for(NSDictionary *user in data.hr_users)
    {
        if([[user objectForKey:@"manager"] isEqualToString:employee])
        {
            return YES;
        }
    }
    return NO;
}




- (IBAction)reportBug:(id)sender {
    [self presentModalViewController:[[JMC sharedInstance] feedbackViewController] animated:YES];
}
@end
