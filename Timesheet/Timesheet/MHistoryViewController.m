//
//  MHistoryViewController.m
//  Timesheet
//
//  Created by Rapid Consulting on 8/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MHistoryViewController.h"
#import "AppDelegate.h"
#import "TimesheetDate.h"
#import "MHistoryCell.h"

#import "MLRHistory.h"
#import "MTSHistory.h"

#import "HR_SuiteTimesheetApprovals.h"
#import "HR_SuiteLeaveRequests.h"
#import "HR_SuiteUsers.h"
#import "HR_SuiteHR_SuiteDB.h"

@interface MHistoryViewController ()

@end

@implementation MHistoryViewController
{
    AppDelegate *d;
//    TimesheetDate *tsDate;
//    NSMutableArray *historyList;
//    NSMutableArray *sortedList;
//    NSDictionary *entry;
    
    MTSHistory *mtsh;
    MLRHistory *mlrh;
}
@synthesize historyTable, navbar, segmentBar;

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
    d = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    tsDate = [[TimesheetDate alloc] init];
//    historyList = [[NSMutableArray alloc] init];
//    sortedList  = [[NSMutableArray alloc] init];
//    entry = [[NSDictionary alloc] init];
    
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
    
    mtsh = [self.storyboard instantiateViewControllerWithIdentifier:@"MTSHistory"];
    if (self.view.frame.size.height > 460) { //iphone5
        mtsh.view.frame = CGRectMake(0, 83, 320, 416);
    }
    else {
        mtsh.view.frame = CGRectMake(0, 83, 320, 324);
    }
    [self.view addSubview:mtsh.view];
    
    mlrh = [self.storyboard instantiateViewControllerWithIdentifier:@"MLRHistory"];
    if (self.view.frame.size.height > 460) { //iphone5
        mlrh.view.frame = CGRectMake(0, 83, 320, 416);
    }
    else {
        mlrh.view.frame = CGRectMake(0, 83, 320, 324);
    }
    [self.view addSubview:mlrh.view];
    mlrh.view.hidden = YES;
    
//
//
//    
//    
//    /**********************/
//    /*   SUP Connection   */
//    /**********************/
//    if (d.isSUPConnection) {
//        
//        HR_SuiteLeaveRequestsList *lrList = [HR_SuiteLeaveRequests findAll];
//        for (HR_SuiteLeaveRequests *lrItem in lrList) {
//            
//            // Get only team members
//            HR_SuiteUsersList *uList = [HR_SuiteUsers findAll];
//            for (HR_SuiteUsers *uItem in uList) {
//                
//                // If item is an approved or denied entry, add it to the history list
//                if ([uItem.manager isEqualToString:d.user] && 
//                    [lrItem.employeeID isEqualToString:uItem.employeeID] && 
//                    ([lrItem.signCode isEqualToNumber:[NSNumber numberWithInt:99]] || [lrItem.signCode isEqualToNumber:[NSNumber numberWithInt:100]])
//                    ) {
//                    
//                    entry = [NSDictionary dictionaryWithObjectsAndKeys:[lrItem.signCode stringValue], @"status", @"Leave Request", @"submissionType", uItem.employeeName, @"employeeName", lrItem.timestamp, @"timestamp", nil];
//                    [historyList addObject:entry];
//                }
//            }
//        } //end for
//        
//        HR_SuiteTimesheetApprovalsList *tsaList = [HR_SuiteTimesheetApprovals findAll];
//        if ([tsaList length] > 0) {
//            for (HR_SuiteTimesheetApprovals *tsaItem in tsaList) {
//                
//                // Get only team members
//                HR_SuiteUsersList *uList = [HR_SuiteUsers findAll];
//                for (HR_SuiteUsers *uItem in uList) {
//                    
//                    if ([uItem.manager isEqualToString:d.user] && 
//                        [tsaItem.employeeID isEqualToString:uItem.employeeID] && 
//                        ([tsaItem.signCode isEqualToNumber:[NSNumber numberWithInt:99]] || [tsaItem.signCode isEqualToNumber:[NSNumber numberWithInt:100]])
//                        ) {
//                        
//                        entry = [NSDictionary dictionaryWithObjectsAndKeys:[tsaItem.signCode stringValue], @"status", @"Timesheet", @"submissionType", uItem.employeeName, @"employeeName", tsaItem.timestamp, @"timestamp", nil];
//                        [historyList addObject:entry];
//                    }
//                }
//            }
//        } //end if
//        
//        // Sort by timestamp
//        sortedList = [self sortMostRecent:historyList];
//        
//    } //end sup
//    
//    
//    /**********************/
//    /*   Demo             */
//    /**********************/
//    else {
//        for (NSDictionary *item in d.hr_approvals) {
//            if ([[item objectForKey:@"manager"] isEqualToString:d.user] && ([[item objectForKey:@"signCode"] isEqualToString:@"99"] || [[item objectForKey:@"signCode"] isEqualToString:@"100"])) {
//                entry = [NSDictionary dictionaryWithObjectsAndKeys:
//                         [item objectForKey:@"signCode"], @"status",
//                         @"Timesheet", @"submissionType", 
//                         [item objectForKey:@"employeeName"], @"employeeName", 
//                         [item objectForKey:@"timestamp"], @"timestamp", 
//                         nil];
//                [historyList addObject:entry];
//            }
//        }
//        for (NSDictionary *item2 in d.hr_leaverequests) {
//            NSLog(@" sign %@",[item2 objectForKey:@"signCode"]);
//            if ([[item2 objectForKey:@"manager"] isEqualToString:d.user] && ([[item2 objectForKey:@"signCode"] isEqualToString:@"99"] || [[item2 objectForKey:@"signCode"] isEqualToString:@"100"])) {
//                entry = [NSDictionary dictionaryWithObjectsAndKeys:
//                         [item2 objectForKey:@"signCode"], @"status",
//                         @"Leave Request", @"submissionType", 
//                         [item2 objectForKey:@"employeeName"], @"employeeName", 
//                         [item2 objectForKey:@"timestamp"], @"timestamp", 
//                         nil];
//                [historyList addObject:entry];
//            }
//        }
//        sortedList = [self sortMostRecent:historyList];
//    } //end demo
//    
    
}

- (void)viewDidUnload
{
    [self setHistoryTable:nil];
    [self setNavbar:nil];
    [self setSegmentBar:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
//
//
///****************************************************************************************************
// Table View
// ****************************************************************************************************/
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return [sortedList count];
//}
//
//
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *CellIdentifier = @"MHistoryCell";
//    MHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    
//    // Configure the cell...
//    NSString *status = [[sortedList objectAtIndex:indexPath.row] objectForKey:@"status"];
//    if([status isEqualToString:@"99"]) {
//        status = @"Denied";
//    }
//    else if([status isEqualToString:@"100"]) {
//        status = @"Approved";
//    }
//    
//    NSString *details;
//    // iPhone version
//    if (tableView.tag == 2) {
//        NSString *st = [[sortedList objectAtIndex:indexPath.row] objectForKey:@"submissionType"];
//        NSString *en = [[sortedList objectAtIndex:indexPath.row] objectForKey:@"employeeName"];
//        //NSString *ts = [[sortedList objectAtIndex:indexPath.row] objectForKey:@"timestamp"];
//        details = [NSString stringWithFormat:@"%@ from %@", st, en];
//    }
//    
//    // iPad version
//    else {
//        NSString *st = [[sortedList objectAtIndex:indexPath.row] objectForKey:@"submissionType"];
//        NSString *en = [[sortedList objectAtIndex:indexPath.row] objectForKey:@"employeeName"];
//        NSString *ts = [[sortedList objectAtIndex:indexPath.row] objectForKey:@"timestamp"];
//        details = [NSString stringWithFormat:@"%@ from %@ on %@", st, en, ts];
//    }
//    cell.statusLabel.text = status;
//    cell.detailsLabel.text = details;
//    
//    return cell;
//}
//
//
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    // Navigation logic may go here. Create and push another view controller.
//    /*
//     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
//     // ...
//     // Pass the selected object to the new view controller.
//     [self.navigationController pushViewController:detailViewController animated:YES];
//     */
//}
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
///****************************************************************************************************
// Merge Sort - Dividing Algorithm
// ****************************************************************************************************/
//- (NSMutableArray *)sortMostRecent:(NSMutableArray *)list {
//    if ([list count] <= 1) {
//        return list;
//    }
//    
//    NSMutableArray *left = [[NSMutableArray alloc] init];
//    NSMutableArray *right = [[NSMutableArray alloc] init];
//    NSInteger middle = [list count]/2;
//    
//    for (int i = 0; i < middle; i++) {
//        [left addObject:[list objectAtIndex:i]];
//    }
//    
//    for (int i = middle; i < [list count]; i++) {
//        [right addObject:[list objectAtIndex:i]];
//    }
//    
//    left = [self sortMostRecent:left];
//    right = [self sortMostRecent:right];
//    
//    return [self mergeLeft:left andRight:right];
//    
//}
//
///****************************************************************************************************
// Merge Sort - Merging Algorithm
// ****************************************************************************************************/
//- (NSMutableArray *)mergeLeft:(NSMutableArray *)left andRight:(NSMutableArray *)right {
//    
//    NSMutableArray *result = [[NSMutableArray alloc] init];
//    
//    while ([left count] > 0 || [right count] > 0) {
//        if ([left count] > 0 && [right count] > 0) {
//            
//            // If left is more recent than right, add left 
//            if ([tsDate compareTimestamp:[left objectAtIndex:0] isMoreRecentThan:[right objectAtIndex:0]]) {
//                [result addObject:[left objectAtIndex:0]];
//                [left removeObjectAtIndex:0];
//            }
//            else {
//                [result addObject:[right objectAtIndex:0]];
//                [right removeObjectAtIndex:0];
//            }
//        }
//        
//        else if ([left count] > 0) {
//            [result addObject:[left objectAtIndex:0]];
//            [left removeObjectAtIndex:0];
//        }
//        
//        else if ([right count] > 0) {
//            [result addObject:[right objectAtIndex:0]];
//            [right removeObjectAtIndex:0];
//        }
//    }
//    
//    return result;
//}
//

- (IBAction)segmentPressed:(id)sender {
    UISegmentedControl *segmentedControl = (UISegmentedControl *) sender;
    NSInteger selectedSegment = segmentedControl.selectedSegmentIndex;
    
    if (selectedSegment == 0) {
        //toggle the correct view to be visible
        mtsh.view.hidden = NO;
        mlrh.view.hidden = YES;
        [segmentBar setImage:[UIImage imageNamed:@"ts-history-timesheets-btn-down.png"] forSegmentAtIndex:0];
        [segmentBar setImage:[UIImage imageNamed:@"ts-history-leaverequests-btn-up.png"] forSegmentAtIndex:1];
    }
    else{
        //toggle the correct view to be visible
        mtsh.view.hidden = YES;
        mlrh.view.hidden = NO;
        [segmentBar setImage:[UIImage imageNamed:@"ts-history-timesheets-btn-up.png"] forSegmentAtIndex:0];
        [segmentBar setImage:[UIImage imageNamed:@"ts-history-leaverequests-btn-down.png"] forSegmentAtIndex:1];
    }

}

- (IBAction)goBack:(id)sender {
    [self.parentViewController.navigationController popViewControllerAnimated:YES];
}

#pragma mark - SUPSyncStatusListener

-(void)onGetSyncStatusChange:(SUPSyncStatusInfo*)info
{
    
}

@end
