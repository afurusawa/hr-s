//
//  JMMemberViewController.m
//  Timesheet
//
//  Created by Rapid Consulting on 8/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "JMMemberViewController.h"
#import "AppDelegate.h"
#import "HR_SuiteUsers.h"
#import "MemberCell.h"
#import "HR_SuiteHR_SuiteDB.h"


@implementation JMMemberViewController
{
    AppDelegate *d;
    NSMutableArray *allData;
    NSMutableArray *filteredData;
    NSDictionary *entry;
    BOOL isFiltered;
}
@synthesize delegate;
@synthesize searchBar;
@synthesize employeeTable;



/****************************************************************************************************
 View Did Load
 ****************************************************************************************************/
- (void)viewDidLoad
{
    d = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    allData = [[NSMutableArray alloc] init];
    filteredData = [[NSMutableArray alloc] init];
    isFiltered = NO;
    
    /**********************/
    /*   SUP Connection   */
    /**********************/
    if (d.isSUPConnection) {
        
        // Populate array
        HR_SuiteUsersList *list = [HR_SuiteUsers findAll];
        for (HR_SuiteUsers *item in list) {
            
            if (![item.manager isEqualToString:d.user]) {
            entry = [NSDictionary dictionaryWithObjectsAndKeys:
                     item.department, @"department",
                     item.employeeName, @"name",
                     item.position, @"position",
                     nil];
            [allData addObject:entry];
            }
        }
    } //end sup
    
    
    /************/
    /*   DEMO   */
    /************/
    else {
        for (NSDictionary *item in d.hr_users) {
            
            if(![[item objectForKey:@"manager"] isEqualToString:d.user]) {
                entry = [NSDictionary dictionaryWithObjectsAndKeys:
                         [item objectForKey:@"department"], @"department",
                         [item objectForKey:@"employeeName"], @"name",
                         [item objectForKey:@"position"], @"position",
                         nil];
                [allData addObject:entry];
            }
            
            
        }
    } //end demo
    
    [self.employeeTable reloadData];
}

- (void)viewDidUnload
{
    [self setEmployeeTable:nil];
    [self setSearchBar:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


/****************************************************************************************************
 Search Bar
 ****************************************************************************************************/
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    if(searchText.length == 0) {
        isFiltered = FALSE;
    }
    else {
        isFiltered = true;
        filteredData = [[NSMutableArray alloc] init];
        
        for (NSDictionary *employee in allData) {
            NSRange departmentRange = [[employee objectForKey:@"department"] rangeOfString:searchText options:NSCaseInsensitiveSearch];
            NSRange nameRange = [[employee objectForKey:@"name"] rangeOfString:searchText options:NSCaseInsensitiveSearch];
            NSRange positionRange = [[employee objectForKey:@"position"] rangeOfString:searchText options:NSCaseInsensitiveSearch];
            
            // If result was found, add it
            if(nameRange.location != NSNotFound || departmentRange.location != NSNotFound || positionRange.location != NSNotFound) {
                [filteredData addObject:employee];
            }
        }
    }
    
    [self.employeeTable reloadData];
}



/****************************************************************************************************
 Table View
 ****************************************************************************************************/
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int rowCount;
    if(isFiltered)
        rowCount = filteredData.count;
    else
        rowCount = allData.count;
    
    return rowCount;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MemberCell";
    MemberCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
        cell = [[MemberCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    
    if(isFiltered) {
        cell.department.text = [[filteredData objectAtIndex:indexPath.row] objectForKey:@"department"];
        cell.name.text = [[filteredData objectAtIndex:indexPath.row] objectForKey:@"name"];
        cell.position.text = [[filteredData objectAtIndex:indexPath.row] objectForKey:@"position"];
    }
    else {
        cell.department.text = [[allData objectAtIndex:indexPath.row] objectForKey:@"department"];
        cell.name.text = [[allData objectAtIndex:indexPath.row] objectForKey:@"name"];
        cell.position.text = [[allData objectAtIndex:indexPath.row] objectForKey:@"position"];
    }

    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Find name of employee selected
    NSString *selectedEmployeeName;
    if (isFiltered) {
        selectedEmployeeName = [[filteredData objectAtIndex:indexPath.row] objectForKey:@"name"];
    }
    else {
        selectedEmployeeName = [[allData objectAtIndex:indexPath.row] objectForKey:@"name"];
    }
                  
    /**********************/
    /*   SUP Connection   */
    /**********************/
    if (d.isSUPConnection) {
        
        // Add member: find user to add and set manager for user
        HR_SuiteUsersList *list = [HR_SuiteUsers findAll];
        for (HR_SuiteUsers *item in list) {
            
            if ([item.manager isEqualToString:d.user] && [item.employeeName isEqualToString:selectedEmployeeName]) {
                // this employee is already on your team
            }
            else if ([item.employeeName isEqualToString:selectedEmployeeName]) {
                [item setManager:d.user];
                [item updateManager];
                [item submitPending];
                [HR_SuiteHR_SuiteDB synchronize:@"default"];
            }
        }
    } //end sup
    
    
    /************/
    /*   DEMO   */
    /************/
    else {
        for (int i = 0; i < [d.hr_users count]; i++) {
            if ([[[d.hr_users objectAtIndex:i] objectForKey:@"manager"] isEqualToString:d.user] && [[[d.hr_users objectAtIndex:i] objectForKey:@"employeeName"] isEqualToString:selectedEmployeeName]) {
                // this employee is already on your team
            }
            else if ([[[d.hr_users objectAtIndex:i] objectForKey:@"employeeName"] isEqualToString:selectedEmployeeName]) {
                entry = [NSDictionary dictionaryWithObjectsAndKeys:
                         [[d.hr_users objectAtIndex:i] objectForKey:@"employeeName"], @"employeeName",
                         [[d.hr_users objectAtIndex:i] objectForKey:@"employeeID"], @"employeeID",
                         [[d.hr_users objectAtIndex:i] objectForKey:@"password"], @"password",
                         [[d.hr_users objectAtIndex:i] objectForKey:@"department"], @"department",
                         @"manager", @"manager",
                         [[d.hr_users objectAtIndex:i] objectForKey:@"position"], @"position",
                         [[d.hr_users objectAtIndex:i] objectForKey:@"address"], @"address",
                         [[d.hr_users objectAtIndex:i] objectForKey:@"email"], @"email",
                         [[d.hr_users objectAtIndex:i] objectForKey:@"phone"], @"phone", 
                         nil];
                [d.hr_users replaceObjectAtIndex:i withObject:entry];
            }
        }
    }
    
    [self.delegate refreshViewForMembers];
    [self.navigationController popViewControllerAnimated:YES];
}


@end
