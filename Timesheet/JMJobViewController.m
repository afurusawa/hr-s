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
            
            BOOL found = NO;
            NSString *foundnumber = [item.jobNumber stringValue];
            NSString *foundname = item.jobName;
            
            HR_SuiteJobManagementList *jmlist = [HR_SuiteJobManagement findAll];
            for (HR_SuiteJobManagement *current in jmlist) {
                
                
                // If user and jobs do match set it as found
                if ([current.employeeID isEqualToString:d.selectedUser] && [current.jobNumber isEqualToNumber:item.jobNumber]) {
                    found = YES;
                    break;
                }
            }
            
            if (!found) {
                [jobNameList addObject:foundname];
                [jobNumberList addObject:foundnumber];
            }
        }
    } //end sup
    
    /************/
    /*   DEMO   */
    /************/
    else {
        for (NSDictionary *task in d.hr_tasks) {
            
            BOOL found = NO;
            for (NSDictionary *item in d.hr_taskmanagement) {
                if ([[item objectForKey:@"jobName"] isEqualToString:[task objectForKey:@"jobName"]] && [[item objectForKey:@"employeeID"] isEqualToString:d.selectedUser]) {
                    found = YES;
                    break;
                }
            }
            
            if (!found) {
                [jobNameList addObject:[task objectForKey:@"jobName"]];
                [jobNumberList addObject:[task objectForKey:@"jobNumber"]];
            }
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
    cell.textLabel.text = [jobNumberList objectAtIndex:indexPath.row];
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
