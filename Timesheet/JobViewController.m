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
    NSMutableArray *taskList;
    int total;
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
    taskList = [[NSMutableArray alloc] init];
    taskList = [self.delegate getCurrentTaskList];
    
    /**********************/
    /*   SUP Connection   */
    /**********************/
    if (d.isSUPConnection) {
        HR_SuiteJobManagementList *resultList = [HR_SuiteJobManagement findAll];
   
        for (HR_SuiteJobManagement *item in resultList) {
              
            // filters to iterate through only the tasks assigned to selected user
            if ([item.employeeID isEqualToString:d.user])
            {
                
                
                // for each task, retrieve the job name
                HR_SuiteJobsList *jobsList = [HR_SuiteJobs findAll];
                for (HR_SuiteJobs *job in jobsList) {
                    BOOL found = NO;
                    if ([item.jobNumber isEqualToNumber:job.jobNumber]) {  
                        
                        
                        // when I get the job name, check to see if its in tasklist. if it isnt, find a way to add it into jobNamelist
                        for (NSDictionary *current in taskList) {
                            total++;
                            if ([job.jobName isEqualToString:[current objectForKey:@"taskName"]]) {
                                found = YES;
                                //break;
                            }
                            
                        }
                        
                        if (!found) {
                            [jobNameList addObject:job.jobName];
                        }
                        [self.delegate getTotalAssigned:total];
                        
                    }//inner if
                } //for           
        
            } //if
            
        }
        
        if ([jobNameList count] == 1) {
            [self.delegate setTaskListEmpty:YES];
            NSLog(@"EMPTY");
        }
        else {
            [self.delegate setTaskListEmpty:NO];
            NSLog(@"NOT EMPTY");
        }
    }
    
    /************/
    /*   DEMO   */
    /************/
    else {
//        for (NSDictionary *item in d.hr_taskmanagement) {  
//            bool found = NO;
//            NSLog(@"adsad");
//            for (NSDictionary *current in taskList) {
//                NSLog(@"aad");
//                if ([[current objectForKey:@"taskName"] isEqualToString:[item objectForKey:@"taskName"]] && [[item objectForKey:@"employeeID"] isEqualToString:d.user]) {
//                    found = YES;
//                }
//            }
//            
//            if (!found) {
//                [jobNameList addObject:[item objectForKey:@"taskName"]];
//            }
//        }

        [self.delegate getTotalAssigned:6];
        [jobNameList addObject:@"Meeting"];
        [jobNameList addObject:@"iOS Development"];
        [jobNameList addObject:@"Top Secret Project"];
        [jobNameList addObject:@"IR&D"];
        [jobNameList addObject:@"Client Project"];
        [jobNameList addObject:@"Android Development"];
        
        for (NSDictionary *item in taskList) {
            if ([[item objectForKey:@"taskName"] isEqualToString:@"Meeting"]) {
                [jobNameList removeObject:@"Meeting"];
            }
            else if ([[item objectForKey:@"taskName"] isEqualToString:@"iOS Development"]) {
                [jobNameList removeObject:@"iOS Development"];
            }
            else if ([[item objectForKey:@"taskName"] isEqualToString:@"Top Secret Project"]) {
                [jobNameList removeObject:@"Top Secret Project"];
            }
            else if ([[item objectForKey:@"taskName"] isEqualToString:@"IR&D"]) {
                [jobNameList removeObject:@"IR&D"];
            }
            else if ([[item objectForKey:@"taskName"] isEqualToString:@"Client Project"]) {
                [jobNameList removeObject:@"Client Project"];
            }
            else if ([[item objectForKey:@"taskName"] isEqualToString:@"Android Development"]) {
                [jobNameList removeObject:@"Android Development"];
            }
        }
        
        NSLog(@"options left: %i", [jobNameList count]);
        
        
        
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
    
    //check if all tasks were assigned
    if ([jobNameList count] == 1) {
        [self.delegate setTaskListEmpty:YES];
        NSLog(@"EMPTY");
    }
    else {
        [self.delegate setTaskListEmpty:NO];
        NSLog(@"NOT EMPTY");
    }
    
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




//For iPad -> changed to Cancel button
- (IBAction)clearJob:(id)sender {

    //[self.delegate setJobName:@"Touch to select task"];
    [[self.delegate getPopover] dismissPopoverAnimated:YES]; //Dismiss pop-over
}

@end
