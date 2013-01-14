//
//  MLRDetailViewController.m
//  Timesheet
//
//  Created by Andrew Furusawa on 7/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MLRDetailViewController.h"
#import "AppDelegate.h"
#import "TimesheetDate.h"

#import "HR_SuiteLeaveRequests.h"
#import "HR_SuiteUsers.h"
#import "HR_SuiteHR_SuiteDB.h"

@implementation MLRDetailViewController
{
    AppDelegate *d;
    TimesheetDate *tsDate;
    NSDictionary *entry;
}
@synthesize scrollView, navbar;

@synthesize employeeName, submittedOn, startDate, endDate, leaveType, reason, managerNotes;
@synthesize delegate;



- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    NSLog(@"textview got called");
    [UIView beginAnimations:@"TEMP" context:NULL];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:self.view cache:YES];
    [self.view setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [UIView commitAnimations];
    [self.managerNotes resignFirstResponder];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range 
 replacementText:(NSString *)text
{
    
    if ([text isEqualToString:@"\n"]) {
        [UIView beginAnimations:@"TEMP" context:NULL];
        [UIView setAnimationDuration:0.3];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:self.view cache:YES];
        [self.view setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        [UIView commitAnimations];
        [textView resignFirstResponder];
        // Return FALSE so that the final '\n' character doesn't get added
        return NO;
    }
    // For any other character return TRUE so that the text gets added to the view
    return YES;
}


- (void)textViewDidBeginEditing:(UITextView *)textView
{
    NSLog(@"textview got called");
    [UIView beginAnimations:@"TEMP" context:NULL];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:self.view cache:YES];
    [self.view setFrame:CGRectMake(0, -110, self.view.frame.size.width, self.view.frame.size.height)];
    [UIView commitAnimations];
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    NSLog(@"textview got called");
    [UIView beginAnimations:@"TEMP" context:NULL];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:self.view cache:YES];
    [self.view setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [UIView commitAnimations];
}

/****************************************************************************************************
 View Did Load
 ****************************************************************************************************/
- (void)viewDidLoad
{
    d = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    tsDate = [[TimesheetDate alloc] init];
    
    //bg
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"ts-bg-bg.png"]]];
    
    //navbar title bg
    [navbar setBackgroundImage:[UIImage imageNamed:@"ts.topappbar-bg.png"] forBarMetrics:UIBarMetricsDefault];
    
    //set font
    [submittedOn setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:15]];
    [startDate setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:15]];
    [endDate setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:15]];
    [leaveType setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:15]];
    [reason setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:12]];
    
    
    /**********************/
    /*   SUP Connection   */
    /**********************/
    if (d.isSUPConnection) {
        
        HR_SuiteLeaveRequestsList *list = [HR_SuiteLeaveRequests findAll];
        for (HR_SuiteLeaveRequests *item in list) {
            if ([item.employeeID isEqualToString:d.selectedUser] && [item.timestamp isEqualToString:d.selectedDate]) {
                
                HR_SuiteUsersList *ulist = [HR_SuiteUsers findAll];
                for (HR_SuiteUsers *uitem in ulist) {
                    if ([item.employeeID isEqualToString:uitem.employeeID]) {
                        employeeName.text = uitem.employeeName;
                    }
                }
                
                submittedOn.text = [NSString stringWithFormat:@"Submitted on: %@", d.selectedDate];
                startDate.text = item.startDate;
                endDate.text = item.endDate;
                [leaveType setTitle:item.leaveType forState:UIControlStateNormal];
                reason.text = item.reason;
            }
        }
    } //end sup
    
    /************/
    /*   DEMO   */
    /************/
    else {
        NSLog(@"seleted user %@ %@ %@", d.selectedUser, d.selectedDate, d.selectedIndex);
        for (NSDictionary *item in d.hr_leaverequests) {
            if ([[item objectForKey:@"employeeID"] isEqualToString:d.selectedUser] && [[item objectForKey:@"timestamp"] isEqualToString:d.selectedDate]) {
                employeeName.text = [item objectForKey:@"employeeName"];
                submittedOn.text = [NSString stringWithFormat:@"Submitted on: %@", d.selectedDate];
                startDate.text = [item objectForKey:@"startDate"];
                endDate.text = [item objectForKey:@"endDate"];
                [leaveType setTitle:[item objectForKey:@"leaveType"] forState:UIControlStateNormal];
                reason.text = [item objectForKey:@"reason"];
            }
        }
    }
    
}

- (void)viewDidUnload
{
    [self setNavbar:nil];
    [self setScrollView:nil];
    [self setManagerNotes:nil];
    [self setReason:nil];
    [self setLeaveType:nil];
    [self setEndDate:nil];
    [self setStartDate:nil];
    [self setSubmittedOn:nil];
    [self setEmployeeName:nil];    
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}



/****************************************************************************************************
 Approve Button
 ****************************************************************************************************/
- (IBAction)approve:(id)sender {
    [LoadingScreen startLoadingScreenWithView:self.view];
    /**********************/
    /*   SUP Connection   */
    /**********************/
    if (d.isSUPConnection) {
        HR_SuiteLeaveRequestsList *list = [HR_SuiteLeaveRequests findRequestEntry:d.selectedUser withStartDate:startDate.text withEndDate:endDate.text];
        
        for (HR_SuiteLeaveRequests *item in list) {
            [item setSignCode:[NSNumber numberWithInt:100]];
            [item setManagerNotes:managerNotes.text];
            [item setTimestamp:[tsDate getTimestamp]];
            [item updateSignCode];
            [item submitPending];
            [HR_SuiteHR_SuiteDB synchronize:@"default"];
        }
    }
    
    /************/
    /*   DEMO   */
    /************/
    else {
        // Find the index with matching employee ID and timestamp to replace
        for (int i = 0; i < [d.hr_leaverequests count]; i++) {
            if ([[[d.hr_leaverequests objectAtIndex:i] objectForKey:@"employeeID"] isEqualToString:d.selectedUser] && [[[d.hr_leaverequests objectAtIndex:i] objectForKey:@"timestamp"] isEqualToString:d.selectedDate]) {
                entry = [NSDictionary dictionaryWithObjectsAndKeys:
                         [[d.hr_leaverequests objectAtIndex:i] objectForKey:@"employeeID"], @"employeeID",
                         [[d.hr_leaverequests objectAtIndex:i] objectForKey:@"employeeName"], @"employeeName",
                         [tsDate getTimestamp], @"timestamp", 
                         [[d.hr_leaverequests objectAtIndex:i] objectForKey:@"startDate"], @"startDate",
                         [[d.hr_leaverequests objectAtIndex:i] objectForKey:@"endDate"], @"endDate",
                         [[d.hr_leaverequests objectAtIndex:i] objectForKey:@"leaveType"], @"leaveType",
                         [[d.hr_leaverequests objectAtIndex:i] objectForKey:@"reason"], @"reason",
                         managerNotes.text, @"managerNotes",
                         @"100", @"signCode", 
                         @"manager", @"manager",
                         nil];
                [d.hr_leaverequests replaceObjectAtIndex:i withObject:entry];
            }
        }
    }
    [LoadingScreen stopLoadingScreenWithView:self.view];
    [self.delegate reloadView];
    [self.navigationController popViewControllerAnimated:YES];
}



/****************************************************************************************************
 Deny Button
 ****************************************************************************************************/
- (IBAction)deny:(id)sender {
    [LoadingScreen startLoadingScreenWithView:self.view];
    /**********************/
    /*   SUP Connection   */
    /**********************/
    if (d.isSUPConnection) {
        HR_SuiteLeaveRequestsList *list = [HR_SuiteLeaveRequests findRequestEntry:d.selectedUser withStartDate:startDate.text withEndDate:endDate.text];
        
        for (HR_SuiteLeaveRequests *item in list) {
            [item setSignCode:[NSNumber numberWithInt:99]];
            [item setManagerNotes:managerNotes.text];
            [item setTimestamp:[tsDate getTimestamp]];
            [item updateSignCode];
            [item submitPending];
            [HR_SuiteHR_SuiteDB synchronize:@"default"];
        }
    }
    
    /************/
    /*   DEMO   */
    /************/
    else {
        // Find the index with matching employee ID and timestamp to replace
        for (int i = 0; i < [d.hr_leaverequests count]; i++) {
            if ([[[d.hr_leaverequests objectAtIndex:i] objectForKey:@"employeeID"] isEqualToString:d.selectedUser] && [[[d.hr_leaverequests objectAtIndex:i] objectForKey:@"timestamp"] isEqualToString:d.selectedDate]) {
                entry = [NSDictionary dictionaryWithObjectsAndKeys:
                         [[d.hr_leaverequests objectAtIndex:i] objectForKey:@"employeeID"], @"employeeID",
                         [[d.hr_leaverequests objectAtIndex:i] objectForKey:@"employeeName"], @"employeeName",
                         [tsDate getTimestamp], @"timestamp", 
                         [[d.hr_leaverequests objectAtIndex:i] objectForKey:@"startDate"], @"startDate",
                         [[d.hr_leaverequests objectAtIndex:i] objectForKey:@"endDate"], @"endDate",
                         [[d.hr_leaverequests objectAtIndex:i] objectForKey:@"leaveType"], @"leaveType",
                         [[d.hr_leaverequests objectAtIndex:i] objectForKey:@"reason"], @"reason",
                         @"99", @"signCode", 
                         managerNotes.text, @"managerNotes",
                         @"manager", @"manager",
                         nil];
                [d.hr_leaverequests replaceObjectAtIndex:i withObject:entry];
            }
        }
    }
    [LoadingScreen stopLoadingScreenWithView:self.view];
    [self.delegate reloadView];
    [self.navigationController popViewControllerAnimated:YES];
}
@end
