//
//  TimesheetHistory.m
//  Timesheet
//
//  Created by Andrew Furusawa on 11/27/12.
//
//

#import "TSHistory.h"
#import "TSHistoryCell.h"
#import "AppDelegate.h"

#import "HR_SuiteTimesheetApprovals.h"
#import "HR_SuiteTimesheet.h"

@implementation TSHistory
{
    AppDelegate *d;
    NSMutableArray *tshlist;
}
@synthesize tshtable, sup;

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
    
    // Initializations
    d = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    //bg
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"ts-bg-bg.png"]]];

    //bg for table
    [tshtable setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"ts-bg-bg.png"]]];
    
    tshlist = [[NSMutableArray alloc]initWithCapacity:100];
    tshlist = [self getHistory];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// gets the past 52 dates
- (NSMutableArray *)getHistory
{
    // Get current Monday's date
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"EEEE"];
    NSDate *today = [NSDate date];
    NSString *day = [format stringFromDate:today];
    NSString *date = [self getMondayFromDate:today onDay:day];
    [format setDateFormat:@"MM/dd/yyyy"];
    
    NSMutableArray *weeks = [[NSMutableArray alloc] init];
    for (int i = 1; i <= 52; i++) {
        
        // Roll back i weeks to get previous Mondays' date
        NSDate *result = [format dateFromString:date];
        result = [result dateByAddingTimeInterval:60*60*24*-7];
        date = [format stringFromDate:result];
        
        // 07/08/2012 -convert-> 7/8/2012        
        NSArray *a = [date componentsSeparatedByString:@"/"];
        NSString *first = [a objectAtIndex:0];
        NSString *second = [a objectAtIndex:1];
        if ([[a objectAtIndex:0] intValue] < 10) {
            first = [[a objectAtIndex:0] stringByReplacingOccurrencesOfString:@"0" withString:@""];
        }
        if ([[a objectAtIndex:1] intValue] < 10) {
            second = [[a objectAtIndex:1] stringByReplacingOccurrencesOfString:@"0" withString:@""];
        }
        date = [NSString stringWithFormat:@"%@/%@/%@", first, second, [a objectAtIndex:2]];
        
        [weeks addObject:date];
    }
    return weeks;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tshlist count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"TSHistoryCell";
    TSHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    //set fonts
    [cell.periodLabel setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:16]];
    [cell.submittedLabel setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:16]];
    [cell.hoursLabel setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:26]];
    [cell.tasksLabel setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:26]];
    
    [cell.periodTextLabel setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:10]];
    [cell.submittedTextLabel setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:10]];
    [cell.hoursTextLabel setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:10]];
    [cell.tasksTextLabel setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:10]];
    
    /**********************/
    /*   SUP Connection   */
    /**********************/
    if (d.isSUPConnection) {
        HR_SuiteTimesheetApprovalsList *list = [HR_SuiteTimesheetApprovals findAll];
        if ([list length] > 0) {
            
            // For each cell, get status and set timestamp
            NSInteger status = 0;
            NSString *timestamp = @"";

            //NSLog(@"current user is %@", d.user);
            for (HR_SuiteTimesheetApprovals *item in list) {
                //NSLog(@"dates %@ = %@", [tshlist objectAtIndex:indexPath.row]);
                if ([d.user isEqualToString:item.employeeID] && [[tshlist objectAtIndex:indexPath.row] isEqualToString:item.date]) {
                    status = [item.signCode intValue];
                    NSLog(@"retrieved %i", status);
                    
                    //waiting
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
                    timestamp = item.timestamp;
                    NSArray *a = [timestamp componentsSeparatedByString:@"/"];
                    cell.submittedLabel.text = [NSString stringWithFormat:@"%@/%@", [a objectAtIndex:0], [a objectAtIndex:1]];
                    
                    break;
                }
                else {
                    [cell.statusImage setImage:[UIImage imageNamed:nil]];
                    cell.submittedLabel.text = @"N/A";
                }
            }
            
            
            // Get total hours for current week and get sign status for current week.
            HR_SuiteTimesheetList *list2 = [HR_SuiteTimesheet findByEmployeeIDandDate:d.user withDate:[tshlist objectAtIndex:indexPath.row]];
            NSInteger totalHours = 0;
            for (HR_SuiteTimesheet *item in list2) {
                totalHours += [item.hours intValue];
            }
            
            // Set the total hours
            if(totalHours == 0) {
                cell.hoursLabel.text = [NSString stringWithFormat:@"0"];
            }
            else {
                cell.hoursLabel.text = [NSString stringWithFormat:@"%i", totalHours];
            }

            // Set tasks
            HR_SuiteTimesheetList *list3 = [HR_SuiteTimesheet findByEmployeeIDandDate:d.user withDate:[tshlist objectAtIndex:indexPath.row]];            
            NSMutableArray *jobsArray = [[NSMutableArray alloc] initWithCapacity:1];
            for (HR_SuiteTimesheet *item in list3) {
                if (![jobsArray containsObject:item.job]) {
                    [jobsArray addObject:item.job];
                }
            }
            cell.tasksLabel.text = [NSString stringWithFormat:@"%i", [jobsArray count]];

            // Set week span
            cell.periodLabel.text = [self getWeekSpanFromDateString:[tshlist objectAtIndex:indexPath.row]];
        

        } //end if
    } //end sup
    
    /**********************/
    /*   Demo             */
    /**********************/
    else {
        if ([tshlist count] > indexPath.row) { //trivial
            // Set tasks
            NSMutableArray *jobsArray = [[NSMutableArray alloc] initWithCapacity:1];
            NSInteger hours = 0;
            for (int i = 0; i < [d.HR_Suite count]; i++) {
                NSDictionary *item = [d.HR_Suite objectAtIndex:i];
                if ([[item objectForKey:@"employeeID"] isEqualToString:d.user] && [[item objectForKey:@"date"] isEqualToString:[tshlist objectAtIndex:indexPath.row]]) {
                    
                    if (![jobsArray containsObject:[item objectForKey:@"job"]]) {
                        [jobsArray addObject:[item objectForKey:@"job"]];
                    }
                    
                    hours += [[item objectForKey:@"hours"] intValue];
                }
            }
            cell.tasksLabel.text = [NSString stringWithFormat:@"%i", [jobsArray count]];
            
            // Set week span
            cell.periodLabel.text = [self getWeekSpanFromDateString:[tshlist objectAtIndex:indexPath.row]];
            
            
            // Calculate total hours for each week
            NSInteger totalhours = 0;
            for (NSDictionary *item in d.HR_Suite) {
                
                BOOL isUser = [[item objectForKey:@"employeeID"] isEqualToString:d.user];
                BOOL isDate = [[item objectForKey:@"date"] isEqualToString:[tshlist objectAtIndex:indexPath.row]];
                
                // Case 2.1: Info exists for date -> then update the info
                if (isUser && isDate) {
                    totalhours += [[item objectForKey:@"hours"] intValue];
                }
            }
            //Set the total hours
            if(totalhours == 0) {
                cell.hoursLabel.text = [NSString stringWithFormat:@"0"];
            }
            else {
                cell.hoursLabel.text = [NSString stringWithFormat:@"%i", totalhours];
            }
            
            
            // Populate data from approvals
            [cell.statusImage setImage:nil];
            for (int b = 0; b < [d.hr_approvals count]; b++) {
                
                BOOL isUser = [d.user isEqualToString:[[d.hr_approvals objectAtIndex:b] objectForKey:@"employeeID"]];
                BOOL isDate = [[tshlist objectAtIndex:indexPath.row] isEqualToString:[[d.hr_approvals objectAtIndex:b] objectForKey:@"date"]];
                
                // Case 2.1: Info exists for date -> then update the info
                if (isUser && isDate) {
                    
                    NSInteger status = [[[d.hr_approvals objectAtIndex:b] objectForKey:@"signCode"] intValue];
                    //[cell.statusImage setImage:[UIImage imageNamed:@"hr_status_notyetsubmitted.png"]];
                    //waiting
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
                    else {
                        [cell.statusImage setImage:nil];
                    }
                }
                
            } //for
            
            // set submitted
            //get timestamp
            if (![d.HR_Suite count] > indexPath.row+1) {
                NSDictionary *item = [d.HR_Suite objectAtIndex:indexPath.row];
                NSString *timestamp = [item objectForKey:@"timestamp"];
                NSArray *a = [timestamp componentsSeparatedByString:@"/"];
                cell.submittedLabel.text = [NSString stringWithFormat:@"%@/%@", [a objectAtIndex:0], [a objectAtIndex:1]];
            }
            
        }
        
    } // demo else
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}





//returns a string with the date for that week's monday in the following format: MM/dd/yyyy
- (NSString *)getMondayFromDate:(NSDate *)date onDay:(NSString *)day
{
    NSString *result = @"error";
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM/dd/yyyy"];
    
    if ([day isEqualToString:@"Monday"]) {
        result = [dateFormatter stringFromDate:date];
    }
    else if ([day isEqualToString:@"Tuesday"]) {
        int daysToAdd = -1;
        NSDate *newDate = [date dateByAddingTimeInterval:60*60*24*daysToAdd];
        result = [dateFormatter stringFromDate:newDate];
    }
    else if ([day isEqualToString:@"Wednesday"]) {
        int daysToAdd = -2;
        NSDate *newDate = [date dateByAddingTimeInterval:60*60*24*daysToAdd];
        result = [dateFormatter stringFromDate:newDate];
    }
    else if ([day isEqualToString:@"Thursday"]) {
        int daysToAdd = -3;
        NSDate *newDate = [date dateByAddingTimeInterval:60*60*24*daysToAdd];
        result = [dateFormatter stringFromDate:newDate];
    }
    else if ([day isEqualToString:@"Friday"]) {
        int daysToAdd = -4;
        NSDate *newDate = [date dateByAddingTimeInterval:60*60*24*daysToAdd];
        result = [dateFormatter stringFromDate:newDate];
    }
    else if ([day isEqualToString:@"Saturday"]) {
        int daysToAdd = -5;
        NSDate *newDate = [date dateByAddingTimeInterval:60*60*24*daysToAdd];
        result = [dateFormatter stringFromDate:newDate];
    }
    else if ([day isEqualToString:@"Sunday"]) {
        int daysToAdd = -6;
        NSDate *newDate = [date dateByAddingTimeInterval:60*60*24*daysToAdd];
        result = [dateFormatter stringFromDate:newDate];
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


- (void)viewDidUnload {
    [self setTshtable:nil];
    [super viewDidUnload];
}
@end
