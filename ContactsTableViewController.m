//
//  ContactsTableViewController.m
//  HRDirectory
//
//  Created by Alex Chiu on 8/8/12.
//  Copyright (c) 2012 Alex Chiu. All rights reserved.
//

#import "AppDelegate.h"
#import "ContactsTableViewController.h"
#import "SimpleNameCell.h"
#import "EmployeeDetailsViewController.h"
#import "HR_SuiteUsers.h"



@implementation ContactsTableViewController
{
    AppDelegate *d;
}

@synthesize btnAdd = _btnAdd;




//Loads nothing into tables at this point, list is loaded in viewDidAppear
- (void)viewDidLoad
{
    NSLog(@"%@ did load", [self class]);
    [super viewDidLoad];
    //[self startLoadingAnimations];
}



/****************************************************************************************************
 View Did Appear
 ****************************************************************************************************/
-(void)viewDidAppear:(BOOL)animated
{
    d = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    employeeArray = [[NSMutableArray alloc] init];
    
//    /**********************
//     * Add-allowing Check *
//     **********************/
//    NSString *user = [NSString stringWithString:d.username];
//    HR_SuiteUsers *tempEmployee = [HRDirectoryLogins findByPrimaryKey:user].employees;
//    //If this username is already linked to a database, disallowing adding
//    if(tempEmployee != nil)
//    {
//        self.btnAdd.hidden = YES;
//    }
//    
//    if(!d.isManager)
//    {
//        self.btnAdd.hidden = YES;
//    }
    
    
    //Loads the data from SUP after view appears
    //[self getDataFromSUP];
    
    //Where the table loading actually is
    //[table reloadData];

    //[self stopLoadingAnimations];

    //SUP
    if(d.isSUPConnection) {
        [self getDataFromSUP];
    }
    
    //DEMO
    else {
        NSLog(@"view did load demo");
        for (NSDictionary *item in d.hr_users) {
            [employeeArray addObject:item];
        }
    }
    
    [table reloadData];
}

- (void)viewDidUnload
{
    [self setBtnAdd:nil];
    [self setBtnAdd:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}




//#pragma mark - Table view data source
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return 1;
//}

/****************************************************************************************************
 Table View
 ****************************************************************************************************/
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [employeeArray count];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"EmployeeCell";
    SimpleNameCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    //Getting current index
    int index = indexPath.row;
    
    if (d.isSUPConnection) {
        //Configuring the cell
        cell.lblFirstName.text = [[employeeArray objectAtIndex:index]  firstName];
        cell.lblLastName.text = [[employeeArray objectAtIndex:index] lastName];
        cell.lblDepartment.text = [[employeeArray objectAtIndex:index] department];
    }
    
    else {
        NSLog(@"populate table for demo");
        cell.lblFirstName.text = [[employeeArray objectAtIndex:index] objectForKey:@"firstName"];
        cell.lblLastName.text = [[employeeArray objectAtIndex:index] objectForKey:@"lastName"];
        cell.lblDepartment.text = [[employeeArray objectAtIndex:index] objectForKey:@"department"];
    }
    
    return cell;
}


/****************************************************************************************************
 SUP Connection
 ****************************************************************************************************/
-(void)getDataFromSUP
{
    NSLog(@"Loading data from SUP...");
    
    
    HR_SuiteUsersList *employeeList = [HR_SuiteUsers findAll];
    
    if([employeeList length] > 0)
    {
        NSLog(@"Load successful. Length = %d", [employeeList length]);
        for(HR_SuiteUsers *persons in employeeList)
        {        
            [employeeArray addObject:persons];
        }
    }
    NSLog(@"Loaded %d entries", [employeeList length]);
}

//#pragma mark - Table view delegate
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//   //Don't need this
//}



/****************************************************************************************************
 Prepare for Segue
 ****************************************************************************************************/
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"DetailSegue"])
    {
        EmployeeDetailsViewController *edView = [segue destinationViewController];
        //Getting index of the cell selected
        UITableViewCell *cell = (UITableViewCell *)sender;
        NSIndexPath *indexPath = [table indexPathForCell:cell];
        
        //edView.thisEntry = [employeeArray objectAtIndex:[indexPath row]];
    }
}

@end
