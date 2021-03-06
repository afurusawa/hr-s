//
//  ManagerApprovalViewController.m
//  Timesheet
//
//  Created by Andrew Furusawa on 7/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ManagerApprovalViewController.h"
#import "AppDelegate.h"
#import "TimesheetDate.h"
#import "MApprovalCell.h"

#import "HR_SuiteTimesheet.h"
#import "HR_SuiteTimesheetApprovals.h"
#import "HR_SuiteHR_SuiteDB.h"

@implementation ManagerApprovalViewController
{
    AppDelegate *d;
    TimesheetDate *tsDate;
   // NSString *response;
    
    NSMutableArray *resultList;
    NSDictionary *entry;
    
    //NSMutableArray *parseList; //stores an array containing the day and the number of hours worked that day.
    
    //BOOL loaded;
    //BOOL approved;
    //BOOL denied;
}

@synthesize totalHoursLabel, totalHoursTextLabel;
@synthesize managerNotes;
@synthesize delegate, navbar;
@synthesize overviewTable;
@synthesize scrollView;


/****************************************************************************************************
 Retrieve Information and format for table
 ****************************************************************************************************/
/* Dictionary will contain the following statistics:
 INT = total hours = total hours for day
 INT = total tasks = total number of tasks for day
 NSMutableArray = entryList = task and hours
        NSDictionary
            NSString = taskName = task name
            NSString = hours = hours for task
 */
- (BOOL)canGetStatsFromDay:(NSString *)day {
    
    /**********************/
    /*   SUP Connection   */
    /**********************/
    if (d.isSUPConnection) {
        HR_SuiteTimesheetList *list = [HR_SuiteTimesheet findStatsFromDay:d.selectedUser withDate:d.selectedDate withDay:day];
        if ([list length] > 0) {
            return YES;
        }
    }
    
    /************/
    /*   DEMO   */
    /************/
    else {
        for (NSDictionary *item in d.HR_Suite) {
            BOOL isUser = [[item objectForKey:@"employeeID"] isEqualToString:d.selectedUser];
            BOOL isDate = [[item objectForKey:@"date"] isEqualToString:d.selectedDate];
            BOOL isDay = [[item objectForKey:@"day"] isEqualToString:day];
            
            if (isUser && isDate && isDay) {
                return YES;
            }
        }
    }
    
    return NO;
}

- (NSDictionary *)getStatsFromDay:(NSString *)day {

    NSDictionary *result;
    NSInteger tot = 0; //total hours
    NSInteger totalTasks = 0;
    NSMutableArray *entryList = [[NSMutableArray alloc] init]; //contains the list of task names and hours per task
    
    /**********************/
    /*   SUP Connection   */
    /**********************/
    if (d.isSUPConnection) {

        HR_SuiteTimesheetList *list = [HR_SuiteTimesheet findStatsFromDay:d.selectedUser withDate:d.selectedDate withDay:day];
        
        //add top element (e.g. Monday: 8 hours)
        NSDictionary *temp = [NSDictionary dictionaryWithObjectsAndKeys:
                              day, @"day",
                              tot, @"totalhours",
                              nil];
        [entryList addObject:temp];
        
        for (HR_SuiteTimesheet *item in list) {
            tot += [item.hours intValue];
            totalTasks++;
            
            temp = [NSDictionary dictionaryWithObjectsAndKeys:
                                  item.job, @"taskName",
                                  [item.hours stringValue], @"hours",
                                  nil];
            [entryList addObject:temp];
        }
        

        result = [NSDictionary dictionaryWithObjectsAndKeys:
                  day, @"day",
                  [NSString stringWithFormat:@"%i", tot] , @"total hours",
                  [NSString stringWithFormat:@"%i", totalTasks], @"total tasks",
                  entryList, @"entry list",
                  nil];
    } //end sup
    
    
    /************/
    /*   DEMO   */
    /************/
    else {
        BOOL first = YES;
        for (NSDictionary *item in d.HR_Suite) {
            BOOL isUser = [[item objectForKey:@"employeeID"] isEqualToString:d.selectedUser];
            BOOL isDate = [[item objectForKey:@"date"] isEqualToString:d.selectedDate];
            BOOL isDay = [[item objectForKey:@"day"] isEqualToString:day];
            
            if (first) {
                NSDictionary *temp = [NSDictionary dictionaryWithObjectsAndKeys:
                                      day, @"day",
                                      [item objectForKey:@"hours"], @"totalhours",
                                      nil];
                [entryList addObject:temp];
                first = NO;
            }
            
            if (isUser && isDate && isDay) {
                NSLog(@"readche");
                tot += [[item objectForKey:@"hours"] intValue];
                totalTasks++;
                
                NSDictionary *temp = [NSDictionary dictionaryWithObjectsAndKeys:
                                      [item objectForKey:@"job"], @"taskName",
                                      [item objectForKey:@"hours"], @"hours",
                                      nil];
                [entryList addObject:temp];
            }
        }
        NSLog(@"also readche");
        result = [NSDictionary dictionaryWithObjectsAndKeys:
                  day, @"day",
                  [NSString stringWithFormat:@"%i", tot] , @"total hours",
                  [NSString stringWithFormat:@"%i", totalTasks], @"total tasks",
                  entryList, @"entry list",
                  nil];
        
        } //end demo
    
    
    
    return result;
}



- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range 
 replacementText:(NSString *)text
{
    
    if ([text isEqualToString:@"\n"]) {
        NSLog(@"textview got called");
        [UIView beginAnimations:@"TEMP" context:NULL];
        [UIView setAnimationDuration:0.3];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:self.view cache:YES];
        [self.view setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        [UIView commitAnimations];
        [textView resignFirstResponder];
        // Return FALSE so that the final '\n' character doesn't get added
        return NO;
    }
    // For any other character return TRUE so that the text gets added to the view
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    NSLog(@"textview got called");
    [UIView beginAnimations:@"TEMP" context:NULL];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:self.view cache:YES];
    [self.view setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [UIView commitAnimations];
    [self.managerNotes resignFirstResponder];
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    NSLog(@"textview got called");
    [UIView beginAnimations:@"TEMP" context:NULL];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:self.view cache:YES];
    [self.view setFrame:CGRectMake(0, -110, self.view.frame.size.width, self.view.frame.size.height)];
    [UIView commitAnimations];
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    NSLog(@"textview got called");
    [UIView beginAnimations:@"TEMP" context:NULL];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:self.view cache:YES];
    [self.view setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [UIView commitAnimations];
}



/****************************************************************************************************
 View Did Load
 ****************************************************************************************************/
- (void)viewDidLoad
{
    // Initializations
    d = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    tsDate = [[TimesheetDate alloc] init];
    resultList = [[NSMutableArray alloc] init];
    
    //bg
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"ts-bg-bg.png"]]];
    
    //navbar title bg
    [navbar setBackgroundImage:[UIImage imageNamed:@"ts.topappbar-bg.png"] forBarMetrics:UIBarMetricsDefault];
    
    //bg for table
    [overviewTable setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"ts-bg-bg.png"]]];
    
    
    //set font
    [totalHoursLabel setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:26]];
    [totalHoursTextLabel setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:14]];
    
    if ([self canGetStatsFromDay:@"Monday"]) {
        [resultList addObject:[self getStatsFromDay:@"Monday"]];
    }
    if ([self canGetStatsFromDay:@"Tuesday"]) {
        [resultList addObject:[self getStatsFromDay:@"Tuesday"]];
    }
    if ([self canGetStatsFromDay:@"Wednesday"]) {
        [resultList addObject:[self getStatsFromDay:@"Wednesday"]];
    }
    if ([self canGetStatsFromDay:@"Thursday"]) {
        [resultList addObject:[self getStatsFromDay:@"Thursday"]];
    }
    if ([self canGetStatsFromDay:@"Friday"]) {
        [resultList addObject:[self getStatsFromDay:@"Friday"]];
    }
    if ([self canGetStatsFromDay:@"Saturday"]) {
        [resultList addObject:[self getStatsFromDay:@"Saturday"]];
    }
    if ([self canGetStatsFromDay:@"Sunday"]) {
        [resultList addObject:[self getStatsFromDay:@"Sunday"]];
    }
    
    NSInteger totalHoursForWeek = 0;
    for (NSDictionary *item in resultList) {
        totalHoursForWeek += [[item objectForKey:@"total hours"] intValue];
    }
    totalHoursLabel.text = [NSString stringWithFormat:@"%i", totalHoursForWeek];

    [self.overviewTable reloadData];
}



- (void)viewDidUnload
{
    [self setOverviewTable:nil];
    [self setTotalHoursLabel:nil];
    [self setManagerNotes:nil];
    [self setTotalHoursTextLabel:nil];
    [self setNavbar:nil];
    [super viewDidUnload];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}



/****************************************************************************************************
 Table View
 ****************************************************************************************************/
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [resultList count];
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    NSLog(@"title for section: %@", [[resultList objectAtIndex:section] objectForKey:@"day"]);
//    return [[resultList objectAtIndex:section] objectForKey:@"day"];
//    
//    /*
//    NSLog(@"2) Header is section reached: %i", section);
//    NSString *day = [parseList objectAtIndex:section];
//    if ([day isEqualToString:@"m"]) {
//        return @"Monday";
//    }
//    else if ([day isEqualToString:@"t"]) {
//        return @"Tuesday";
//    }
//    else if ([day isEqualToString:@"w"]) {
//        return @"Wednesday";
//    }
//    else if ([day isEqualToString:@"th"]) {
//        return @"Thursday";
//    }
//    else if ([day isEqualToString:@"f"]) {
//        return @"Friday";
//    }
//    else if ([day isEqualToString:@"s"]) {
//        return @"Saturday";
//    }
//    else if ([day isEqualToString:@"su"]) {
//        return @"Sunday";
//    }
//    
//    return @"error";
//     */
//
//}



//- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
//{
//    NSString *hours = [[resultList objectAtIndex:section] objectForKey:@"total hours"];
//    NSString *tasks = [[resultList objectAtIndex:section] objectForKey:@"total tasks"];
//    
//    return [NSString stringWithFormat:@"Total: %@ hours on %@ tasks", hours, tasks];
//}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[resultList objectAtIndex:section] objectForKey:@"total tasks"] intValue]+1;
}


//resultslist is a list of dictionaries containing each day where work was done.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"InfoCell";
    MApprovalCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    // set font
    [cell.headerLabel setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:15]];
    [cell.taskLabel setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:15]];
    [cell.hoursLabel setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:16]];
    [cell.hoursTextLabel setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:10]];

    
    NSDictionary *item = [resultList objectAtIndex:indexPath.section];
    NSMutableArray *elist = [item objectForKey:@"entry list"];
    
    NSDictionary *element = [elist objectAtIndex:indexPath.row];
    
    cell.backgroundColor = [UIColor clearColor];
    cell.backgroundView = [[UIView alloc] initWithFrame:CGRectZero];
    // if last element, replace image with bottom
    if ([elist count]-1 == indexPath.row) {
        cell.headerLabel.hidden = YES;
        cell.taskLabel.hidden = NO;
        cell.hoursLabel.hidden = NO;
        cell.hoursTextLabel.hidden = NO;
        
        cell.taskLabel.text = [element objectForKey:@"taskName"];
        cell.hoursLabel.text = [NSString stringWithFormat:@"%@",[element objectForKey:@"hours"]];

        [cell.bgImage setImage:[UIImage imageNamed:@"ts-manager-tasksummary-task-bottom-bg.png"]];
    }
    // if first element, but the header text
    else if (indexPath.row == 0) {
        cell.headerLabel.hidden = NO;
        cell.taskLabel.hidden = YES;
        cell.hoursLabel.hidden = YES;
        cell.hoursTextLabel.hidden = YES;
        
        cell.headerLabel.text = [NSString stringWithFormat:@"%@: %@ hours",[element objectForKey:@"day"], [item objectForKey:@"total hours"]];
        [cell.bgImage setImage:[UIImage imageNamed:@"ts-manager-tasksummary-task-title-bg"]];
        
    }
    else {
        cell.headerLabel.hidden = YES;
        cell.taskLabel.hidden = NO;
        cell.hoursLabel.hidden = NO;
        cell.hoursTextLabel.hidden = NO;

        cell.taskLabel.text = [element objectForKey:@"taskName"];
        cell.hoursLabel.text = [NSString stringWithFormat:@"%@",[element objectForKey:@"hours"]];
        cell.bgImage.image = [UIImage imageNamed:@"ts-manager-tasksummary-task-middle-bg.png"];
        //((UIImageView *)cell.backgroundView).image = [UIImage imageNamed:@"ts-manager-tasksummary-task-middle-bg.png"];
    }
    
    return cell;
}



/****************************************************************************************************
 Approve Timesheet
 ****************************************************************************************************/
//this action will access the approve.php file, where the current entry will be approved. Upon approval, the view will be popped, and user will be redirected to the previous view.
- (IBAction)approveTimesheet:(id)sender {
    [LoadingScreen startLoadingScreenWithView:self.view];
    /**********************/
    /*   SUP Connection   */
    /**********************/
    if (d.isSUPConnection) {
        
        HR_SuiteTimesheetApprovalsList *list = [HR_SuiteTimesheetApprovals findAll];
        for (HR_SuiteTimesheetApprovals *item in list) {
            // Check for same id and date
            if ([d.selectedUser isEqualToString:item.employeeID] && [item.date isEqualToString:d.selectedDate]) {
                NSLog(@"updating timesheet submission");
                [item setSignCode:[NSNumber numberWithInt:100]];
                [item setManagerNotes:managerNotes.text];
                [item setTimestamp:tsDate.getTimestamp];
                [item updateSignCode];
                [item submitPending];
                [HR_SuiteHR_SuiteDB synchronize:@"default"];
            }
        }
    } //end sup
    
    /************/
    /*   DEMO   */
    /************/
    else {
        for (int i = 0; i < [d.hr_approvals count]; i++) {
            if ([[[d.hr_approvals objectAtIndex:i] objectForKey:@"employeeID"] isEqualToString:d.selectedUser] && [[[d.hr_approvals objectAtIndex:i] objectForKey:@"date"] isEqualToString:d.selectedDate]) {
                entry = [NSDictionary dictionaryWithObjectsAndKeys:
                         [[d.hr_approvals objectAtIndex:i] objectForKey:@"date"], @"date",
                         [[d.hr_approvals objectAtIndex:i] objectForKey:@"employeeID"], @"employeeID",
                         [[d.hr_approvals objectAtIndex:i] objectForKey:@"manager"], @"manager",
                         [[d.hr_approvals objectAtIndex:i] objectForKey:@"employeeName"], @"employeeName",
                         [[d.hr_approvals objectAtIndex:i] objectForKey:@"timestamp"], @"timestamp", 
                         @"100", @"signCode",
                         managerNotes.text, @"managerNotes",
                         [[d.hr_approvals objectAtIndex:i] objectForKey:@"date"], @"date",
                         [[d.hr_approvals objectAtIndex:i] objectForKey:@"hours"], @"hours",
                         nil];
                [d.hr_approvals replaceObjectAtIndex:i withObject:entry];
            }
        }
    }
    
    /*
    HR_SuiteTimesheetList *list = [HR_SuiteTimesheet findByEmployeeIDandDate:d.selectedUser withDate:d.selectedDate];    
    
    for (HR_SuiteTimesheet *item in list) {
        [item setSignCode:[NSNumber numberWithInt:100]];
        [item setManagerNotes:managerNotes.text];
        [item setTimestamp:[tsDate getTimestamp]];
        [item updateSignCode];
        [item submitPending];
        [HR_SuiteHR_SuiteDB synchronize:@"default"];
    }
     */
    [LoadingScreen stopLoadingScreenWithView:self.view];
    [self.delegate refreshView];
    [self.navigationController popViewControllerAnimated:YES]; //return to previous view.
}



/****************************************************************************************************
 Deny Timsheet
 ****************************************************************************************************/
- (IBAction)denyTimesheet:(id)sender {
    [LoadingScreen startLoadingScreenWithView:self.view];
    /**********************/
    /*   SUP Connection   */
    /**********************/
    if (d.isSUPConnection) {
        
        HR_SuiteTimesheetApprovalsList *list = [HR_SuiteTimesheetApprovals findAll];
        for (HR_SuiteTimesheetApprovals *item in list) {
            // Check for same id and date
            if ([d.selectedUser isEqualToString:item.employeeID] && [item.date isEqualToString:d.selectedDate]) {
                NSLog(@"updating timesheet submission");
                [item setSignCode:[NSNumber numberWithInt:99]];
                [item setManagerNotes:managerNotes.text];
                [item setTimestamp:tsDate.getTimestamp];
                [item updateSignCode];
                [item submitPending];
                [HR_SuiteHR_SuiteDB synchronize:@"default"];
            }
        }
    } //end sup
    
    /************/
    /*   DEMO   */
    /************/
    else {
        for (int i = 0; i < [d.hr_approvals count]; i++) {
            if ([[[d.hr_approvals objectAtIndex:i] objectForKey:@"employeeID"] isEqualToString:d.selectedUser] && [[[d.hr_approvals objectAtIndex:i] objectForKey:@"date"] isEqualToString:d.selectedDate]) {
                entry = [NSDictionary dictionaryWithObjectsAndKeys:
                         [[d.hr_approvals objectAtIndex:i] objectForKey:@"date"], @"date",
                         [[d.hr_approvals objectAtIndex:i] objectForKey:@"employeeID"], @"employeeID",
                         [[d.hr_approvals objectAtIndex:i] objectForKey:@"manager"], @"manager",
                         [[d.hr_approvals objectAtIndex:i] objectForKey:@"employeeName"], @"employeeName",
                         [[d.hr_approvals objectAtIndex:i] objectForKey:@"timestamp"], @"timestamp", 
                         @"99", @"signCode",
                         managerNotes.text, @"managerNotes",
                         [[d.hr_approvals objectAtIndex:i] objectForKey:@"date"], @"date",
                         [[d.hr_approvals objectAtIndex:i] objectForKey:@"hours"], @"hours",
                         nil];
                [d.hr_approvals replaceObjectAtIndex:i withObject:entry];
            }
        }
    }
    /*
    HR_SuiteTimesheetList *list = [HR_SuiteTimesheet findByEmployeeIDandDate:d.selectedUser withDate:d.selectedDate];    
    
    for (HR_SuiteTimesheet *item in list) {
        [item setSignCode:[NSNumber numberWithInt:99]];
        [item setManagerNotes:managerNotes.text];
        [item setTimestamp:[tsDate getTimestamp]];
        [item updateSignCode];
        [item submitPending];
        [HR_SuiteHR_SuiteDB synchronize:@"default"];
    }
     */
    [LoadingScreen stopLoadingScreenWithView:self.view];
    [self.delegate refreshView];
    [self.navigationController popViewControllerAnimated:YES]; //return to previous view.
}



@end
