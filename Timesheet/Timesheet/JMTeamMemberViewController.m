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
@synthesize taskTable, navbar, memberNameLabel;



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
    
    //bg
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"ts-bg-bg.png"]]];
    
    //navbar title bg
    [navbar setBackgroundImage:[UIImage imageNamed:@"ts.topappbar-bg.png"] forBarMetrics:UIBarMetricsDefault];
    
    //bg for table
    [taskTable setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"ts-bg-bg.png"]]];
    
    //set fonts
    [memberNameLabel setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:14]];
    
    
    //self.navigationItem.title = d.employeeName;
    NSLog(@"member name: %@", d.employeeName);
    memberNameLabel.text = d.employeeName;
    
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
    [self setNavbar:nil];
    [self setMemberNameLabel:nil];
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
    
    
    //separator color
    double rgb = 230.0/255.0;
    tableView.separatorColor = [UIColor colorWithRed:rgb green:rgb blue:rgb alpha:1];
    
    int eyeball = 20;
    [cell.textLabel setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:eyeball]];
    //text color when highlighted
    cell.textLabel.highlightedTextColor = [UIColor colorWithRed:42/255.0 green:106/255.0 blue:136/255.0 alpha:1];
    
    UIView *selectionColor = [[UIView alloc] init];
    selectionColor.backgroundColor = [UIColor colorWithRed:(228/255.0) green:(244/255.0) blue:(248/255.0) alpha:1];
    cell.selectedBackgroundView = selectionColor;

    
    // Configure the cell...
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.jobNameLabel.text = [jobList objectAtIndex:indexPath.row];
    cell.removeButton.tag = indexPath.row;
    
    return cell;
}





- (IBAction)removeTask:(UIButton *)sender {
    [LoadingScreen startLoadingScreenWithView:self.view];
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
                            [HR_SuiteHR_SuiteDB synchronize];
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
    [LoadingScreen stopLoadingScreenWithView:self.view];
    // Remove from the table view
    [jobList removeObjectAtIndex:sender.tag];
    [taskTable beginUpdates];
    [taskTable deleteRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:sender.tag inSection:0]] withRowAnimation:UITableViewRowAnimationLeft];
    [taskTable endUpdates];
    [taskTable reloadData];

}
- (IBAction)goBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
