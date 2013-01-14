//
//  ManagerUserViewController.m
//  Timesheet
//
//  Created by Andrew Furusawa on 7/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ManagerUserViewController.h"
#import "AppDelegate.h"

#import "HR_SuiteTimesheet.h"
#import "HR_SuiteUsers.h"
#import "HR_SuiteTimesheetApprovals.h"
#import "HR_SuiteHR_SuiteDB.h"
#import "MTimesheetCell.h"
#import "SUPSyncStatusInfo.h"

@implementation ManagerUserViewController
{
    AppDelegate *d;
    //NSInteger selectedIndex; //stores the value of the index selected in the table for quick delete.
    
    NSMutableArray *inboxList;
    NSDictionary *entry;
}
@synthesize workerTable, navbar;


/****************************************************************************************************
 Protocol Methods
 ****************************************************************************************************/
- (void)refreshView
{   
    [inboxList removeObjectAtIndex:[d.selectedIndex intValue]];
    [self.workerTable reloadData];
}



// Change delegate and prepare for segue transition.
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    ManagerApprovalViewController *approvalView = [segue destinationViewController];
    approvalView.delegate = self;
}

//copied from subscribecontroller
-(void) onGetSyncStatusChange:(SUPSyncStatusInfo*)info
{
    switch(info.state)
    {
        case SYNC_STATE_NONE:
            MBOLogDebug(@"SYNC_STATE_NONE");
            break;
        case SYNC_STATE_STARTING:
            MBOLogDebug(@"SYNC_STATE_STARTING");
            break;
        case SYNC_STATE_CONNECTING:
            MBOLogDebug(@"SYNC_STATE_CONNECTING");
            break;
        case SYNC_STATE_SENDING_HEADER:
            MBOLogDebug(@"SYNC_STATE_SENDING_HEADER");
            break;
        case SYNC_STATE_SENDING_TABLE:
            MBOLogDebug(@"SYNC_STATE_SENDING_TABLE");
            break;
        case SYNC_STATE_SENDING_DATA:
            MBOLogDebug(@"SYNC_STATE_SENDING_DATA");
            break;
        case SYNC_STATE_FINISHING_UPLOAD:
            MBOLogDebug(@"SYNC_STATE_FINISHING_UPLOAD");
            break;
        case SYNC_STATE_RECEIVING_UPLOAD_ACK:
            MBOLogDebug(@"SYNC_STATE_RECEIVING_UPLOAD_ACK");
            break;
        case SYNC_STATE_RECEIVING_TABLE:
            MBOLogDebug(@"SYNC_STATE_RECEIVING_TABLE");
            break;
        case SYNC_STATE_RECEIVING_DATA:
            MBOLogDebug(@"SYNC_STATE_RECEIVING_DATA");
            break;
        case SYNC_STATE_COMMITTING_DOWNLOAD:
            MBOLogDebug(@"SYNC_STATE_COMMITTING_DOWNLOAD");
            break;
        case SYNC_STATE_SENDING_DOWNLOAD_ACK:
            MBOLogDebug(@"SYNC_STATE_SENDING_DOWNLOAD_ACK");
            break;
        case SYNC_STATE_DISCONNECTING:
            MBOLogDebug(@"SYNC_STATE_DISCONNECTING");
            break;
        case SYNC_STATE_DONE:
            MBOLogDebug(@"SYNC_STATE_DONE");
            //these aren't needed because we don't change the view.
            //            self.menuController = [[MenuListController alloc] initWithStyle:UITableViewStylePlain];
            //            [self showListController];
            NSLog(@"Done.");
            break;
        case SYNC_STATE_ERROR:
            MBOLogDebug(@"SYNC_STATE_ERROR");
            break;
        case SYNC_STATE_ROLLING_BACK_DOWNLOAD:
            MBOLogDebug(@"SYNC_STATE_ROLLING_BACK_DOWNLOAD");
            break;
        case SYNC_STATE_UNKNOWN:
            MBOLogDebug(@"SYNC_STATE_UNKNOWN");
            break;
        default:
            MBOLogDebug(@"DEFAULT");
            break;
    }
}

/****************************************************************************************************
 View Did Load
 ****************************************************************************************************/
- (void)viewDidLoad
{
    // Initializations
    d = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    inboxList = [[NSMutableArray alloc] init];

    //bg
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"ts-bg-bg.png"]]];
    
    //navbar title bg
    [navbar setBackgroundImage:[UIImage imageNamed:@"ts.topappbar-bg.png"] forBarMetrics:UIBarMetricsDefault];
  
    //bg for table
    [workerTable setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"ts-bg-bg.png"]]];


    //set tab images
    UITabBarController *tabBarController = self.tabBarController;
    
    [[tabBarController.tabBar.items objectAtIndex:0] setImageInsets:UIEdgeInsetsMake(6, -0, -6, 0)];
    [[tabBarController.tabBar.items objectAtIndex:1] setImageInsets:UIEdgeInsetsMake(6, -0, -6, 0)];
    [[tabBarController.tabBar.items objectAtIndex:2] setImageInsets:UIEdgeInsetsMake(6, 0, -6, -0)];
    [[tabBarController.tabBar.items objectAtIndex:3] setImageInsets:UIEdgeInsetsMake(6, 0, -6, -0)];
    
    [[tabBarController.tabBar.items objectAtIndex:0] setFinishedSelectedImage:[UIImage imageNamed:@"ts-mainnavi-manager-timesheets-down.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"ts-mainnavi-manager-timesheets-up.png"]];
    [[tabBarController.tabBar.items objectAtIndex:1] setFinishedSelectedImage:[UIImage imageNamed:@"ts-mainnavi-manager-leaverequests-down.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"ts-mainnavi-manager-leaverequests-up.png"]];
    [[tabBarController.tabBar.items objectAtIndex:2] setFinishedSelectedImage:[UIImage imageNamed:@"ts-mainnavi-manager-tasks-down.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"ts-mainnavi-manager-tasks-up.png"]];
    [[tabBarController.tabBar.items objectAtIndex:3] setFinishedSelectedImage:[UIImage imageNamed:@"ts-mainnavi-manager-history-down.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"ts-mainnavi-manager-history-up.png"]];
    
    /**********************/
    /*   SUP Connection   */
    /**********************/
    if (d.isSUPConnection) {
        
        [LoadingScreen startLoadingScreenWithView:self.view];
        [HR_SuiteHR_SuiteDB  synchronizeWithListener:self];
        [LoadingScreen stopLoadingScreenWithView:self.view];
        
        HR_SuiteUsersList *userList = [HR_SuiteUsers findAll];
        for (HR_SuiteUsers *userItem in userList) {
            
            // Retrieve only the signed timesheets of team members
            if ([userItem.manager isEqualToString:d.user]) {
                
                HR_SuiteTimesheetApprovalsList *list = [HR_SuiteTimesheetApprovals findAll];
                
                if ([list length] == 0) {
                    return;
                }
                
                for (HR_SuiteTimesheetApprovals *item in list) {
                    
                    if ([userItem.employeeID isEqualToString:item.employeeID] && [item.signCode isEqualToNumber:[NSNumber numberWithInt:1]]) {
                        
                        entry = [NSDictionary dictionaryWithObjectsAndKeys:
                                 item.employeeID, @"employeeID",
                                 item.date, @"date",
                                 item.timestamp, @"timestamp",
                                 userItem.employeeName, @"employeeName",
                                 [self getTotalHoursForEmployee:item.employeeID fromWeek:item.date], @"hours",
                                 nil];
                        NSLog(@"%@, %@", item.employeeID, item.date);
                        NSLog(@"%@", [self getTotalHoursForEmployee:item.employeeID fromWeek:item.date]);
                        [inboxList addObject:entry];
                    }
                }
                
            } //end if
        } //end fror
    } //end sup
    
    
    /************/
    /*   DEMO   */
    /************/
    else {
        //NSLog(@"WHYY \n %@ \n\n\n\n", d.hr_approvals);
        for (int i = 0; i < [d.hr_approvals count]; i++) {
            NSLog(@"%@", [d.hr_approvals objectAtIndex:i]);
            if ([[[d.hr_approvals objectAtIndex:i] objectForKey:@"manager"] isEqualToString:d.user] && [[[d.hr_approvals objectAtIndex:i] objectForKey:@"signCode"] isEqualToString:@"1"]) {
                //NSLog(@"current user = %@", [d.hr_approvals objectAtIndex:i]);
                [inboxList addObject:[d.hr_approvals objectAtIndex:i]];
            }
        }
    }

    
    [self.workerTable reloadData];
}

- (void)viewDidUnload
{
    [self setWorkerTable:nil];
    [self setNavbar:nil];
    [super viewDidUnload];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (NSString *)getTotalHoursForEmployee:(NSString *)name fromWeek:(NSString *)date
{
    NSInteger total = 0;
    HR_SuiteTimesheetList *list = [HR_SuiteTimesheet findByEmployeeIDandDate:name withDate:date];
    if ([list length] > 0) {
        for (HR_SuiteTimesheet *item in list) {
            total += [item.hours intValue];
        }
    }
    return [NSString stringWithFormat:@"%i", total];
}

- (NSString *)getWeekSpanFromDate:(NSString *)date
{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"MM/dd/yyyy"];
    NSDate *sDate = [format dateFromString:date];
    NSDate *eDate = [sDate dateByAddingTimeInterval:24*60*60*6];
    
    [format setDateFormat:@"dd"];
    NSString *start = [format stringFromDate:sDate];
    NSString *end = [format stringFromDate:eDate];
    
    return [NSString stringWithFormat:@"%@-%@",start, end];
}
- (NSString *)formatTimestamp:(NSString *)timestamp
{
    NSArray *a = [timestamp componentsSeparatedByString:@"/"];
    return [NSString stringWithFormat:@"%@/%@", [a objectAtIndex:0], [a objectAtIndex:1]];
}



/****************************************************************************************************
 TABLE METHODS
 ****************************************************************************************************/
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [inboxList count];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MTimesheetCell";
    MTimesheetCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    //set fonts
    [cell.nameLabel setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:14]];
    [cell.timestampLabel setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:16]];
    [cell.hoursLabel setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:20]];
    [cell.weekLabel setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:16]];
    
    [cell.periodTextLabel setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:10]];
    [cell.submittedTextLabel setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:10]];
    [cell.hoursTextLabel setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:10]];

    // Configure the cell...
    cell.nameLabel.text = [[inboxList objectAtIndex:indexPath.row] objectForKey:@"employeeName"];
    cell.timestampLabel.text = [self formatTimestamp:[[inboxList objectAtIndex:indexPath.row] objectForKey:@"timestamp"]]; //timestamp
    cell.weekLabel.text = [self getWeekSpanFromDate:[[inboxList objectAtIndex:indexPath.row] objectForKey:@"date"]];
    cell.hoursLabel.text = [[inboxList objectAtIndex:indexPath.row] objectForKey:@"hours"];
    
    cell.user.text = [[inboxList objectAtIndex:indexPath.row] objectForKey:@"employeeID"];
    cell.date.text = [[inboxList objectAtIndex:indexPath.row]objectForKey:@"date"];
    cell.index.text = [NSString stringWithFormat:@"%i", indexPath.row];
    cell.vc = self;
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{    
//    //Store transferrable data
//    selectedIndex = indexPath.row;
//    d.selectedUser = [[inboxList objectAtIndex:indexPath.row] objectForKey:@"employeeID"];
//    d.selectedDate = [[inboxList objectAtIndex:indexPath.row]objectForKey:@"date"];
//    
//    //Perform segue
//    [self performSegueWithIdentifier:@"toInboxChooser" sender:self];
}



- (IBAction)goBack:(id)sender {
    [self.parentViewController.navigationController popViewControllerAnimated:YES];
}
@end
