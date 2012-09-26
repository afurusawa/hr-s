//
//  JMTeamMemberViewController.m
//  Timesheet
//
//  Created by Rapid Consulting on 9/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "JMTeamMemberViewController.h"
#import "HR_SuiteJobManagement.h"
#import "HR_SuiteJobs.h"
#import "JMCell.h"
#import "AppDelegate.h"
#import "HR_SuiteHR_SuiteDB.h"

@implementation JMTeamMemberViewController
{
    AppDelegate *d;
    NSMutableArray *jobList;
}
@synthesize taskTable;



/* Returns the list of jobs for the selected user. */
- (void)refresh
{   
    NSLog(@"adding to iphone");
    jobList = [[NSMutableArray alloc] init];
    
    /**********************/
    /*   SUP Connection   */
    /**********************/
    if (d.isSUPConnection) {
        
        HR_SuiteJobManagementList *list = [HR_SuiteJobManagement findAll];
        
        //if empty, show error (?)
        if ([list length] <= 0) {
            return;
        }
        
        //return all the job numbers for current team member
        for (HR_SuiteJobManagement *item in list) {
            if ([item.employeeID isEqualToString:d.selectedUser]) {
                
                HR_SuiteJobsList *jobs = [HR_SuiteJobs findAll];
                for (HR_SuiteJobs *jobsItem in jobs) {
                    
                    if ([item.jobNumber isEqualToNumber:jobsItem.jobNumber]) {
                        [jobList addObject:jobsItem.jobName]; //add the job name.
                    }
                }
            } //end if-statement
        } //end for-loop            
        
    } //end sup
    
    
    /************/
    /*   DEMO   */
    /************/
    else {
        
        for (NSDictionary *item in d.hr_taskmanagement) {
            if ([[item objectForKey:@"employeeID"] isEqualToString:d.selectedUser]) {
                [jobList addObject:[item objectForKey:@"jobName"]];
            }
        }
    } //end demo
    
    [self.taskTable reloadData];
}



/****************************************************************************************************
 Prepare Segue and Set Delegate
 ****************************************************************************************************/
- (void) prepareForSegue:(UIStoryboardPopoverSegue *)segue sender:(id)sender {
    
    // iPhone version
    if (taskTable.tag == 2) {
        JMJobViewController *jobView = [segue destinationViewController];
        jobView.delegate = self;
    }

}



- (void)viewDidLoad
{
    [super viewDidLoad];
	
    //initialize
    d = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    jobList = [[NSMutableArray alloc] init];
    
    self.navigationItem.title = d.employeeName;
    
    /**********************/
    /*   SUP Connection   */
    /**********************/
    if (d.isSUPConnection) {
        HR_SuiteJobManagementList *list = [HR_SuiteJobManagement findAll];
        
        //if empty, show error (?)
        if ([list length] <= 0) {
            return;
        }
        
        //return all the job numbers for current team member
        for (HR_SuiteJobManagement *item in list) {
            if ([item.employeeID isEqualToString:d.selectedUser]) {
                
                HR_SuiteJobsList *jobs = [HR_SuiteJobs findAll];
                for (HR_SuiteJobs *jobsItem in jobs) {
                    
                    if ([item.jobNumber isEqualToNumber:jobsItem.jobNumber]) {
                        [jobList addObject:jobsItem.jobName]; //add the job name.
                    }
                }
            } //end if-statement
        } //end for-loop            
    } //end sup
    
    /************/
    /*   DEMO   */
    /************/
    else {
        for (NSDictionary *item in d.hr_taskmanagement) {
            if ([[item objectForKey:@"employeeID"] isEqualToString:d.selectedUser]) {
                [jobList addObject:[item objectForKey:@"jobName"]];
            }
        }
    }
    
    [self.taskTable reloadData];
    

}

- (void)viewDidUnload
{
    [self setTaskTable:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [jobList count];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"JobCell";
    JMCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.jobNameLabel.text = [jobList objectAtIndex:indexPath.row];
    cell.removeButton.tag = indexPath.row;
    
    return cell;
}





- (IBAction)removeTask:(UIButton *)sender {
    
    /**********************/
    /*   SUP Connection   */
    /**********************/
    if (d.isSUPConnection) {
        
        // Remove item in database as well. Changes will be displayed when the view is reloaded
        HR_SuiteJobManagementList *list = [HR_SuiteJobManagement findAll];
        for (HR_SuiteJobManagement *item in list) {
            
            // Filter: current employee
            if ([item.employeeID isEqualToString:d.selectedUser]) {
                
                HR_SuiteJobsList *jl = [HR_SuiteJobs findAll];
                for (HR_SuiteJobs *ji in jl) {
                    
                    // Find job name for the task to remove 
                    if ([item.jobNumber isEqualToNumber:ji.jobNumber]) {
                        
                        if ([ji.jobName isEqualToString:[jobList objectAtIndex:sender.tag]]) {
                            [item delete];
                            [item submitPending];
                            [HR_SuiteHR_SuiteDB synchronize:@"default"];
                        }
                        
                    }
                }
                
            } //if
        } //for
        
    } //end sup
    
    /************/
    /*   DEMO   */
    /************/
    else {
        NSMutableArray *temp = d.hr_taskmanagement;
        BOOL found = NO;
        for (NSDictionary *item in temp) {
            NSLog(@" %@ %@ ====== %@ %@", [item objectForKey:@"employeeID"] , d.selectedUser, [item objectForKey:@"jobName"], [jobList objectAtIndex:sender.tag]);
            if ([[item objectForKey:@"employeeID"] isEqualToString:d.selectedUser] && [[item objectForKey:@"jobName"] isEqualToString:[jobList objectAtIndex:sender.tag]]) {
                found = YES;
            }
        }
        
        if (found) {
            [d.hr_taskmanagement removeObjectAtIndex:sender.tag];
        }
    }
    
    // Remove from the table view
    [jobList removeObjectAtIndex:sender.tag];
    [taskTable reloadData];

}
@end
