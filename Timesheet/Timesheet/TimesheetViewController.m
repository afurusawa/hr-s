//
//  TimesheetViewController.m
//  Timesheet
//
//  Created by Andrew Furusawa on 7/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TimesheetViewController.h"
#import "AppDelegate.h"
#import "HR_SuiteUsers.h"
#import "SUPQuery.h"

@implementation TimesheetViewController
{
    AppDelegate *d;
    HR_SuiteUsersList *SUPUsers;
}
@synthesize notificationTable;
@synthesize MTimesheets;
@synthesize MLeaveRequests;
@synthesize MJobManager;
@synthesize MSettings;
@synthesize MHistory;

@synthesize UTimeEntry;
@synthesize ULeaveRequests;
@synthesize UHistory;
@synthesize USettings;

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    d = (AppDelegate *)[[UIApplication sharedApplication] delegate]; //initialize
    
    /**********************/
    /*   SUP Connection   */
    /**********************/
    if (d.isSUPConnection) {

        SUPUsers = [HR_SuiteUsers findAll]; //load from SUP.
        
        if ([SUPUsers length] > 0) {
            
            BOOL isManager = NO;
            for (HR_SuiteUsers *supItem in SUPUsers) {
                
                //If the user is a manager, display the manager view.
                if ([supItem.manager isEqualToString:d.user]) {
                    isManager = YES;
                    d.manager = 1;
                }
            }
            
            if (isManager) {
                UTimeEntry.hidden = YES;
                ULeaveRequests.hidden = YES;
                UHistory.hidden = YES;
                //USettings.hidden = YES;
                
                MTimesheets.hidden = NO;
                MLeaveRequests.hidden = NO;
                MJobManager.hidden = NO;
                //MSettings.hidden = NO;
                MHistory.hidden = NO;
            }
            else {
                UTimeEntry.hidden = NO;
                ULeaveRequests.hidden = NO;
                UHistory.hidden = NO;
                //USettings.hidden = NO;
                
                MTimesheets.hidden = YES;
                MLeaveRequests.hidden = YES;
                MJobManager.hidden = YES;
                //MSettings.hidden = YES;
                MHistory.hidden = YES;
            }
        }
    } //end sup
    
    
    /************/
    /*   DEMO   */
    /************/
    else {
        if ([d.user isEqualToString:@"manager"]) {
            UTimeEntry.hidden = YES;
            ULeaveRequests.hidden = YES;
            UHistory.hidden = YES;
            //USettings.hidden = YES;
            
            MTimesheets.hidden = NO;
            MLeaveRequests.hidden = NO;
            MJobManager.hidden = NO;
            //MSettings.hidden = NO;
            MHistory.hidden = NO;
        }
        else {
            UTimeEntry.hidden = NO;
            ULeaveRequests.hidden = NO;
            UHistory.hidden = NO;
            //USettings.hidden = NO;
            
            MTimesheets.hidden = YES;
            MLeaveRequests.hidden = YES;
            MJobManager.hidden = YES;
            //MSettings.hidden = YES;
            MHistory.hidden = YES;
        }
    } //end demo
    
}

- (void)viewDidUnload
{
    [self setMTimesheets:nil];
    [self setMLeaveRequests:nil];
    [self setMJobManager:nil];
    [self setUTimeEntry:nil];
    [self setULeaveRequests:nil];
    [self setUHistory:nil];
    [self setUSettings:nil];
    [self setMSettings:nil];
    [self setNotificationTable:nil];
    [self setMHistory:nil];
    [super viewDidUnload];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}


- (IBAction)timeEntry:(id)sender {
    d.weekView = @"current"; //sets the status as the current time entry view.
    [self performSegueWithIdentifier:@"toTimeEntry" sender:self];
}
@end
