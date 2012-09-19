//
//  OfflineSearchViewController.m
//  HRDirectory
//
//  Created by Alex Chiu on 9/18/12.
//  Copyright (c) 2012 Alex Chiu. All rights reserved.
//

#import "OfflineSearchViewController.h"
#import "SimpleNameCell.h"
#import "AppDelegate.h"
#import "OfflineEmployeeDetailsViewController.h"

@interface OfflineSearchViewController ()
{
    NSIndexPath *selectedIndex;
}

@end

@implementation OfflineSearchViewController
@synthesize searchBar;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    NSLog(@"%@ did load", [self class]);
    
    selectedSearchOption = @"firstname";
    
    [super viewDidLoad];
    
    //Keyboard notification listeners *Note has to be in viewDidLoad
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:self.view.window];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:self.view.window];
    
    [self startLoadingAnimations];
}

-(void)viewDidAppear:(BOOL)animated
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if(!appDelegate.isManager)
    {
        self.btnAdd.hidden = YES;
    }
    
    [self gettingData];
    
    displayEmployeeArray = [[NSMutableArray alloc] initWithArray:employeeArray];
    
    [table reloadData];
    
    [self stopLoadingAnimations];
}

- (void)viewDidUnload
{
    [self setSearchBar:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


-(void)gettingData
{
    AppDelegate *data = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    employeeArray = data.hr_users; //pointer, not copy
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"DetailSegue"])
    {
        OfflineEmployeeDetailsViewController *edView = [segue destinationViewController];
        //Getting index of the cell selected
        UITableViewCell *cell = (UITableViewCell *)sender;
        NSIndexPath *indexPath = selectedIndex;
        
        edView.thisEntry = [displayEmployeeArray objectAtIndex:[indexPath row]];
    }
}

- (IBAction)changeToggleSettings:(id)sender
{
    [self searchBar:self.searchBar textDidChange:self.searchBar.text];
}

- (IBAction)goBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Table view data source

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [displayEmployeeArray count];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"EmployeeCell";
    SimpleNameCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    //Getting current index
    int index = indexPath.row;
    
    cell.lblFirstName.text = [[displayEmployeeArray objectAtIndex:index] objectForKey:@"firstName"];
    cell.lblLastName.text = [[displayEmployeeArray objectAtIndex:index] objectForKey:@"lastName"];
    cell.lblDepartment.text = [[displayEmployeeArray objectAtIndex:index] objectForKey:@"department"];
    // Configure the cell...
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    selectedIndex = indexPath;
    [self performSegueWithIdentifier:@"DetailSegue" sender:self];
}

#pragma mark - UISearchBarDelegate
/*
 * Search bar function
 * Implementation of the search bar, called whenever search bar text is changed
 * Empties the displayEmployeeArray with every character types and fills it again with the appropriate results
 */
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
        
        for (NSDictionary *entry in employeeArray)
        {
            NSRange r;
            
            NSString *searchedString;
            
            //Checking to see which part to search (first name, last name, or position)
            switch ([toggleSegment selectedSegmentIndex])
            {
                case 0:
                    searchedString = [entry objectForKey:@"firstName"];
                    r = [searchedString rangeOfString:searchText options:NSCaseInsensitiveSearch];
                    break;
                case 1:
                    searchedString = [entry objectForKey:@"lastName"];
                    r = [searchedString rangeOfString:searchText options:NSCaseInsensitiveSearch];
                    break;
                case 2:
                    searchedString = [entry objectForKey:@"department"];
                    r = [searchedString rangeOfString:searchText options:NSCaseInsensitiveSearch];
                    break;
            }
            
            if(r.location != NSNotFound)
            {
                [displayEmployeeArray addObject:entry];
            }
        }
    }
    [table reloadData];
}

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

@end
