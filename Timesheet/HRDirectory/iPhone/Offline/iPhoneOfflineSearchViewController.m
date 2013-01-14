//
//  iPhoneOfflineSearchViewController.m
//  HRDirectory
//
//  Created by Alex Chiu on 9/19/12.
//  Copyright (c) 2012 Alex Chiu. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "iPhoneOfflineSearchViewController.h"
#import "iPhoneOfflineEmployeeDetailsViewController.h"
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
    
    //navbar title bg
    [self.navbar setBackgroundImage:[UIImage imageNamed:@"ts.topappbar-bg.png"] forBarMetrics:UIBarMetricsDefault];
    
    //Hiding add
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if(!appDelegate.isManager)
    {
        self.btnAdd.hidden = YES;
    }
    
    //Instantiating search
    selected = selectedOptionName;
    [self selectName:self.btnName];
    
    //Hidding border on UISearchBar
    self.searchBar.layer.borderWidth = 0;
    [self.searchBar setBackgroundImage:[UIImage imageNamed:@"ts-bg-bg"]]; //Setting background
    
    //Instantiating letters array
    letters = [[NSMutableArray alloc] init];
    structuredDisplyEmployeeArray = [[NSMutableArray alloc] init];
    
    [super viewDidLoad];
    
    //Keyboard notification listeners *Note has to be in viewDidLoad
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:self.view.window];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:self.view.window];
    
    [self startLoadingAnimations];
}

-(void)viewDidAppear:(BOOL)animated
{
    
    [self gettingData];
    
    //Sorting the employeeArray
    NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:@"firstName" ascending:YES];
    employeeArray = [NSMutableArray arrayWithArray:[employeeArray sortedArrayUsingDescriptors:[NSArray arrayWithObjects:descriptor,nil]]];
    
    displayEmployeeArray = [[NSMutableArray alloc] initWithArray:employeeArray];
    [self getLettersAndStrutureDisplay];
    
    [table reloadData];
    
    [self stopLoadingAnimations];
}

- (void)viewDidUnload
{
    [self setBtnName:nil];
    [self setBtnDepartment:nil];
    [self setNavbar:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


-(void)gettingData
{
    AppDelegate *singleton = (AppDelegate *)[UIApplication sharedApplication].delegate;;
    
    employeeArray = singleton.hr_users; //pointer, not copy
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"DetailSegue"])
    {
        iPhoneOfflineEmployeeDetailsViewController *edView = [segue destinationViewController];
        //Getting index of the cell selected
        UITableViewCell *cell = (UITableViewCell *)sender;
        NSIndexPath *indexPath = [table indexPathForCell:cell];
        
        //Getting table entry and giving it to the detail view controller
        edView.thisEntry = [[structuredDisplyEmployeeArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        
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

- (IBAction)selectName:(id)sender
{
    UIImage *nameDown = [UIImage imageNamed:@"ts-directory-category-name-down"];
    UIImage *categoryUp = [UIImage imageNamed:@"ts-directory-category-department-up"];
    self.searchBar.placeholder = @"Search by Name";
    
    //Set button to selected
    [self.btnName setImage:nameDown forState:UIControlStateNormal];
    //Reset department button to unselected
    [self.btnDepartment setImage:categoryUp forState:UIControlStateNormal];
    //Set selected option
    selected = selectedOptionName;
    //Reload search results
    [self searchBar:self.searchBar textDidChange:self.searchBar.text];
}

- (IBAction)selectDepartment:(id)sender
{
    UIImage *nameUp = [UIImage imageNamed:@"ts-directory-category-name-up"];
    UIImage *categoryDown = [UIImage imageNamed:@"ts-directory-category-department-down"];
    self.searchBar.placeholder = @"Search by Department";
    
    //Set button to selected
    [self.btnDepartment setImage:categoryDown forState:UIControlStateNormal];
    //Reset Name button to unselected
    [self.btnName setImage:nameUp forState:UIControlStateNormal];
    //Set selected option
    selected = selectedOptionDepartment;
    //Reload search results
    [self searchBar:self.searchBar textDidChange:self.searchBar.text];
}

#pragma mark - Table view data source

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [letters count];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[structuredDisplyEmployeeArray objectAtIndex:section] count];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [letters objectAtIndex:section];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    //Getting current index
    NSDictionary *employee = [[structuredDisplyEmployeeArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    NSString *fName = [employee objectForKey:@"firstName"];
    NSString *lName = [employee objectForKey:@"lastName"];
    NSString *displayName = [NSString stringWithFormat:@"%@ %@", fName, lName];
    
    //Fonts
    UIFont *boldFont = [UIFont fontWithName:@"ProximaNova-Bold" size:20.0f];
    UIFont *regularFont = [UIFont fontWithName:@"ProximaNova-Regular" size:20.0f];
    
    //Attributed string with attributes
    NSMutableAttributedString *atrbString = [[NSMutableAttributedString alloc] initWithString:displayName];
    [atrbString addAttribute:NSFontAttributeName value:boldFont range:NSMakeRange(0, [fName length])];
    [atrbString addAttribute:NSFontAttributeName value:regularFont range:NSMakeRange([fName length]+1, [lName length])];
    
    cell.textLabel.attributedText = atrbString;

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Nothing needed here yet
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    CGRect rect = CGRectMake(0, 0, tableView.frame.size.width, 24);
    [view setFrame:rect];
    
    //Adding backround image
    UIImageView *headerImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ts-directory-alphabet-list-bg"]];
    [headerImage setFrame:rect];
    [view addSubview:headerImage];
    
    //Adding label
    UILabel *label = [[UILabel alloc] init];
    [label setText:[letters objectAtIndex:section]];
    [view addSubview:label];
    [label setFrame:CGRectMake(10, 1, 80, 24)];
    [label setBackgroundColor:[UIColor clearColor]]; //Set background to clear
    [label setTextColor:[UIColor colorWithRed:66/255.0 green:190/255.0 blue:221/255.0 alpha:1.0]]; //Set font color to teal
    [label setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:18]];
    
    [view setBackgroundColor:[UIColor blackColor]];
    return view;
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

            switch (selected) {
                case selectedOptionName:
                {
                    NSString *fName = [entry objectForKey:@"firstName"];
                    NSString *lName = [entry objectForKey:@"lastName"];
                    NSString *combined = [NSString stringWithFormat:@"%@ %@", fName, lName];
                    r = [combined rangeOfString:searchText options:NSCaseInsensitiveSearch];
                    break;
                }
                case selectedOptionDepartment:
                {
                    NSString *dept = [entry objectForKey:@"department"];
                    r = [dept rangeOfString:searchText options:NSCaseInsensitiveSearch];
                    break;
                }
                default:
                    break;
            }
            
            if(r.location != NSNotFound)
            {
                [displayEmployeeArray addObject:entry];
            }
        }
    }
    [self getLettersAndStrutureDisplay];
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

//Takes the "displayEmployeeArray" which contains all the values that are available for display (limited by the search terms) and partitions them based on the first letter of the first name
-(void)getLettersAndStrutureDisplay
{
    [letters removeAllObjects];
    [structuredDisplyEmployeeArray removeAllObjects];
    NSMutableArray *currentRow;
    
    for(NSDictionary *person in displayEmployeeArray)
    {
        NSString *firstName = [person objectForKey:@"firstName"];
        NSString *letter = [NSString stringWithFormat:@"%c", [firstName characterAtIndex:0]];
        
        //If letter is not already contained, add letter
        if(![letters containsObject:letter])
        {
            [letters addObject:letter];
            
            currentRow = [[NSMutableArray alloc] init]; //Point to new array
            [structuredDisplyEmployeeArray addObject:currentRow];
            [currentRow addObject:person];
            
            //Check if the number of letters and number of rows are equal
            if([letters count] != [structuredDisplyEmployeeArray count])
            {
                NSLog(@"Error has occured, letters and structured array not the same length");
            }
        }
        else //Add to current row
        {
            [currentRow addObject:person];
        }
    }
}


@end
