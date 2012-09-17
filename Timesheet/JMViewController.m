//
//  JMViewController.m
//  Timesheet
//
//  Created by Jun on 7/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "JMViewController.h"
#import "AppDelegate.h"
#import "JMCell.h"
#import "TeamMemberCell.h"

#import "HR_SuiteJobManagement.h"
#import "HR_SuiteJobs.h"
#import "HR_SuiteUsers.h"
#import "HR_SuiteHR_SuiteDB.h"

@interface JMViewController ()

@end

@implementation JMViewController
{
    AppDelegate *d;
    NSDictionary *entry;
    NSInteger jobListItemIndex; //stores the index of the job selected.
    
    NSInteger selectedMemberIndex;
}
@synthesize addTaskButton;
@synthesize addTeamMemberButton;
@synthesize selectTeamMemberLabel;
@synthesize indicator;
@synthesize assignTaskLabel;
@synthesize workerTable;
@synthesize jobTable;
//@synthesize delegate;

/****************************************************************************************************
 Protocol Methods
 ****************************************************************************************************/
- (NSString *)getJobName
{
    return jobName;
}
- (UIPopoverController *)getPopover
{
    return popover;
}

/* Returns the list of jobs for the selected user. */
- (void)refreshViewForMembers
{   
    // iPhone version
    if (workerTable.tag == 2) {
        
    }
    
    // iPad version
    else {
        // Pre-animation settings
        
        // Set full width at bottom
        //addTeamMemberButton.frame = CGRectMake(0, self.view.frame.size.height - 40, self.view.frame.size.width, 40);
        // Half the screen too
        
        // Set fullscreen with 40px padding top and bottom
        workerTable.frame = CGRectMake(0, 50, self.view.frame.size.width, self.view.frame.size.height - 100);
        
        // Set half-width off-screen
        jobTable.frame = CGRectMake(self.view.frame.size.width, 50, self.view.frame.size.width/2, self.view.frame.size.height - 80);
        
        // Set half-width
        [addTaskButton setCenter:CGPointMake(self.view.frame.size.width - self.view.frame.size.width/4, self.view.frame.size.height + 20)];
        
        // Set assign task label off-screen
        assignTaskLabel.frame = CGRectMake(assignTaskLabel.frame.origin.x, -40, assignTaskLabel.frame.size.width, assignTaskLabel.frame.size.height);
        
        addTeamMemberButton.frame = CGRectMake(addTeamMemberButton.frame.origin.x, addTeamMemberButton.frame.origin.y, self.view.frame.size.width, addTeamMemberButton.frame.size.height);
    }
    
    
    workerList = [[NSMutableArray alloc] init];
    nameList = [[NSMutableArray alloc] init];

    
    /**********************/
    /*   SUP Connection   */
    /**********************/
    if (d.isSUPConnection) {
        
        //populate workerlist
        HR_SuiteUsersList *list = [HR_SuiteUsers findAll];
        for (HR_SuiteUsers *item in list) {
            if ([item.manager isEqualToString:d.user]) {
                [workerList addObject:item.employeeID];
                [nameList addObject:item.employeeName];
            }
        }
    } //end sup
    
    
    /************/
    /*   DEMO   */
    /************/
    else {
        for (NSDictionary *item in d.hr_users) {
            if ([[item objectForKey:@"manager"] isEqualToString:@"gandalf"]) {
                [workerList addObject:[item objectForKey:@"employeeID"]];
                [nameList addObject:[item objectForKey:@"employeeName"]];
            }
        }
        
    } //end demo

    [self.workerTable reloadData];
}

/* Returns the list of jobs for the selected user. */
- (void)refreshViewForTasks
{   
    
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
    
    [self.jobTable reloadData];
}



/****************************************************************************************************
 View Did Load
 ****************************************************************************************************/
- (void)viewDidLoad
{
    // Initializations
    d = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    workerList = [[NSMutableArray alloc] init];
    nameList = [[NSMutableArray alloc] init];
    d.selectedUser = nil;
    
    // iPhone version
    if (workerTable.tag == 2) {
        // Don't configure components for animation
    }
    
    // iPad version
    else {
        // Pre-animation settings
        
        // Set full width at bottom
        //addTeamMemberButton.frame = CGRectMake(0, self.view.frame.size.height - 40, self.view.frame.size.width, 40);
        // Half the screen too
        
        // Set fullscreen with 40px padding top and bottom
        workerTable.frame = CGRectMake(0, 50, self.view.frame.size.width, self.view.frame.size.height - 100);
        
        // Set half-width off-screen
        jobTable.frame = CGRectMake(self.view.frame.size.width, 50, self.view.frame.size.width/2, self.view.frame.size.height - 100);
        
        // Set half-width
        [addTaskButton setCenter:CGPointMake(self.view.frame.size.width - self.view.frame.size.width/4, self.view.frame.size.height + 20)];
        
        // Set assign task label off-screen
        assignTaskLabel.frame = CGRectMake(assignTaskLabel.frame.origin.x, -40, assignTaskLabel.frame.size.width, assignTaskLabel.frame.size.height);
    }
    
    
    /**********************/
    /*   SUP Connection   */
    /**********************/
    if (d.isSUPConnection) {
        
        //populate workerlist
        HR_SuiteUsersList *list = [HR_SuiteUsers findAll];
        for (HR_SuiteUsers *item in list) {
            if ([item.manager isEqualToString:d.user]) {
                [workerList addObject:item.employeeID];
                [nameList addObject:item.employeeName];
            }
        }
    } //end sup
    
    /************/
    /*   DEMO   */
    /************/
    else {
        //[d createHRUsers];
        for (NSDictionary *item in d.hr_users) {
            if ([[item objectForKey:@"manager"] isEqualToString:@"gandalf"]) {
                [workerList addObject:[item objectForKey:@"employeeID"]];
                [nameList addObject:[item objectForKey:@"employeeName"]];
            }
        }
    } //end demo
}

- (void)viewDidUnload
{
    [self setWorkerTable:nil];
    [self setJobTable:nil];
    [self setAddTaskButton:nil];
    [self setSelectTeamMemberLabel:nil];
    [self setIndicator:nil];
    [self setAddTeamMemberButton:nil];
    [self setAssignTaskLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

// Sets the height of cells for all tables
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

/****************************************************************************************************
 Table View
 ****************************************************************************************************/
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger numberOfRows = 0;
    if(tableView == workerTable) {
        numberOfRows = [workerList count];
    }
    else if (tableView == jobTable) {
        numberOfRows = [jobList count];
    }
    return numberOfRows;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *resultCell;
    
    // Populates the workerTable with...
    if(tableView == workerTable) {
        static NSString *CellIdentifier = @"WorkerCell";
        TeamMemberCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        // Configure the cell...
        cell.name.text = [nameList objectAtIndex:indexPath.row];
        cell.deleteButton.tag = indexPath.row;
        resultCell = cell;
    }
    
    // Populates the jobTable with...
    else if (tableView == jobTable) {
        static NSString *CellIdentifier = @"JobCell";
        JMCell *jmcell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        // Configure the cell...
        jmcell.selectionStyle = UITableViewCellSelectionStyleNone;
        jmcell.jobNameLabel.text = [jobList objectAtIndex:indexPath.row];
        jmcell.removeButton.tag = indexPath.row;
        resultCell = jmcell;
    }
    
    return resultCell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //An item in the team members table was selected, so 
    if(tableView == workerTable) {
        
        // iPhone version
        if (tableView.tag == 2) {
            d.selectedUser = [workerList objectAtIndex:indexPath.row];
            d.employeeName = [nameList objectAtIndex:indexPath.row];
            [self performSegueWithIdentifier:@"toMemberView" sender:self];
        }
        
        // iPad version
        else {
            
            if ([d.selectedUser isEqualToString:[workerList objectAtIndex:indexPath.row]]) {
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:0.5f];
                NSLog(@"DESELECTING");
                // Pre-animation settings
                
                // Set full width at bottom
                //addTeamMemberButton.frame = CGRectMake(0, self.view.frame.size.height - 40, self.view.frame.size.width, 40);
                // Half the screen too
                
                // Set fullscreen with 40px padding top and bottom
                workerTable.frame = CGRectMake(0, 50, self.view.frame.size.width, self.view.frame.size.height - 100);
                
                // Set half-width off-screen
                jobTable.frame = CGRectMake(self.view.frame.size.width, 50, self.view.frame.size.width/2, self.view.frame.size.height - 100);
                
                // Set half-width
                [addTaskButton setCenter:CGPointMake(self.view.frame.size.width - self.view.frame.size.width/4, self.view.frame.size.height + 20)];
                
                // Set assign task label off-screen
                assignTaskLabel.frame = CGRectMake(assignTaskLabel.frame.origin.x, -40, assignTaskLabel.frame.size.width, assignTaskLabel.frame.size.height);
                
                addTeamMemberButton.frame = CGRectMake(addTeamMemberButton.frame.origin.x, addTeamMemberButton.frame.origin.y, self.view.frame.size.width, addTeamMemberButton.frame.size.height);
                
                [UIView commitAnimations];
                
                d.selectedUser = @"";
            }
            else {
                // Pre-animation settings
                
                // Set full width at bottom
                //addTeamMemberButton.frame = CGRectMake(0, self.view.frame.size.height - 40, self.view.frame.size.width, 40);
                // Half the screen too
                
                // Set fullscreen with 40px padding top and bottom
                workerTable.frame = CGRectMake(0, 50, self.view.frame.size.width, self.view.frame.size.height - 100);
                
                // Set half-width off-screen
                jobTable.frame = CGRectMake(self.view.frame.size.width, 50, self.view.frame.size.width/2, self.view.frame.size.height - 100);
                
                // Set half-width
                [addTaskButton setCenter:CGPointMake(self.view.frame.size.width - self.view.frame.size.width/4, self.view.frame.size.height + 20)];
                
                // Set assign task label off-screen
                assignTaskLabel.frame = CGRectMake(assignTaskLabel.frame.origin.x, -40, assignTaskLabel.frame.size.width, assignTaskLabel.frame.size.height);
                
                
                /****************************************************************************************************
                 Animation
                 ****************************************************************************************************/
                // Ending point animation settings
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:0.5f];
                
                // Half the screen
                workerTable.frame = CGRectMake(workerTable.frame.origin.x, workerTable.frame.origin.y, self.view.frame.size.width/2, self.view.frame.size.height);
                
                // Half the screen too
                addTeamMemberButton.frame = CGRectMake(addTeamMemberButton.frame.origin.x, addTeamMemberButton.frame.origin.y, self.view.frame.size.width/2, addTeamMemberButton.frame.size.height);
                
                // Slide in task list
                [jobTable setCenter:CGPointMake(self.view.frame.size.width - self.view.frame.size.width/4, self.view.frame.size.height/2)];
                
                // Roll up button
                [addTaskButton setCenter:CGPointMake(self.view.frame.size.width - self.view.frame.size.width/4, self.view.frame.size.height -19)];
                
                // Roll down label
                assignTaskLabel.frame = CGRectMake(assignTaskLabel.frame.origin.x, 20, assignTaskLabel.frame.size.width, assignTaskLabel.frame.size.height);
                
                // Start Animation
                [UIView commitAnimations];
                /****************************************************************************************************
                 ****************************************************************************************************/
                
                //store the team member
                d.selectedUser = [workerList objectAtIndex:indexPath.row];
                
            }
            
            //selectTeamMemberLabel.hidden = YES;
            //jobTable.hidden = NO;
            //addTaskButton.hidden = NO;
            
            
            
            //initialize
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
            }
            
            [self.jobTable reloadData];
            
            
        } //end iPad version
        
    
    }
    
    
    else if (tableView == jobTable) {
        // Selecting from task list doesn't do anything.
    }

}



- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}


/*
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if(editingStyle == UITableViewCellEditingStyleDelete)
    {
        // Remove item in database as well. Changes will be displayed when the view is reloaded
        HR_SuiteJobManagementList *list = [HR_SuiteJobManagement findAll];
        for (HR_SuiteJobManagement *item in list) {
            
            // Filter: current employee
            if ([item.employeeID isEqualToString:d.selectedUser]) {
                
                HR_SuiteJobsList *jl = [HR_SuiteJobs findAll];
                for (HR_SuiteJobs *ji in jl) {
                    
                    // Find job name for the task to remove 
                    if ([item.jobNumber isEqualToNumber:ji.jobNumber]) {
                        
                        if ([ji.jobName isEqualToString:[jobList objectAtIndex:jobListItemIndex]]) {
                            NSLog(@"deleting task: %i", [item.jobNumber intValue]);
                            [item delete];
                            [item submitPending];
                            [HR_SuiteHR_SuiteDB synchronize];
                        }
                        
                    }
                }
                
            } //if
        } //for
        
        // Remove from the table view
        [jobList removeObjectAtIndex:jobListItemIndex];
        [jobTable reloadData];
    }
}
*/



/****************************************************************************************************
 Prepare Segue and Set Delegate
 ****************************************************************************************************/
- (void) prepareForSegue:(UIStoryboardPopoverSegue *)segue sender:(id)sender {
    
    // iPhone version
    if (workerTable.tag == 2) {
        if ([segue.identifier isEqualToString:@"toDirectory"]) {
            NSLog(@"huzzah!");
            JMMemberViewController *mView = [segue destinationViewController];
            mView.delegate = (id)self;
        }
    }
    
    // iPad version
    else {
        if ([segue.identifier isEqualToString:@"toJMJobView"]) {
            
            JMJobViewController *jobView = [segue destinationViewController];
            jobView.delegate = self;
        }
        
        else {
            JMMemberViewController *mView = [segue destinationViewController];
            mView.delegate = (id)self;
        }
    }
}



/****************************************************************************************************
 Remove Task
 ****************************************************************************************************/
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
    [jobTable reloadData];
}



/****************************************************************************************************
 Remove Team Member
 ****************************************************************************************************/
- (IBAction)removeTeamMember:(UIButton *)sender {
    // Find name of employee selected
    TeamMemberCell *cell = (TeamMemberCell *)[self.workerTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:sender.tag inSection:0]];
    NSString *selectedEmployeeName = cell.name.text;

    /**********************/
    /*   SUP Connection   */
    /**********************/
    if (d.isSUPConnection) {
        
        // Add member: find user to add and set manager for user
        HR_SuiteUsersList *list = [HR_SuiteUsers findAll];
        for (HR_SuiteUsers *item in list) {
            
            if ([item.manager isEqualToString:d.user] && [item.employeeName isEqualToString:selectedEmployeeName]) {
                [item setManager:@""];
                [item updateManager];
                [item submitPending];
                [HR_SuiteHR_SuiteDB synchronize:@"default"];
            }
            
        }
    }
    
    /************/
    /*   DEMO   */
    /************/
    else {
        for (int i = 0; i < [d.hr_taskmanagement count]; i++) {
            if ([[[d.hr_taskmanagement objectAtIndex:i] objectForKey:@"manager"] isEqualToString:d.user] && [[[d.hr_taskmanagement objectAtIndex:i] objectForKey:@"employeeName"] isEqualToString:selectedEmployeeName]) {
                entry = [NSDictionary dictionaryWithObjectsAndKeys:
                         [[d.hr_taskmanagement objectAtIndex:i] objectForKey:@"employeeName"], @"employeeName",
                         [[d.hr_taskmanagement objectAtIndex:i] objectForKey:@"employeeID"], @"employeeID",
                         [[d.hr_taskmanagement objectAtIndex:i] objectForKey:@"password"], @"password",
                         [[d.hr_taskmanagement objectAtIndex:i] objectForKey:@"department"], @"department",
                         @"", @"manager",
                         [[d.hr_taskmanagement objectAtIndex:i] objectForKey:@"position"], @"position",
                         @"", @"location",
                         @"", @"email",
                         @"", @"phone", 
                         nil];
                [d.hr_taskmanagement replaceObjectAtIndex:i withObject:entry];
            }
        }
    }
    
    [workerList removeObjectAtIndex:sender.tag];
    [nameList removeObjectAtIndex:sender.tag];
    [self.workerTable reloadData];
}



@end
