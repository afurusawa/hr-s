//
//  ManagerUserViewController.m
//  Timesheet
//
//  Created by Andrew Furusawa on 7/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ManagerUserViewController.h"
#import "AppDelegate.h"

//#import "HR_SuiteTimesheet.h"
#import "HR_SuiteUsers.h"
#import "HR_SuiteTimesheetApprovals.h"
#import "HR_SuiteHR_SuiteDB.h"

@implementation UserCell
@synthesize name;
@synthesize dateLabel;

@end

@implementation ManagerUserViewController
{
    AppDelegate *d;
    NSInteger selectedIndex; //stores the value of the index selected in the table for quick delete.
    
    NSMutableArray *inboxList;
    NSDictionary *entry;
}
@synthesize workerTable;


/****************************************************************************************************
 Protocol Methods
 ****************************************************************************************************/
- (void)refreshView
{   
    [inboxList removeObjectAtIndex:selectedIndex];
    [self.workerTable reloadData];
}



// Change delegate and prepare for segue transition.
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"toInboxChooser"]) {
        ManagerApprovalViewController *approvalView = [segue destinationViewController];
        approvalView.delegate = self;
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

    /**********************/
    /*   SUP Connection   */
    /**********************/
    if (d.isSUPConnection) {
        
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
                                 nil];
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
        NSLog(@"WHYY \n %@ \n\n\n\n", d.hr_approvals);
        for (int i = 0; i < [d.hr_approvals count]; i++) {
            if ([[[d.hr_approvals objectAtIndex:i] objectForKey:@"manager"] isEqualToString:d.user] && [[[d.hr_approvals objectAtIndex:i] objectForKey:@"signCode"] isEqualToString:@"1"]) {
                NSLog(@"current user = %@", [d.hr_approvals objectAtIndex:i]);
                [inboxList addObject:[d.hr_approvals objectAtIndex:i]];
            }
        }
    }

    
    [self.workerTable reloadData];
}

- (void)viewDidUnload
{
    [self setWorkerTable:nil];
    [super viewDidUnload];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
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
    static NSString *CellIdentifier = @"WorkerCell";
    UserCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    // Configure the cell...
    cell.name.text = [[inboxList objectAtIndex:indexPath.row] objectForKey:@"employeeName"];
    cell.dateLabel.text = [[inboxList objectAtIndex:indexPath.row] objectForKey:@"timestamp"]; //timestamp
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{    
    //Store transferrable data
    selectedIndex = indexPath.row;
    d.selectedUser = [[inboxList objectAtIndex:indexPath.row] objectForKey:@"employeeID"];
    d.selectedDate = [[inboxList objectAtIndex:indexPath.row]objectForKey:@"date"];
    
    //Perform segue
    [self performSegueWithIdentifier:@"toInboxChooser" sender:self];
}



@end
