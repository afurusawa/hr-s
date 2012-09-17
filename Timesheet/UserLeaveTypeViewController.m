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
@synthesize delegate;
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
}

- (void)viewDidUnload
{
    [self setLeaveTypeTable:nil];
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


@end
