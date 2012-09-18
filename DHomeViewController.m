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
    
    isManager = [self isAManager];
    self.btnAddEmployee.enabled = NO;
    
    if(isManager)
    {
        //[self.btnAddEmployee titleLabel].textColor = [UIColor blackColor];
        self.btnAddEmployee.enabled = YES;
        CALayer *layer = self.btnAddEmployee.layer;
        layer.opacity = .50;
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
