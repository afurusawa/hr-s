//
//  MLRViewController.m
//  Timesheet
//
//  Created by Andrew Furusawa on 7/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MLRViewController.h"
#import "AppDelegate.h"
#import "MLRCell.h"
#import "HR_SuiteLeaveRequests.h"
#import "HR_SuiteUsers.h"
#import "HR_SuiteHR_SuiteDB.h"
#import "SUPSyncStatusInfo.h"

@implementation MLRViewController
{
    AppDelegate *d;
    NSMutableArray *workerList;
    NSMutableArray *dateList;
    NSMutableArray *nameList;
    
    NSMutableArray *inboxlist;
}
@synthesize leaveRequestTable, navbar;


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
 Protocol Methods
 ****************************************************************************************************/
-(void)reloadView
{
    NSLog(@"index-> %@", d.selectedIndex);
    [workerList removeObjectAtIndex:[d.selectedIndex intValue]];
    [dateList removeObjectAtIndex:[d.selectedIndex intValue]];
    [nameList removeObjectAtIndex:[d.selectedIndex intValue]];
    if (d.isSUPConnection) {
        [inboxlist removeObjectAtIndex:[d.selectedIndex intValue]];
    }
    [self.leaveRequestTable reloadData];
}

// Change delegates and prepare for segue transition.
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"toLRSummary"]) {
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
    inboxlist = [[NSMutableArray alloc] init];
    
    //bg
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"ts-bg-bg.png"]]];
    
    //navbar title bg
    [navbar setBackgroundImage:[UIImage imageNamed:@"ts.topappbar-bg.png"] forBarMetrics:UIBarMetricsDefault];
        
    //bg for table
    [leaveRequestTable setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"ts-bg-bg.png"]]];
    
    
    /**********************/
    /*   SUP Connection   */
    /**********************/
    if (d.isSUPConnection) {
        [LoadingScreen startLoadingScreenWithView:self.view];
        [HR_SuiteHR_SuiteDB  synchronizeWithListener:self];
        [LoadingScreen stopLoadingScreenWithView:self.view];
        
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
                        
                        [inboxlist addObject:lrItem];
                        
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
    [self setNavbar:nil];
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
    MLRCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    [cell.nameLabel setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:14]];
    [cell.periodLabel setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:16]];
    [cell.submittedLabel setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:16]];
    [cell.typeLabel setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:10]];
    [cell.submittedTextLabel setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:10]];
    [cell.periodTextLabel setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:10]];
    
    if (d.isSUPConnection) {
        HR_SuiteLeaveRequests *item = [inboxlist objectAtIndex:indexPath.row];
        
        // Set name
        cell.nameLabel.text = [nameList objectAtIndex:indexPath.row];
        
        // Set period
        NSString *sd = item.startDate;
        NSString *ed = item.endDate;
        NSArray *temp = [sd componentsSeparatedByString:@"/"];
        NSArray *temp2 = [ed componentsSeparatedByString:@"/"];
        sd = [NSString stringWithFormat:@"%@/%@", [temp objectAtIndex:0], [temp objectAtIndex:1]];
        ed = [NSString stringWithFormat:@"%@/%@", [temp2 objectAtIndex:0], [temp2 objectAtIndex:1]];
        cell.periodLabel.text = [NSString stringWithFormat:@"%@-%@", sd,ed];
        
        // Set leave type
        cell.typeLabel.text = [NSString stringWithFormat:@"%@", item.leaveType];
        
        //set timestamp
        //get timestamp
        NSString *timestamp = item.timestamp;
        NSArray *a = [timestamp componentsSeparatedByString:@"/"];
        cell.submittedLabel.text = [NSString stringWithFormat:@"%@/%@", [a objectAtIndex:0], [a objectAtIndex:1]];
        
        cell.userLabel.text = [workerList objectAtIndex:indexPath.row];
        cell.dateLabel.text = timestamp;
        cell.indexLabel.text = [NSString stringWithFormat:@"%i", indexPath.row];
        cell.vc = self;
    }
    
    else {
        NSDictionary *item = [d.hr_leaverequests objectAtIndex:indexPath.row];
        
        // Set name
        cell.nameLabel.text = [nameList objectAtIndex:indexPath.row];
        
        // Set period
        NSString *sd = [item objectForKey:@"startDate"];
        NSString *ed = [item objectForKey:@"endDate"];
        NSArray *temp = [sd componentsSeparatedByString:@"/"];
        NSArray *temp2 = [ed componentsSeparatedByString:@"/"];
        sd = [NSString stringWithFormat:@"%@/%@", [temp objectAtIndex:0], [temp objectAtIndex:1]];
        ed = [NSString stringWithFormat:@"%@/%@", [temp2 objectAtIndex:0], [temp2 objectAtIndex:1]];
        cell.periodLabel.text = [NSString stringWithFormat:@"%@-%@", sd,ed];
        
        // Set leave type
        cell.typeLabel.text = [NSString stringWithFormat:@"%@", [item objectForKey:@"leaveType"]];
        
        //set timestamp
        //get timestamp
        NSString *timestamp = [dateList objectAtIndex:indexPath.row];
        NSArray *a = [timestamp componentsSeparatedByString:@"/"];
        cell.submittedLabel.text = [NSString stringWithFormat:@"%@/%@", [a objectAtIndex:0], [a objectAtIndex:1]];
        
        cell.userLabel.text = [workerList objectAtIndex:indexPath.row];
        cell.dateLabel.text = timestamp;
        cell.indexLabel.text = [NSString stringWithFormat:@"%i", indexPath.row];
        //NSLog(@"seleted user %@ %@", [workerList objectAtIndex:indexPath.row], timestamp);
        cell.vc = self;
    }
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{    
//    selectedIndex = indexPath.row;
//    
//    d.selectedUser = [workerList objectAtIndex:indexPath.row];
//    d.selectedDate = [dateList objectAtIndex:indexPath.row];
//    
//    //Perform segue
//    [self performSegueWithIdentifier:@"toLRDetails" sender:self];
    
}



- (IBAction)goBack:(id)sender {
    [self.parentViewController.navigationController popViewControllerAnimated:YES];
}
@end
