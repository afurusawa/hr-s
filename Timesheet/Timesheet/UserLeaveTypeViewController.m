//
//  UserLeaveTypeViewController.m
//  Timesheet
//
//  Created by Andrew Furusawa on 7/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UserLeaveTypeViewController.h"

@implementation UserLeaveTypeViewController
{
    //NSUserDefaults *defaults;
    NSString *leaveType;
}
@synthesize delegate, navbar;
@synthesize leaveTypeTable;

#pragma mark - View lifecycle


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    leaveTypeList = [[NSMutableArray alloc] initWithCapacity:1];
    [leaveTypeList addObject:@"Unpaid Time Off"];
    [leaveTypeList addObject:@"Paid Time Off"];
    [leaveTypeList addObject:@"Sick Leave"];
    [leaveTypeList addObject:@"Holiday"];
    
    //bg
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"ts-bg-bg.png"]]];
    
    //navbar title bg
    [navbar setBackgroundImage:[UIImage imageNamed:@"ts.topappbar-bg.png"] forBarMetrics:UIBarMetricsDefault];
    
    
    //bg for table
    [leaveTypeTable setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"ts-bg-bg.png"]]];
    
}

- (void)viewDidUnload
{
    [self setLeaveTypeTable:nil];
    [self setNavbar:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


/*** TABLE METHODS ***/
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [leaveTypeList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"LeaveCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    //separator color
    double rgb = 230.0/255.0;
    tableView.separatorColor = [UIColor colorWithRed:rgb green:rgb blue:rgb alpha:1];
    
    int eyeball = 20;
    [cell.textLabel setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:eyeball]];
    //text color when highlighted
    cell.textLabel.highlightedTextColor = [UIColor colorWithRed:42/255.0 green:106/255.0 blue:136/255.0 alpha:1];
    
    UIView *selectionColor = [[UIView alloc] init];
    selectionColor.backgroundColor = [UIColor colorWithRed:(228/255.0) green:(244/255.0) blue:(248/255.0) alpha:1];
    cell.selectedBackgroundView = selectionColor;
    
    
    // Configure the cell...
    cell.textLabel.text = [leaveTypeList objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // iPhone version
    if (tableView.tag == 2) {
        [self.delegate refreshViewWithLeaveTypeName:[leaveTypeList objectAtIndex:indexPath.row]];
        [self.navigationController popViewControllerAnimated:YES];
    }
    else {
        [[self.delegate getPopover] dismissPopoverAnimated:YES];
        [self.delegate refreshViewWithLeaveTypeName:[leaveTypeList objectAtIndex:indexPath.row]];
    }
}


- (IBAction)goBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
