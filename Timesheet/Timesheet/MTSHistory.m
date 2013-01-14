//
//  MTSHistory.m
//  Timesheet
//
//  Created by Andrew Furusawa on 12/3/12.
//
//

#import "AppDelegate.h"
#import "TimesheetDate.h"
#import "MTSHistory.h"
#import "MTSHCell.h"
#import "HR_SuiteTimesheetApprovals.h"
#import "HR_SuiteTimesheet.h"
#import "HR_SuiteUsers.h"

@interface MTSHistory ()

@end

@implementation MTSHistory
{
    AppDelegate *d;
    TimesheetDate *tsDate;
    NSMutableArray *historyList;
    NSDictionary *entry;
    NSMutableArray *sortedList;
}
@synthesize htable;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

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
        
        HR_SuiteTimesheetApprovalsList *tsaList = [HR_SuiteTimesheetApprovals findAll];
        if ([tsaList length] > 0) {
            for (HR_SuiteTimesheetApprovals *tsaItem in tsaList) {
                
                // Get only team members
                HR_SuiteUsersList *uList = [HR_SuiteUsers findAll];
                for (HR_SuiteUsers *uItem in uList) {
                    
                    if ([uItem.manager isEqualToString:d.user] &&
                        [tsaItem.employeeID isEqualToString:uItem.employeeID] &&
                        ([tsaItem.signCode isEqualToNumber:[NSNumber numberWithInt:99]] || [tsaItem.signCode isEqualToNumber:[NSNumber numberWithInt:100]])
                        ) {
                        
                        //get total hours
                        HR_SuiteTimesheetList *tslist = [HR_SuiteTimesheet findByEmployeeIDandDate:uItem.employeeID withDate:tsaItem.date];
                        int hours = 0;
                        for (HR_SuiteTimesheet *tsItem in tslist) {
                            hours += [tsItem.hours intValue];
                        }
                        
                        entry = [NSDictionary dictionaryWithObjectsAndKeys:
                                 [tsaItem.signCode stringValue], @"status",
                                 @"Timesheet", @"submissionType",
                                 uItem.employeeName, @"employeeName",
                                 tsaItem.date, @"date",
                                 tsaItem.timestamp, @"timestamp",
                                 [NSString stringWithFormat:@"%i",hours], @"hours",
                                 nil];
                        [historyList addObject:entry];
                    }
                }
            }
        } //end if
        NSLog(@"load tsh");
        // Sort by timestamp
        sortedList = [self sortMostRecent:historyList];
        
    } //end sup
    
    
    /**********************/
    /*   Demo             */
    /**********************/
    else {
        for (NSDictionary *item in d.hr_approvals) {
            NSLog(@"%@", item);
            if ([[item objectForKey:@"manager"] isEqualToString:d.user] && ([[item objectForKey:@"signCode"] isEqualToString:@"99"] || [[item objectForKey:@"signCode"] isEqualToString:@"100"])) {
                entry = [NSDictionary dictionaryWithObjectsAndKeys:
                         [item objectForKey:@"signCode"], @"status",
                         @"Timesheet", @"submissionType",
                         [item objectForKey:@"date"], @"date",
                         [item objectForKey:@"employeeName"], @"employeeName",
                         [item objectForKey:@"timestamp"], @"timestamp",
                         [item objectForKey:@"hours"], @"hours",
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
    //return 1;
    return [sortedList count];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MTSHCell";
    MTSHCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    
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
    
    //set font
    [cell.nameLabel setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:14]];
    [cell.periodLabel setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:16]];
    [cell.submittedLabel setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:16]];
    [cell.hoursLabel setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:24]];

    
    [cell.periodTextLabel setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:10]];
    [cell.submittedTextLabel setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:10]];
    [cell.hoursTextLabel setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:10]];

    
    NSDictionary *item = [historyList objectAtIndex:indexPath.row];
    
    //name
    cell.nameLabel.text = [item objectForKey:@"employeeName"];
    
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
    
    //get timestamp
    NSString *timestamp = [item objectForKey:@"timestamp"];
    NSArray *a = [timestamp componentsSeparatedByString:@"/"];
    cell.submittedLabel.text = [NSString stringWithFormat:@"%@/%@", [a objectAtIndex:0], [a objectAtIndex:1]];
    
    //period
    cell.periodLabel.text = [self getWeekSpanFromDateString:[item objectForKey:@"date"]];

    //hours
    cell.hoursLabel.text = [item objectForKey:@"hours"];

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
    [format setDateFormat:@"dd"];
    NSString *startDay = [format stringFromDate:date];
    
    //get sunday of the calculated week as a number by adding 6 days
    date = [date dateByAddingTimeInterval:60*60*24*6];
    NSString *endDay = [format stringFromDate:date];
    
    return [NSString stringWithFormat:@"%@-%@", startDay, endDay];
}

@end
