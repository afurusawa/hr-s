//
//  HistoryViewController.m
//  Timesheet
//
//  Created by Andrew Furusawa on 8/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HistoryViewController.h"
#import "HistoryCell.h"
#import "LRHistoryCell.h"
#import "AppDelegate.h"
#import "TimesheetDate.h"

#import "HR_SuiteTimesheet.h"
#import "HR_SuiteTimesheetApprovals.h"
#import "HR_SuiteLeaveRequests.h"
#import "HR_SuiteHR_SuiteDB.h"

@implementation HistoryViewController
{
    AppDelegate *d;
    TimesheetDate *tsDate;

    NSMutableArray *historyList;    //list to display.
    NSMutableArray *weeksList;    //list containing all weeks.
    NSMutableArray *lrList;
    
    NSString *currentDate;
}
@synthesize historyTable;
@synthesize lrhistoryTable;
@synthesize segmentBar;



- (void)viewDidAppear:(BOOL)animated
{
    [self viewDidLoad];
    [self.historyTable reloadData];
}


/****************************************************************************************************
 View Did Load
 ****************************************************************************************************/
- (void)viewDidLoad
{
    // Initializations
    d = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    tsDate = [[TimesheetDate alloc] init];
    
    d.HISTORY_SIZE = 10;
    
    // Initialize arrays
    weeksList = [[NSMutableArray alloc] init];
    historyList = [[NSMutableArray alloc] init];
    lrList = [[NSMutableArray alloc] init];

    //get today's day
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];  
    [dateFormatter setDateFormat:@"EEEE"];
    NSString *today = [dateFormatter stringFromDate:[NSDate date]];
    
    //get today's date components
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:[NSDate date]];
    NSInteger day = [components day];
    NSInteger month = [components month];
    NSInteger year = [components year];
    
    //get monday's date for this week
    NSString *mondaysDate = @"";
    if([today isEqualToString:@"Monday"]) {
        mondaysDate = [NSString stringWithFormat:@"%i/%i/%i", month, day, year];
    }
    else if([today isEqualToString:@"Tuesday"]) {
        mondaysDate = [tsDate getDate:month day:day-1 year:year];
    }
    else if([today isEqualToString:@"Wednesday"]) {
        mondaysDate = [tsDate getDate:month day:day-2 year:year];
    }
    else if([today isEqualToString:@"Thursday"]) {
        mondaysDate = [tsDate getDate:month day:day-3 year:year];
    }
    else if([today isEqualToString:@"Friday"]) {
        mondaysDate = [tsDate getDate:month day:day-4 year:year];
    }
    else if([today isEqualToString:@"Saturday"]) {
        mondaysDate = [tsDate getDate:month day:day-5 year:year];
    }
    else if([today isEqualToString:@"Sunday"]) {
        mondaysDate = [tsDate getDate:month day:day-6 year:year];
    }
    
    //add this monday.
    //[weeksList addObject:mondaysDate];
    
    // Separate the date for that monday to calculate--by reference--all previous mondays.
    NSArray *temp = [mondaysDate componentsSeparatedByString:@"/"]; //index 0=month 1=day 2=year
    month = [[temp objectAtIndex:0] intValue];
    day = [[temp objectAtIndex:1] intValue];
    year = [[temp objectAtIndex:2] intValue];
    
    //Add the previous X monday dates.
    for (int i = 0; i < d.HISTORY_SIZE; i++) {
        
        //recalculate the previous monday and separate components.
        currentDate = [tsDate getDate:month day:day-7 year:year]; //store the current date
        NSArray *temp = [currentDate componentsSeparatedByString:@"/"]; //index 0=month 1=day 2=year
        month = [[temp objectAtIndex:0] intValue];
        day = [[temp objectAtIndex:1] intValue];
        year = [[temp objectAtIndex:2] intValue];
        
        //store each previous monday into array.
        [weeksList addObject:currentDate];                     
    }
    //NSLog(@"here is the array \n %@", weeksList);
    
    /**********************/
    /*   SUP Connection   */
    /**********************/
    if (d.isSUPConnection) {
        // Populate leave request array
        lrList = [[NSMutableArray alloc] init];
        HR_SuiteLeaveRequestsList *list = [HR_SuiteLeaveRequests findAll];
        for (HR_SuiteLeaveRequests *item in list) {
            if ([item.employeeID isEqualToString:d.user]) {
                [lrList addObject:item];
            }
        }
    } //end sup
    
    
    /**********************/
    /*   Demo             */
    /**********************/
    else {
        lrList = [[NSMutableArray alloc] init];
        
        for (NSDictionary *item in d.hr_leaverequests) {
            if ([[item objectForKey:@"employeeID"] isEqualToString:d.user]) {
                [lrList addObject:item];
            }
        }
    } //end demo
    
    [self.lrhistoryTable reloadData];
}



- (void)viewDidUnload
{
    [self setSegmentBar:nil];
    [self setLrhistoryTable:nil];
    [self setHistoryTable:nil];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}



/****************************************************************************************************
 Table View
 ****************************************************************************************************/
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Timesheets Tab
    if (tableView == historyTable) {
        //NSLog(@"size of history table: %i", [weeksList count]);
        return [weeksList count]-1;
    }
    
    // Leave Requests Tab
    else if (tableView == lrhistoryTable) {
        
        /**********************/
        /*   SUP Connection   */
        /**********************/
        if (d.isSUPConnection) {
            NSInteger count = 0;
            HR_SuiteLeaveRequestsList *list = [HR_SuiteLeaveRequests findAll];
            for (HR_SuiteLeaveRequests *item in list) {
                if ([item.employeeID isEqualToString:d.user]) {
                    count++;
                }
            }
            return count; 
        } //end sup
        
        
        /**********************/
        /*   Demo             */
        /**********************/
        else {
            return [lrList count];
        } //end demo
        
    }
    return 0;    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{   
    UITableViewCell *resultcell;
    
    // Timesheets Tab
    if (tableView.tag == 1) {
        static NSString *CellIdentifier = @"HistoryCell";
        HistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        /**********************/
        /*   SUP Connection   */
        /**********************/
        if (d.isSUPConnection) {
            HR_SuiteTimesheetApprovalsList *list = [HR_SuiteTimesheetApprovals findAll];
            if ([list length] == 0) {
                return nil;
            }
            
            // For each cell, get status, notes
            NSInteger signCode = 0;
            NSString *managerNotes;
            for (HR_SuiteTimesheetApprovals *item in list) {
                if ([d.user isEqualToString:item.employeeID] && [[weeksList objectAtIndex:indexPath.row] isEqualToString:item.date]) {
                    signCode = [item.signCode intValue];
                    
                    managerNotes = item.managerNotes;
                    
                    //Set the sign code
                    if(signCode == 0) {
                        cell.status.text = [NSString stringWithFormat:@"Status: Not yet submitted"];
                    }
                    else if(signCode == 1) {
                        cell.status.text = @"Status: Waiting for approval";
                        cell.status.textColor = [UIColor orangeColor];
                    }
                    else if(signCode == 100) {
                        cell.status.text = @"Status: Approved";
                        cell.status.textColor = [UIColor colorWithRed:8.0f/255.0f green:190.0f/255.0f blue:45.0f/255.0f alpha:1.0f];
                    }
                    else if(signCode == 99) {
                        cell.status.text = @"Status: Denied";
                        cell.status.textColor = [UIColor redColor];
                    }
                    
                    //Set Managers note
                    cell.managersNote.text = managerNotes;
                    
                    break;
                }
            }
            
            //Get total hours for current week and get sign status for current week.
            HR_SuiteTimesheetList *list2 = [HR_SuiteTimesheet findByEmployeeIDandDate:d.user withDate:[weeksList objectAtIndex:indexPath.row]];
            
            //Get total hours
            NSInteger totalHours = 0;
            for (HR_SuiteTimesheet *item in list2) {
                totalHours += [item.hours intValue];
            }
            
            //Update the table with values
            
            //Calculate and set span of the week from monday to sunday.
            NSString *begin = [weeksList objectAtIndex:indexPath.row]; //store monday
            NSArray *temp = [begin componentsSeparatedByString:@"/"]; //split monday >> index 0=month 1=day 2=year
            NSInteger month = [[temp objectAtIndex:0] intValue];
            NSInteger day = [[temp objectAtIndex:1] intValue];
            NSInteger year = [[temp objectAtIndex:2] intValue];
            NSString *end = [tsDate getDate:month day:day+6 year:year]; //store sunday
            cell.date.text = [NSString stringWithFormat:@"%@ to %@", begin, end]; //from monday to sunday
            
            //Set the total hours
            if(totalHours == 0) {
                cell.hours.text = [NSString stringWithFormat:@"Total Hours: 0"];
            }
            else {
                cell.hours.text = [NSString stringWithFormat:@"Total Hours: %i", totalHours];
            }
        } //end sup
        
        /**********************/
        /*   Demo             */
        /**********************/
        else {

            // Set all week spans
            NSString *begin = [weeksList objectAtIndex:indexPath.row]; //store monday
            NSArray *temp = [begin componentsSeparatedByString:@"/"]; //split monday >> index 0=month 1=day 2=year
            NSInteger month = [[temp objectAtIndex:0] intValue];
            NSInteger day = [[temp objectAtIndex:1] intValue];
            NSInteger year = [[temp objectAtIndex:2] intValue];
            NSString *end = [tsDate getDate:month day:day+6 year:year]; //store sunday
            cell.date.text = [NSString stringWithFormat:@"%@ to %@", begin, end]; //from monday to sunday
            //NSLog(@"row = %i, for week %@", indexPath.row, cell.date.text);
            
            // Calculate total hours for each week
            NSInteger totalhours = 0;
            for (NSDictionary *item in d.HR_Suite) {
                
                BOOL isUser = [[item objectForKey:@"employeeID"] isEqualToString:d.user];
                BOOL isDate = [[item objectForKey:@"date"] isEqualToString:[weeksList objectAtIndex:indexPath.row]];
                
                // Case 2.1: Info exists for date -> then update the info
                if (isUser && isDate) { 
                    totalhours += [[item objectForKey:@"hours"] intValue];
                }
            }
            
            //Set the total hours
            if(totalhours == 0) {
                cell.hours.text = [NSString stringWithFormat:@"Total Hours: 0"];
            }
            else {
                cell.hours.text = [NSString stringWithFormat:@"Total Hours: %i", totalhours];
            }
            
            
            // Populate data from approvals
            for (int b = 0; b < [d.hr_approvals count]; b++) {
                
                BOOL isUser = [d.user isEqualToString:[[d.hr_approvals objectAtIndex:b] objectForKey:@"employeeID"]];
                BOOL isDate = [[weeksList objectAtIndex:indexPath.row] isEqualToString:[[d.hr_approvals objectAtIndex:b] objectForKey:@"date"]];
                
                // Case 2.1: Info exists for date -> then update the info
                if (isUser && isDate) { 
                    
                    
                    NSInteger signCode = [[[d.hr_approvals objectAtIndex:b] objectForKey:@"signCode"] intValue];
                    //NSLog(@" sign code for passed: %i for row == %i ", signCode, indexPath.row);
                    //Set the sign code
                    if(signCode == 0) {
                        cell.status.text = [NSString stringWithFormat:@"Status: Not yet submitted"];
                    }
                    else if(signCode == 1) {
                        cell.status.text = @"Status: Waiting for approval";
                        cell.status.textColor = [UIColor orangeColor];
                        cell.managersNote.text = @"";
                    }
                    else if(signCode == 100) {
                        cell.status.text = @"Status: Approved";
                        cell.status.textColor = [UIColor colorWithRed:8.0f/255.0f green:190.0f/255.0f blue:45.0f/255.0f alpha:1.0f];
                        cell.managersNote.text = [[d.hr_approvals objectAtIndex:b] objectForKey:@"managerNotes"];
                    }
                    else if(signCode == 99) {
                        cell.status.text = @"Status: Denied";
                        cell.status.textColor = [UIColor redColor];
                        cell.managersNote.text = [[d.hr_approvals objectAtIndex:b] objectForKey:@"managerNotes"];
                    }
                }
                
     
                   
      
            } //for
        } //else
        
        resultcell = cell;
    }
    
    
    
    // Leave Requests Tab
    else if (tableView.tag == 2) {
        static NSString *CellIdentifier = @"LRHistoryCell";
        LRHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier]; 
        
        /**********************/
        /*   SUP Connection   */
        /**********************/
        if (d.isSUPConnection) {
            
            HR_SuiteLeaveRequests *item = [lrList objectAtIndex:indexPath.row];
            
            // Set date
            cell.date.text = [NSString stringWithFormat:@"%@ to %@", item.startDate, item.endDate];
            
            // Set leave type
            cell.leaveType.text = [NSString stringWithFormat:@"%@", item.leaveType];
            
            // Set reason
            cell.reason.text = [NSString stringWithFormat:@"Reason: %@", item.reason];
            
            //Set the sign code
            NSInteger signCode = [item.signCode intValue];
            if(signCode == 99) {
                cell.status.text = [NSString stringWithFormat:@"Status: Denied"];
            }
            else if(signCode == 0) {
                cell.status.text = @"Status: Waiting for approval";
                cell.status.textColor = [UIColor orangeColor];
            }
            else if(signCode == 100) {
                cell.status.text = @"Status: Approved";
                cell.status.textColor = [UIColor colorWithRed:8.0f/255.0f green:190.0f/255.0f blue:45.0f/255.0f alpha:1.0f];
            }
            
            // Set managers note
            cell.managersNote.text = item.managerNotes;
            
        } //end sup
        
        
        /**********************/
        /*   Demo             */
        /**********************/
        else {
            //NSLog(@"size of lrlist: %i", [lrList count]);
            cell.date.text = [NSString stringWithFormat:@"%@ to %@", [[lrList objectAtIndex:indexPath.row] objectForKey:@"startDate"], [[lrList objectAtIndex:indexPath.row] objectForKey:@"endDate"]];
            cell.reason.text = [[lrList objectAtIndex:indexPath.row] objectForKey:@"reason"];
            cell.leaveType.text = [[lrList objectAtIndex:indexPath.row] objectForKey:@"leaveType"];
            
            //Set the sign code
            NSInteger signCode = [[[lrList objectAtIndex:indexPath.row] objectForKey:@"signCode"] intValue];
            if(signCode == 99) {
                cell.status.text = [NSString stringWithFormat:@"Status: Denied"];
                cell.managersNote.text = [[lrList objectAtIndex:indexPath.row] objectForKey:@"managerNotes"];
            }
            else if(signCode == 0) {
                cell.status.text = @"Status: Waiting for approval";
                cell.status.textColor = [UIColor orangeColor];
            }
            else if(signCode == 100) {
                cell.status.text = @"Status: Approved";
                cell.status.textColor = [UIColor colorWithRed:8.0f/255.0f green:190.0f/255.0f blue:45.0f/255.0f alpha:1.0f];
            }

        }
        
        resultcell = cell;
    }

    return resultcell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{    
    //Store date
    d.weekView = [weeksList objectAtIndex:indexPath.row];
    
    HistoryCell *cell = (HistoryCell *)[self.historyTable cellForRowAtIndexPath:indexPath];
    d.historyState = cell.status.text;
    
    //Perform segue
    [self performSegueWithIdentifier:@"toHistoryDetails" sender:self];    
}



- (IBAction)segmentPressed:(id)sender 
{
UISegmentedControl *segmentedControl = (UISegmentedControl *) sender;
NSInteger selectedSegment = segmentedControl.selectedSegmentIndex;
    
    if (selectedSegment == 0) {
        //toggle the correct view to be visible
        [historyTable setHidden:NO];
        [lrhistoryTable setHidden:YES];
    }
    else{
        //toggle the correct view to be visible
        [historyTable setHidden:YES];
        [lrhistoryTable setHidden:NO];
        [self.lrhistoryTable reloadData];
    }
    
}


@end
