//
//  HistoryViewController.m
//  Timesheet
//
//  Created by Andrew Furusawa on 8/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HistoryViewController.h"
#import "TSHistoryCell.h"
#import "LRHistoryCell.h"
#import "AppDelegate.h"
#import "TimesheetDate.h"

#import "TSHistory.h"
#import "LRHistory.h"

#import "HR_SuiteTimesheet.h"
#import "HR_SuiteTimesheetApprovals.h"
#import "HR_SuiteLeaveRequests.h"
#import "HR_SuiteHR_SuiteDB.h"


@implementation HistoryViewController
{
    AppDelegate *d;
    TSHistory *tsh;
    LRHistory *lrh;
}
@synthesize segmentBar, navbar;



- (void)viewDidAppear:(BOOL)animated
{
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [LoadingScreen startLoadingScreenWithView:self.view];
    if (d.isSUPConnection) {
        [HR_SuiteHR_SuiteDB  synchronizeWithListener:self];
    }
    [LoadingScreen stopLoadingScreenWithView:self.view];
}

/****************************************************************************************************
 View Did Load
 ****************************************************************************************************/
- (void)viewDidLoad
{
    // Initializations
    d = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    //navbar title bg
    [navbar setBackgroundImage:[UIImage imageNamed:@"ts.topappbar-bg.png"] forBarMetrics:UIBarMetricsDefault];
    
    //bg
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"ts-bg-bg.png"]]];
    //[segmentBar setImage:[UIImage imageNamed:@"ts-history-timesheets-btn-down.png"] forSegmentAtIndex:0];
    
    [[UISegmentedControl appearance] setBackgroundImage:[UIImage imageNamed:@"ts-history-segment-bg.png"] forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
    [[UISegmentedControl appearance] setBackgroundImage:[UIImage imageNamed:@"ts-history-segment-bg.png"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    UIImage *divider = [UIImage imageNamed:@"ts-divider.png"];
    [[UISegmentedControl appearance] setDividerImage:divider forLeftSegmentState:UIControlStateSelected rightSegmentState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    [segmentBar setBackgroundColor:[UIColor clearColor]];
    [segmentBar setHighlighted:NO];
    
    [segmentBar setImage:[UIImage imageNamed:@"ts-history-timesheets-btn-down.png"] forSegmentAtIndex:0];
    
    // timesheet history view
    tsh = [self.storyboard instantiateViewControllerWithIdentifier:@"TSHistory"];
    //set view for iphone 4 or 5
    NSLog(@"size = %f", self.view.frame.size.height);
    if (self.view.frame.size.height > 460) { //iphone5
        tsh.view.frame = CGRectMake(0, 83, 320, 416);
    }
    else {
        tsh.view.frame = CGRectMake(0, 83, 320, 324);
    }
    [self.view addSubview:tsh.view];
    
    // leave request view
    lrh = [self.storyboard instantiateViewControllerWithIdentifier:@"LRHistory"];
    if (self.view.frame.size.height > 460) { //iphone5
        lrh.view.frame = CGRectMake(0, 83, 320, 416);
    }
    else {
        lrh.view.frame = CGRectMake(0, 83, 320, 324);
    }
    [self.view addSubview:lrh.view];
    lrh.view.hidden = YES;
}



- (void)viewDidUnload
{
    [self setNavbar:nil];
    [self setSegmentBar:nil];
    
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (IBAction)segmentPressed:(id)sender 
{
UISegmentedControl *segmentedControl = (UISegmentedControl *) sender;
NSInteger selectedSegment = segmentedControl.selectedSegmentIndex;
    
    if (selectedSegment == 0) {
        //toggle the correct view to be visible
        tsh.view.hidden = NO;
        lrh.view.hidden = YES;
        [segmentBar setImage:[UIImage imageNamed:@"ts-history-timesheets-btn-down.png"] forSegmentAtIndex:0];
        [segmentBar setImage:[UIImage imageNamed:@"ts-history-leaverequests-btn-up.png"] forSegmentAtIndex:1];
    }
    else{
        //toggle the correct view to be visible
        tsh.view.hidden = YES;
        lrh.view.hidden = NO;
        [segmentBar setImage:[UIImage imageNamed:@"ts-history-timesheets-btn-up.png"] forSegmentAtIndex:0];
        [segmentBar setImage:[UIImage imageNamed:@"ts-history-leaverequests-btn-down.png"] forSegmentAtIndex:1];
    }
}

- (IBAction)goBack:(id)sender {
    [self.parentViewController.navigationController popViewControllerAnimated:YES];
}


@end
