//
//  JobViewController.m
//  Timesheet
//
//  Created by Andrew Furusawa on 7/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "JobViewController.h"
#import "AppDelegate.h"
#import "HR_SuiteJobManagement.h"
#import "HR_SuiteJobs.h"
#import "SUPQuery.h"

@implementation JobViewController
{
    AppDelegate *d;
    //NSString *response;
}
@synthesize delegate;
@synthesize jobTable;

/****************************************************************************************************
 View Did Load
 ****************************************************************************************************/
-(void)viewDidLoad
{    
    d = (AppDelegate *)[[UIApplication sharedApplication] delegate]; //initialize.
    jobNameList = [[NSMutableArray alloc] init];
    
    if (d.isSUPConnection) {
        /*** SUP Connection ***/
        HR_SuiteJobManagementList *resultList = [HR_SuiteJobManagement findAll];
        
        for (HR_SuiteJobManagement *item in resultList) {
            
            if ([item.employeeID isEqualToString:d.user])
            {
                HR_SuiteJobsList *jobsList = [HR_SuiteJobs findAll];
                for (HR_SuiteJobs *job in jobsList) {
                    if ([item.jobNumber isEqualToNumber:job.jobNumber]) {
                        [jobNameList addObject:job.jobName];
                    }
                }            
            }
        }
    }
    
    /************/
    /*   DEMO   */
    /************/
    else {
        [jobNameList addObject:@"Meeting"];
        [jobNameList addObject:@"iOS Development"];
        [jobNameList addObject:@"Top Secret Project"];
        [jobNameList addObject:@"IR&D"];
        [jobNameList addObject:@"Client Project"];
        [jobNameList addObject:@"Android Development"];
    }

    [self.jobTable reloadData];
}

- (void)viewDidUnload
{
    [self setJobTable:nil];
    [super viewDidUnload];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}



/****************************************************************************************************
 Table Methods - START
 ****************************************************************************************************/
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [jobNameList count];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"JobCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    // Configure the cell...
    //cell.textLabel.text = [jobNameList objectAtIndex:indexPath.row];
    cell.textLabel.text = [jobNameList objectAtIndex:indexPath.row];
    
    return cell;
}



// This method should invoke a connection to the php script which will perform the following function:
// jn_updater should first check to see if the index selected was found. If it is, update the entry with new job name. If it isn't, insert a new entry with the job name and current index.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // iPhone version
    if (tableView.tag == 2) {
        [self.delegate setJobName:[jobNameList objectAtIndex:indexPath.row]];
        NSLog(@"adding: %@", [jobNameList objectAtIndex:indexPath.row]);
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    // iPad version
    else {
        [[self.delegate getPopover] dismissPopoverAnimated:YES];
        
        //NSInteger jobIndex = [self.delegate getJobIndex];
        [self.delegate setJobName:[jobNameList objectAtIndex:indexPath.row]];
    }
    
}




//For iPad
- (IBAction)clearJob:(id)sender {

    [self.delegate setJobName:@"Touch to select task"];
    [[self.delegate getPopover] dismissPopoverAnimated:YES]; //Dismiss pop-over
}

@end
