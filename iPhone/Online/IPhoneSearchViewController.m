//
//  IPhoneSearchViewController.m
//  HRDirectory
//
//  Created by Alex Chiu on 9/7/12.
//  Copyright (c) 2012 Alex Chiu. All rights reserved.
//

#import "IPhoneSearchViewController.h"

#import "SimpleNameCell.h"
#import "IPhoneEmployeeDetailsViewController.h"
#import "HR_SuiteUsers.h"

@interface IPhoneSearchViewController ()

@end

@implementation IPhoneSearchViewController

@synthesize btnAdd = _btnAdd;
@synthesize searchBar = _searchBar;

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
    [super viewDidLoad];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    /**********************
     * Add-allowing Check *
     **********************/
    appDelegate.isManager = appDelegate.manager==0;
    if(appDelegate.manager==1)
    {
        self.btnAdd.hidden = YES;
    }
    
    //Keyboard notification listeners *Note has to be in viewDidLoad
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:self.view.window];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:self.view.window];
    
    [self startLoadingAnimations];
}

- (void)viewDidUnload
{
    table = nil;
    [self setBtnAdd:nil];
    [self setSearchBar:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

-(void)viewDidAppear:(BOOL)animated
{
    [self getDataFromSUP];
    
    //Sorting the employeeArray
    NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:@"firstName" ascending:YES];
    employeeArray = [NSMutableArray arrayWithArray:[employeeArray sortedArrayUsingDescriptors:[NSArray arrayWithObjects:descriptor,nil]]];
    
    displayEmployeeArray = [[NSMutableArray alloc] initWithArray:employeeArray];
    
    [table reloadData];
    
    [self stopLoadingAnimations];
}

- (IBAction)goBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    if(touch.phase == UITouchPhaseBegan)
    {
        [self.searchBar resignFirstResponder];
    }
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"DetailSegue"])
    {
        iPhoneEmployeeDetailsViewController *edView = [segue destinationViewController];
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

-(void)getDataFromSUP
{
    NSLog(@"Loading data from SUP...");
    employeeArray = [[NSMutableArray alloc] init];
    
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

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
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
    
    NSString *fName = [[displayEmployeeArray objectAtIndex:index] firstName];
    NSString *lName = [[displayEmployeeArray objectAtIndex:index] lastName];
    NSString *displayName = [NSString stringWithFormat:@"%@, %@", lName, fName];
    
    cell.textLabel.text = displayName;
    cell.detailTextLabel.text = [[displayEmployeeArray objectAtIndex:index] department];
    
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
        
        for (HR_SuiteUsers *entry in employeeArray)
        {
            NSRange r;
            
            //Checks everything at once as opposed to the ipad version.
            NSString *fName = entry.firstName;
            NSString *lName = entry.lastName;
            NSString *dept = entry.department;
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

