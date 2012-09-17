//
//  MLRViewController.m
//  Timesheet
//
//  Created by Andrew Furusawa on 7/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MLRViewController.h"
#import "AppDelegate.h"

#import "HR_SuiteLeaveRequests.h"
#import "HR_SuiteUsers.h"
#import "HR_SuiteHR_SuiteDB.h"

@implementation MLRViewController
{
    AppDelegate *d;
    NSMutableArray *workerList;
    NSMutableArray *dateList;
    NSMutableArray *nameList;
}
@synthesize leaveRequestTable;


/****************************************************************************************************
 Protocol Methods
 ****************************************************************************************************/
-(void)reloadView
{
    [workerList removeObjectAtIndex:selectedIndex];
    [dateList removeObjectAtIndex:selectedIndex];
    [nameList removeObjectAtIndex:selectedIndex];
    [self.leaveRequestTable reloadData];
}

// Change delegates and prepare for segue transition.
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"toLRDetails"]) {
        MLRDetailViewController *detailView = [segue destinationViewController];
        detailView.delegate = self;
    }
}



/****************************************************************************************************
 View Did Load
 ****************************************************************************************************/
- (void)viewDidLoad
{
    // Initializations
    d = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    workerList = [[NSMutableArray alloc] init];
    dateList = [[NSMutableArray alloc] init];
    nameList = [[NSMutableArray alloc] init];

    
    /**********************/
    /*   SUP Connection   */
    /**********************/
    if (d.isSUPConnection) {
        
        HR_SuiteUsersList *userslist = [HR_SuiteUsers findAll];
        
        if([userslist length] <= 0) {
            return;
        }
        
        // Populate list with all submissions pending
        for (HR_SuiteUsers *usersItem in userslist) {
            if ([usersItem.manager isEqualToString:d.user]) {
                HR_SuiteLeaveRequestsList *lrlist = [HR_SuiteLeaveRequests findAll];
                for (HR_SuiteLeaveRequests *lrItem in lrlist) {
                    
                    if ([usersItem.employeeID isEqualToString:lrItem.employeeID] && (![lrItem.signCode isEqualToNumber:[NSNumber numberWithInt:99]] && ![lrItem.signCode isEqualToNumber:[NSNumber numberWithInt:100]])) {
                        [workerList addObject:lrItem.employeeID];
                        [dateList addObject:lrItem.timestamp];
                        [nameList addObject:usersItem.employeeName];
                    }
                }
            }
        }
    } //end sup
    
    
    /************/
    /*   DEMO   */
    /************/
    else {
        for (NSDictionary *item in d.hr_leaverequests) {
            if ([[item objectForKey:@"manager"] isEqualToString:d.user] && (![[item objectForKey:@"signCode"] isEqualToString:@"99"] && ![[item objectForKey:@"signCode"] isEqualToString:@"100"])) {
                [workerList addObject:[item objectForKey:@"employeeID"]];
                [dateList addObject:[item objectForKey:@"timestamp"]];
                [nameList addObject:[item objectForKey:@"employeeName"]];
            }
        }
    } //end demo

    [self.leaveRequestTable reloadData];
}

- (void)viewDidUnload
{
    [self setLeaveRequestTable:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}



/****************************************************************************************************
 Table Methods
 ****************************************************************************************************/
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [workerList count];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"LRInboxCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    cell.textLabel.text = [nameList objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = [dateList objectAtIndex:indexPath.row];
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{    
    selectedIndex = indexPath.row;
    
    d.selectedUser = [workerList objectAtIndex:indexPath.row];
    d.selectedDate = [dateList objectAtIndex:indexPath.row];
    
    //Perform segue
    [self performSegueWithIdentifier:@"toLRDetails" sender:self];
    
}



@end
