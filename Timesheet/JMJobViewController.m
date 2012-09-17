//
//  JobViewController.m
//  Timesheet
//
//  Created by Andrew Furusawa on 7/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "JMJobViewController.h"
#import "AppDelegate.h"

#import "HR_SuiteJobManagement.h"
#import "HR_SuiteHR_SuiteDB.h"
#import "HR_SuiteJobs.h"

@implementation JMJobViewController
{
    AppDelegate *d;
    NSDictionary *entry;
}

@synthesize delegate;
@synthesize jobTable;

/****************************************************************************************************
 View Did Load
 ****************************************************************************************************/
-(void)viewDidLoad
{
    // Initializations
    d = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    jobNameList = [[NSMutableArray alloc] init];
    jobNumberList = [[NSMutableArray alloc] init];
    
    
    /**********************/
    /*   SUP Connection   */
    /**********************/
    if (d.isSUPConnection) {

        HR_SuiteJobsList *list = [HR_SuiteJobs findAll];
        for (HR_SuiteJobs *item in list) {
            [jobNameList addObject:item.jobName];
            [jobNumberList addObject:item.jobNumber];
        }
    } //end sup
    
    /************/
    /*   DEMO   */
    /************/
    else {
        for (NSDictionary *task in d.hr_tasks) {
            [jobNameList addObject:[task objectForKey:@"jobName"]];
            [jobNumberList addObject:[NSNumber numberWithInt:[[task objectForKey:@"jobNumber"] intValue]]];
        }

    } //end demo
    
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
 Table View Methods
 ****************************************************************************************************/
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [jobNameList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"TaskCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if([jobNameList objectAtIndex:indexPath.row] != 0) {
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    
    // Configure the cell...
    cell.textLabel.text = [[jobNumberList objectAtIndex:indexPath.row] stringValue];
    cell.detailTextLabel.text = [jobNameList objectAtIndex:indexPath.row];
    
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    // iPhone version
    if (tableView.tag == 2) {
        /**********************/
        /*   SUP Connection   */
        /**********************/
        if (d.isSUPConnection) {
            
            // Add tasks for employee
            HR_SuiteJobManagement *temp = [[HR_SuiteJobManagement alloc] init];
            
            [temp setEmployeeID:d.selectedUser];
            NSInteger jn = [[jobNumberList objectAtIndex:indexPath.row] intValue];
            [temp setJobNumber:[NSNumber numberWithInt:jn]];
            [temp create];
            [temp submitPending];
            [HR_SuiteHR_SuiteDB synchronize:@"default"];
            
            [self.delegate refresh];
            [self.navigationController popViewControllerAnimated:YES];
        } //end sup
        
        
        /************/
        /*   DEMO   */
        /************/
        else {
            
            entry = [NSDictionary dictionaryWithObjectsAndKeys:
                     d.selectedUser, @"employeeID",
                     [jobNameList objectAtIndex:indexPath.row], @"jobName", 
                     [jobNumberList objectAtIndex:indexPath.row], @"jobNumber", 
                     nil];
            [d.hr_taskmanagement addObject:entry];
            [self.delegate refresh];
            [self.navigationController popViewControllerAnimated:YES];
        } //end demo
        

    }
    
    // iPad version
    else {
        
    
        if(tableView == jobTable)
        {
            
            /**********************/
            /*   SUP Connection   */
            /**********************/
            if (d.isSUPConnection) {
                
                // Add tasks for employee
                HR_SuiteJobManagement *temp = [[HR_SuiteJobManagement alloc] init];
                
                [temp setEmployeeID:d.selectedUser];
                NSInteger jn = [[jobNumberList objectAtIndex:indexPath.row] intValue];
                [temp setJobNumber:[NSNumber numberWithInt:jn]];
                [temp create];
                [temp submitPending];
                [HR_SuiteHR_SuiteDB synchronize:@"default"];
                
                [self.delegate refreshViewForTasks];
                [self.navigationController popViewControllerAnimated:YES];
            } //end sup
            
            
            /************/
            /*   DEMO   */
            /************/
            else {
                
                entry = [NSDictionary dictionaryWithObjectsAndKeys:
                         d.selectedUser, @"employeeID",
                         [jobNameList objectAtIndex:indexPath.row], @"jobName", 
                         [jobNumberList objectAtIndex:indexPath.row], @"jobNumber", 
                         nil];
                [d.hr_taskmanagement addObject:entry];
                [self.delegate refreshViewForTasks];
                [self.navigationController popViewControllerAnimated:YES];
            } //end demo
            
        } //end if
    } //end else
}



@end
