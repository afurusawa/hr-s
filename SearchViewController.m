//
//  SearchViewController.m
//  HRDirectory
//
//  Created by Alex Chiu on 8/8/12.
//  Copyright (c) 2012 Alex Chiu. All rights reserved.
//

#import "AppDelegate.h"
#import "SearchViewController.h"
#import "SimpleNameCell.h"
#import "EmployeeDetailsViewController.h"
#import "HR_SuiteUsers.h"

@interface SearchViewController ()

@end

@implementation SearchViewController
{
    AppDelegate *appDelegate;
}
@synthesize btnAdd = _btnAdd;
@synthesize searchBar;

//protocol
- (void)refreshView
{
    
}

//view did load
//loads the ui stuff like keyboard moving and loading animation
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Keyboard notification listeners *Note has to be in viewDidLoad
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:self.view.window];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:self.view.window];
    
   [self startLoadingAnimations];
}

- (void)viewDidUnload
{
    table = nil;
    toggleSegment = nil;
    [self setBtnAdd:nil];
    [self setSearchBar:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

-(void)viewDidAppear:(BOOL)animated
{
    // Initialization
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    employeeArray = [[NSMutableArray alloc] init]; //this stores all employees
    
    
    // Manager Privileges
    if(!appDelegate.manager) {
        self.btnAdd.hidden = YES; //managers can add new employees
    }
    
    
    //SUP
    if (appDelegate.isSUPConnection) {
        
        // Filter
        HR_SuiteUsersList *employeeList = [HR_SuiteUsers findAll];
        
        // Populate array if results were found
        if([employeeList length] > 0) {
            for(HR_SuiteUsers *persons in employeeList) {
                [employeeArray addObject:persons];
            }
        }
    }
    
    //Demo
    else {
        
        // Populate array
        for (NSDictionary *item in appDelegate.hr_users) {
            [employeeArray addObject:item];
        }
    }
    
    displayEmployeeArray = [[NSMutableArray alloc] initWithArray:employeeArray]; //this stores all filtered employees according to the search parameters
    [table reloadData];
    
    // Done loading
    [self stopLoadingAnimations];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}




// number of rows for table
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [displayEmployeeArray count];
}


// populate cells
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"EmployeeCell";
    SimpleNameCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    //Getting current index
    int index = indexPath.row;
    
    if (appDelegate.isSUPConnection) {
        cell.lblFirstName.text = [[displayEmployeeArray objectAtIndex:index] firstName];
        cell.lblLastName.text = [[displayEmployeeArray objectAtIndex:index] lastName];
        cell.lblDepartment.text = [[displayEmployeeArray objectAtIndex:index] department];
    }
    
    else {
        cell.lblFirstName.text = [[displayEmployeeArray objectAtIndex:index] objectForKey:@"firstName"];
        cell.lblLastName.text = [[displayEmployeeArray objectAtIndex:index] objectForKey:@"lastName"];
        cell.lblDepartment.text = [[displayEmployeeArray objectAtIndex:index] objectForKey:@"department"];
    }
    
    return cell;
}


// row selected
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (appDelegate.isSUPConnection) {
        appDelegate.selectedUser = [[displayEmployeeArray objectAtIndex:indexPath.row] employeeID];
    }
    else {
        appDelegate.selectedUser = [[displayEmployeeArray objectAtIndex:indexPath.row] objectForKey:@"employeeID"];
    }
    NSLog(@"storing user = %@", appDelegate.selectedUser);
    [self performSegueWithIdentifier:@"DetailSegue" sender:self];
}


//-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    if([[segue identifier] isEqualToString:@"DetailSegue"])
//    {
//        EmployeeDetailsViewController *edView = [segue destinationViewController];
//        //Getting index of the cell selected
//        UITableViewCell *cell = (UITableViewCell *)sender;
//        NSIndexPath *indexPath = [table indexPathForCell:cell];
//        
//        //edView.thisEntry = [displayEmployeeArray objectAtIndex:[indexPath row]];
//    }
//}




#pragma mark - UISearchBarDelegate
/*
 * Search bar function
 * Implementation of the search bar, called whenever search bar text is changed
 * Empties the displayEmployeeArray with every character types and fills it again with the appropriate results
 */

/****************************************************************************************************
 Search Bar
 ****************************************************************************************************/
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{  
    if([searchText length] == 0)
    {
        //Refill the display array to everything
        [displayEmployeeArray removeAllObjects];
        [displayEmployeeArray addObjectsFromArray:employeeArray];
    }
    else
    {
        [displayEmployeeArray removeAllObjects];
        
        //sup
        if (appDelegate.isSUPConnection) {
            for (HR_SuiteUsers *entry in employeeArray)
            {
                NSRange r;
                
                //Checking to see which part to search (first name, last name, or position)
                switch ([toggleSegment selectedSegmentIndex])
                {
                    case 0:
                        r = [entry.firstName rangeOfString:searchText options:NSCaseInsensitiveSearch];
                        break;
                    case 1:
                        r = [entry.lastName rangeOfString:searchText options:NSCaseInsensitiveSearch];
                        break;
                    case 2:
                        r = [entry.department rangeOfString:searchText options:NSCaseInsensitiveSearch];
                        break;
                }
                
                if(r.location != NSNotFound)
                {
                    [displayEmployeeArray addObject:entry];
                }
            }
        }
        
        //demo
        else {
            for (NSDictionary *entry in employeeArray) {
                NSRange r;
                
                //Checking to see which part to search (first name, last name, or position)
                switch ([toggleSegment selectedSegmentIndex])
                {
                    case 0:
                        r = [[entry objectForKey:@"firstName"] rangeOfString:searchText options:NSCaseInsensitiveSearch];
                        break;
                    case 1:
                        r = [[entry objectForKey:@"lastName"] rangeOfString:searchText options:NSCaseInsensitiveSearch];
                        break;
                    case 2:
                        r = [[entry objectForKey:@"position"] rangeOfString:searchText options:NSCaseInsensitiveSearch];
                        break;
                }
                
                if(r.location != NSNotFound)
                {
                    [displayEmployeeArray addObject:entry];
                }

            }
        }
    }
    [table reloadData];
}





/****************************************************************************************************
 UI stuff
 ****************************************************************************************************/

-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    //When editing begins, cancel button will display
    self.searchBar.showsCancelButton = YES;
    return YES;
}

/*
 * When Cancel Button is clicked it will
 * 1. Resign the keyboard
 * 2. Empty the search bar
 * 3. Reload all entries of the list
 */
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self.searchBar resignFirstResponder];
    self.searchBar.text = @"";
    [self searchBar:self.searchBar textDidChange:@""];
    self.searchBar.showsCancelButton = NO;
}






/* Selector for when the keyboard appears
 * Will shrink the view size so user can scroll to look at their data on the shrunken view
 */
-(void)keyboardWillShow:(NSNotification *)n
{
    if(!keyboardShown)
    {
        NSLog(@"Keyboard will show");
        
        NSDictionary *userInfo = [n userInfo];
        
        //Get the size of the keyboard
        CGSize keyboardSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
        
        //Resize the view
        CGRect viewFrame = self.view.frame; //I used View instead of ScrollView
        viewFrame.size.height -= keyboardSize.height;
        
        //Animations
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:.3];
        
        [self.view setFrame:viewFrame];
        
        [UIView commitAnimations];
        
        keyboardShown = YES;
    }
}

/* Selector for when the keyboard hides
 * Will enlarge the view to normal when the keyboard is no longer taking up part of the screen
 */
-(void)keyboardWillHide:(NSNotification *)n
{
    if(keyboardShown)
    {
        NSLog(@"Keyboard will hide");
        
        NSDictionary *userInfo = [n userInfo];
        
        //Getting size of the keyboard
        CGSize keyboardSize = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
        
        //Getting new frame
        CGRect newFrameSize = self.view.frame;
        newFrameSize.size.height += keyboardSize.height;
        
        //Animations
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:.3];
        
        //Setting the new frame size
        [self.view setFrame:newFrameSize];
        
        [UIView commitAnimations];
        
        keyboardShown = NO;
    }
}






@end
