//
//  iPhoneOfflineSearchViewController.m
//  HRDirectory
//
//  Created by Alex Chiu on 9/19/12.
//  Copyright (c) 2012 Alex Chiu. All rights reserved.
//

#import "iPhoneOfflineSearchViewController.h"
#import "SimpleNameCell.h"
#import "AppDelegate.h"

@interface iPhoneOfflineSearchViewController ()

@end

@implementation iPhoneOfflineSearchViewController

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
    
    appDelegate.isManager = appDelegate.manager == 0;
    if(appDelegate.manager == 1) //1 is not a manager
    {
        self.btnAdd.hidden = YES;
    }
    
    [self gettingData];
    
    //Sorting the employeeArray
    NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:@"firstName" ascending:YES];
    employeeArray = [NSMutableArray arrayWithArray:[employeeArray sortedArrayUsingDescriptors:[NSArray arrayWithObjects:descriptor,nil]]];
    
    displayEmployeeArray = [[NSMutableArray alloc] initWithArray:employeeArray];
    
    [table reloadData];
    
    [self stopLoadingAnimations];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


-(void)gettingData
{
    AppDelegate *singleton = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    employeeArray = singleton.hr_users; //pointer, not copy
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"DetailSegue"])
    {
        OfflineEmployeeDetailsViewController *edView = [segue destinationViewController];
        //Getting index of the cell selected
        UITableViewCell *cell = (UITableViewCell *)sender;
        NSIndexPath *indexPath = [table indexPathForCell:cell];
        
        edView.thisEntry = [displayEmployeeArray objectAtIndex:[indexPath row]];
        
        //Resigns keyboard when pushing to the next view. Fixes graphical glitches
        [self.searchBar resignFirstResponder];
        self.searchBar.text = @"";
        self.searchBar.showsCancelButton = NO;
    }
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
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    //Getting current index
    int index = indexPath.row;
    
    NSString *fName = [[displayEmployeeArray objectAtIndex:index] objectForKey:@"firstName"];
    NSString *lName = [[displayEmployeeArray objectAtIndex:index] objectForKey:@"lastName"];
    NSString *displayName = [NSString stringWithFormat:@"%@, %@", lName, fName];
    
    cell.textLabel.text = displayName;
    cell.detailTextLabel.text = [[displayEmployeeArray objectAtIndex:index] objectForKey:@"department"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Nothing needed here yet
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

            //Checks everything at once as opposed to the ipad version.
            NSString *fName = [entry objectForKey:@"firstName"];
            NSString *lName = [entry objectForKey:@"lastName"];
            NSString *dept = [entry objectForKey:@"department"];
            NSString *combined = [NSString stringWithFormat:@"%@ %@ %@", fName, lName, dept];
            
            //Searchin the first name, last name, and department
            r = [combined rangeOfString:searchText options:NSCaseInsensitiveSearch];
            
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