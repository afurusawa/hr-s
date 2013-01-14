//
//  MLRHistory.m
//  Timesheet
//
//  Created by Andrew Furusawa on 12/3/12.
//
//

#import "MLRHistory.h"
#import "MLRHCell.h"
#import "AppDelegate.h"
#import "TimesheetDate.h"
#import "HR_SuiteLeaveRequests.h"
#import "HR_SuiteUsers.h"

@interface MLRHistory ()

@end

@implementation MLRHistory
{
    AppDelegate *d;
    TimesheetDate *tsDate;
    NSMutableArray *historyList;
    NSDictionary *entry;
    NSMutableArray *sortedList;
}
@synthesize htable;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    d = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    historyList = [[NSMutableArray alloc] initWithCapacity:1];
    sortedList = [[NSMutableArray alloc] initWithCapacity:1];
    
    
    //bg
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"ts-bg-bg.png"]]];
    
    //bg for table
    [htable setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"ts-bg-bg.png"]]];
    
    
    
    
    
    /**********************/
    /*   SUP Connection   */
    /**********************/
    if (d.isSUPConnection) {
        
        HR_SuiteLeaveRequestsList *lrList = [HR_SuiteLeaveRequests findAll];
        for (HR_SuiteLeaveRequests *lrItem in lrList) {
            
            // Get only team members
            HR_SuiteUsersList *uList = [HR_SuiteUsers findAll];
            for (HR_SuiteUsers *uItem in uList) {
                
                // If item is an approved or denied entry, add it to the history list
                if ([uItem.manager isEqualToString:d.user] &&
                    [lrItem.employeeID isEqualToString:uItem.employeeID] &&
                    ([lrItem.signCode isEqualToNumber:[NSNumber numberWithInt:99]] || [lrItem.signCode isEqualToNumber:[NSNumber numberWithInt:100]])
                    ) {
                    
                    entry = [NSDictionary dictionaryWithObjectsAndKeys:
                             [lrItem.signCode stringValue], @"status",
                             @"Leave Request", @"submissionType",
                             uItem.employeeName, @"employeeName",
                             lrItem.timestamp, @"timestamp",
                             lrItem.startDate, @"startDate",
                             lrItem.endDate, @"endDate",
                             lrItem.leaveType, @"type",
                             nil];
                    [historyList addObject:entry];
                }
            }
        } //end for
                // Sort by timestamp
        sortedList = [self sortMostRecent:historyList];
        
    } //end sup
    
    
    /**********************/
    /*   Demo             */
    /**********************/
    else {
        
        for (NSDictionary *item2 in d.hr_leaverequests) {
            NSLog(@" sign %@",[item2 objectForKey:@"signCode"]);
            if ([[item2 objectForKey:@"manager"] isEqualToString:d.user] && ([[item2 objectForKey:@"signCode"] isEqualToString:@"99"] || [[item2 objectForKey:@"signCode"] isEqualToString:@"100"])) {
                entry = [NSDictionary dictionaryWithObjectsAndKeys:
                         [item2 objectForKey:@"signCode"], @"status",
                         @"Leave Request", @"submissionType",
                         [item2 objectForKey:@"employeeName"], @"employeeName",
                         [item2 objectForKey:@"timestamp"], @"timestamp",
                         [item2 objectForKey:@"startDate"], @"startDate",
                         [item2 objectForKey:@"endDate"], @"endDate",
                         [item2 objectForKey:@"leaveType"], @"type",
                         nil];
                [historyList addObject:entry];
            }
        }
        sortedList = [self sortMostRecent:historyList];
    } //end demo
    
    

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setHtable:nil];
    [super viewDidUnload];
}




/****************************************************************************************************
 Table View
 ****************************************************************************************************/
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [sortedList count];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MLRHCell";
    MLRHCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
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
    
    // set fonts
    [cell.nameLabel setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:14]];
    [cell.periodLabel setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:16]];
    [cell.submittedLabel setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:16]];

    [cell.periodTextLabel setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:10]];
    [cell.submittedTextLabel setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:10]];
    [cell.typeLabel setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:10]];
    
    NSDictionary *item = [historyList objectAtIndex:indexPath.row];
    
    //name
    cell.nameLabel.text = [item objectForKey:@"employeeName"];
    
    //get timestamp
    NSString *timestamp = [item objectForKey:@"timestamp"];
    NSArray *a = [timestamp componentsSeparatedByString:@"/"];
    cell.submittedLabel.text = [NSString stringWithFormat:@"%@/%@", [a objectAtIndex:0], [a objectAtIndex:1]];
    
    //period
    NSString *sd = [item objectForKey:@"startDate"];
    NSArray *sda = [sd componentsSeparatedByString:@"/"];
    sd = [NSString stringWithFormat:@"%@/%@", [sda objectAtIndex:0], [sda objectAtIndex:1]];
    
    NSString *ed = [item objectForKey:@"endDate"];
    NSArray *eda = [sd componentsSeparatedByString:@"/"];
    ed = [NSString stringWithFormat:@"%@/%@", [eda objectAtIndex:0], [eda objectAtIndex:1]];
    
    cell.periodLabel.text = [NSString stringWithFormat:@"%@-%@", sd, ed];
    
    //type
    cell.typeLabel.text = [item objectForKey:@"type"];
    
    //status
    int status = [[item objectForKey:@"status"] intValue];
    
    //waiting (impossible in manager history)
    if (status==1) {
        [cell.statusImage setImage:[UIImage imageNamed:@"ts-history-status-waiting.png"]];
    }
    //reject
    else if(status==99) {
        [cell.statusImage setImage:[UIImage imageNamed:@"ts-history-status-denied.png"]];
    }
    //approve
    else if (status==100) {
        [cell.statusImage setImage:[UIImage imageNamed:@"ts-history-status-approved.png"]];
    }
    
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}



/****************************************************************************************************
 Merge Sort - Dividing Algorithm
 ****************************************************************************************************/
- (NSMutableArray *)sortMostRecent:(NSMutableArray *)list {
    if ([list count] <= 1) {
        return list;
    }
    
    NSMutableArray *left = [[NSMutableArray alloc] init];
    NSMutableArray *right = [[NSMutableArray alloc] init];
    NSInteger middle = [list count]/2;
    
    for (int i = 0; i < middle; i++) {
        [left addObject:[list objectAtIndex:i]];
    }
    
    for (int i = middle; i < [list count]; i++) {
        [right addObject:[list objectAtIndex:i]];
    }
    
    left = [self sortMostRecent:left];
    right = [self sortMostRecent:right];
    
    return [self mergeLeft:left andRight:right];
    
}

/****************************************************************************************************
 Merge Sort - Merging Algorithm
 ****************************************************************************************************/
- (NSMutableArray *)mergeLeft:(NSMutableArray *)left andRight:(NSMutableArray *)right {
    
    NSMutableArray *result = [[NSMutableArray alloc] init];
    
    while ([left count] > 0 || [right count] > 0) {
        if ([left count] > 0 && [right count] > 0) {
            
            // If left is more recent than right, add left
            if ([tsDate compareTimestamp:[left objectAtIndex:0] isMoreRecentThan:[right objectAtIndex:0]]) {
                [result addObject:[left objectAtIndex:0]];
                [left removeObjectAtIndex:0];
            }
            else {
                [result addObject:[right objectAtIndex:0]];
                [right removeObjectAtIndex:0];
            }
        }
        
        else if ([left count] > 0) {
            [result addObject:[left objectAtIndex:0]];
            [left removeObjectAtIndex:0];
        }
        
        else if ([right count] > 0) {
            [result addObject:[right objectAtIndex:0]];
            [right removeObjectAtIndex:0];
        }
    }
    
    return result;
}


- (NSString *)getWeekSpanFromDateString:(NSString *)currentWeeksMondayString
{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"MM/dd/yyyy"];
    
    //convert currentWeeksMondayString to NSDate
    NSDate *date = [format dateFromString:currentWeeksMondayString];
    
    //get monday of the calculated week as a number
    [format setDateFormat:@"MM/dd"];
    NSString *startDay = [format stringFromDate:date];
    
    //get sunday of the calculated week as a number by adding 6 days
    date = [date dateByAddingTimeInterval:60*60*24*6];
    NSString *endDay = [format stringFromDate:date];
    
    return [NSString stringWithFormat:@"%@-%@", startDay, endDay];
}


@end
