//
//  DHomeViewController.m
//  Timesheet
//
//  Created by Rapid Consulting on 9/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "DHomeViewController.h"
#import "HR_SuiteUsers.h"
#import "AppDelegate.h"

@interface DHomeViewController ()

@end

@implementation DHomeViewController
@synthesize browseButton;
@synthesize btnAddEmployee;


- (void)viewDidLoad
{
    [super viewDidLoad];
    AppDelegate *appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    appDel.isManager = [self isAManager];
    isManager = [self isAManager];
    //self.btnAddEmployee.enabled = NO;
    
    if(!isManager)
    {
        //[self.btnAddFinishing up a navigation transition in an unexpected stateEmployee titleLabel].textColor = [UIColor blackColor];
        NSLog(@"Here");
        self.btnAddEmployee.enabled = NO;
        [self.btnAddEmployee setAlpha:.50];
    }
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [self setBrowseButton:nil];
    [self setBtnAddEmployee:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(BOOL)isAManager
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

@end
