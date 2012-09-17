//
//  UserLeaveRequestViewController.m
//  Timesheet
//
//  Created by Andrew Furusawa on 7/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UserLeaveRequestViewController.h"
#import "TimesheetDate.h"
#import "AppDelegate.h"

#import "HR_SuiteLeaveRequests.h"
#import "HR_SuiteHR_SuiteDB.h"

@implementation UserLeaveRequestViewController
{
    AppDelegate *d;
    TimesheetDate *tsDate;
    UITextField *selectedField;
    NSDictionary *entry;
    NSString *dateValue;
    NSString *defaultDateValue;
    
    UITapGestureRecognizer *tap;
}
@synthesize dateCheckBadge, dateCheckLabel;
@synthesize leaveTypeCheckBadge, leaveTypeCheckLabel;
@synthesize reasonCheckBadge, reasonCheckLabel;
@synthesize datePicker;
@synthesize startField;
@synthesize endField;
@synthesize leaveType;
@synthesize reasonField;
@synthesize doneBar;

/****************************************************************************************************
 Protocol Methods
 ****************************************************************************************************/
- (UIPopoverController *)getPopover
{
    return popover;
}
- (void)refreshViewWithLeaveTypeName:(NSString *)typeName
{
    NSLog(@"leave type selected: %@", typeName);
    [leaveType setTitle:typeName forState:UIControlStateNormal];
}



/****************************************************************************************************
 Prepare for segue and delegate control
 ****************************************************************************************************/
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"toLeaveType"]) {
        UserLeaveTypeViewController *dayView = [segue destinationViewController];
        dayView.delegate = self;
    }
}



/****************************************************************************************************
 View Did Load
 ****************************************************************************************************/
- (void)viewDidLoad
{
    d = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    tsDate = [[TimesheetDate alloc] init];
}

- (void)viewDidUnload
{
    [self setDatePicker:nil];
    [self setStartField:nil];
    [self setEndField:nil];
    [self setLeaveType:nil];
    [self setReasonField:nil];
    [self setDateCheckBadge:nil];
    [self setLeaveTypeCheckBadge:nil];
    [self setReasonCheckBadge:nil];
    [self setDateCheckLabel:nil];
    [self setLeaveTypeCheckLabel:nil];
    [self setReasonCheckLabel:nil];
    [super viewDidUnload];
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    if(theTextField == self.reasonField) {
        [theTextField resignFirstResponder];
    }
    return YES;
}

/****************************************************************************************************
 Date Picker
 ****************************************************************************************************/
//return NO to not show the keyboard for textfields
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    selectedField = textField; //save the currently selected field.

    if(textField == startField || textField == endField)
    {
        tap = [[UITapGestureRecognizer alloc] 
               initWithTarget:self
               action:@selector(dismissKeyboard)];
        [tap setCancelsTouchesInView:NO];
        [self.view addGestureRecognizer:tap];
        
        // Animation: Show date picker
        datePicker.hidden = NO;
        [datePicker setCenter:CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height)];
        [self.view addSubview:datePicker];
        [UIView beginAnimations:@"slideIn" context:nil];
        [datePicker setCenter:CGPointMake(self.view.frame.size.width - self.view.frame.size.width/2, self.view.frame.size.height - (datePicker.frame.size.height/2) - 44)]; //44 is the height of the "Done" bar at the bottom.
        [UIView commitAnimations];
        doneBar.hidden = NO;
        
        defaultDateValue = [tsDate getTodaysDate];
        
        return NO;
    }
    
    return YES;
}



// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}



// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if(component == 0) {
        return 12;
    }
    else if (component == 1) {
        return 31;
    }
    else if (component == 2) {
        return 10;
    }
    return 0;
}



// Value changed
- (IBAction)datePicked:(UIDatePicker *)sender {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM/dd/YYYY"];
    dateValue = [formatter stringFromDate:sender.date];
}



/****************************************************************************************************
 Done button pressed for date picker
 ****************************************************************************************************/
- (IBAction)dateSubmit:(id)sender {
    
    // Animation
    [datePicker setCenter:CGPointMake(self.view.frame.size.width - self.view.frame.size.width/2, self.view.frame.size.height - datePicker.frame.size.height/2)];
    [self.view addSubview:datePicker];
    [UIView beginAnimations:@"slideIn" context:nil];
    [datePicker setCenter:CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height + datePicker.frame.size.height/2)];
    [UIView commitAnimations];
    
    if (dateValue) {
        defaultDateValue = dateValue;
    }
    selectedField.text = defaultDateValue;
    
    if([endField.text length] >1) {
        [self checkStartAndEndDate];
    }
    
    doneBar.hidden = YES;
}



/****************************************************************************************************
 Type Selector Pop-over
 ****************************************************************************************************/
- (IBAction)typeSelector:(UIButton *)sender {
    
    // iPhone version
    if (sender.tag == 2) {
        [self performSegueWithIdentifier:@"toLeaveType" sender:self];
    }
    
    // iPad version
    else {
        UserLeaveTypeViewController *typeView = [self.storyboard instantiateViewControllerWithIdentifier:@"typeView"];
        typeView.delegate = self;
        popover = [[UIPopoverController alloc] initWithContentViewController:typeView];
        
        CGRect position = CGRectMake(150, 30, 1, 1);
        [popover presentPopoverFromRect:position inView:sender permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    }
}



/****************************************************************************************************
 Submit Request Form
 ****************************************************************************************************/
- (IBAction)submitRequest:(id)sender {
    
    if([self checkValidity]) {
        NSString *startDate = startField.text;
        NSString *endDate = endField.text;
        NSString *type = leaveType.titleLabel.text;
        NSString *reason = reasonField.text;
        
        /**********************/
        /*   SUP Connection   */
        /**********************/
        if (d.isSUPConnection) {
            
            //Get date and time
            NSString *timestamp = [tsDate getTimestamp];
            
            //Add to database
            HR_SuiteLeaveRequests *temp = [[HR_SuiteLeaveRequests alloc] init];
            
            [temp setEmployeeID:d.user];
            [temp setTimestamp:timestamp];
            [temp setStartDate:startDate];
            [temp setEndDate:endDate];
            [temp setLeaveType:type];
            [temp setReason:reason];
            [temp setSignCode:[NSNumber numberWithInt:0]];
            [temp setManagerNotes:@""];
            
            [temp create];
            [temp submitPending];
            [HR_SuiteHR_SuiteDB synchronize:@"default"];
        } //end sup
        
        /************/
        /*   DEMO   */
        /************/
        else {
            entry = [NSDictionary dictionaryWithObjectsAndKeys:
                     d.user, @"employeeID",
                     @"user", @"employeeName",
                     [tsDate getTimestamp], @"timestamp", 
                     startDate, @"startDate",
                     endDate, @"endDate",
                     type, @"leaveType",
                     reason, @"reason",
                     //@"Keep up the good work", @"managerNotes",
                     @"1", @"signCode", 
                     @"manager", @"manager",
                     nil];
            [d.hr_leaverequests addObject:entry];
        }
        
        
        [self clearRequest:nil];
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}



/****************************************************************************************************
 Clear Request Form
 ****************************************************************************************************/
- (IBAction)clearRequest:(id)sender {
    startField.text = @"";
    endField.text = @"";
    leaveType.titleLabel.text = @"";
    reasonField.text = @"";
}



/************************************************************************************************************************
 
 Internal Methods
 
 ************************************************************************************************************************/

/****************************************************************************************************
 View Did Load
 ****************************************************************************************************/
- (void)checkStartAndEndDate {
    TimesheetDate *start = [[TimesheetDate alloc] init];
    TimesheetDate *end = [[TimesheetDate alloc] init];

    if ([startField.text length] == 0) {
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Input Error!" message:@"Please make sure the starting date comes before the ending date." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [message setAlertViewStyle:UIAlertViewStyleDefault];
        [message show];
        endField.text = @"";
        return;
    }
    [start splitDateUsingSlash:startField.text];
    [end splitDateUsingSlash:endField.text];
    
    /* cases where end date is before the start date
     1) end year < start year
     2) end month < start month, end year <= start year
     3) end day < start day, end month <= start month, end year <= start year
     */
    if (
        ([start getYear] > [end getYear]) ||
        ([start getMonth] > [end getMonth] && [start getYear] >= [end getYear]) ||
        ([start getDay] > [end getDay] && [start getMonth] >= [end getMonth] && [start getYear] >= [end getYear])
        ) {
        
        endField.text = @"";
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Input Error!" message:@"Please make sure the starting date comes before the ending date." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [message setAlertViewStyle:UIAlertViewStyleDefault];
        [message show];
    }
}



/****************************************************************************************************
 Check if form-fill information is valid
 ****************************************************************************************************/
- (BOOL)checkValidity {
    
    leaveTypeCheckBadge.hidden = YES;
    leaveTypeCheckLabel.hidden = YES;
    dateCheckBadge.hidden = YES;
    dateCheckLabel.hidden = YES;
    reasonCheckBadge.hidden = YES;
    reasonCheckLabel.hidden = YES;
    
    NSString *startDate = startField.text;
    NSString *endDate = endField.text;
    NSString *type = leaveType.titleLabel.text;
    NSString *reason = reasonField.text;
    
    BOOL isValid = true; //valid by default.
    
    //Check if a type was entered or not
    if ([type length] == 0) {
        leaveTypeCheckBadge.hidden = NO;
        leaveTypeCheckLabel.hidden = NO;
        isValid = false;
    }
    
    //Check if both start and end dates were entered or not
    if ([startDate length] == 0 || [endDate length] == 0)
    {
        dateCheckBadge.hidden = NO;
        dateCheckLabel.hidden = NO;
        isValid = false;
    }
    
    //Check if a reason was entered or not
    if ([reason length] == 0)
    {
        reasonCheckBadge.hidden = NO;
        reasonCheckLabel.hidden = NO;
        isValid = false;
    }
    
    return isValid;
}


// Set gestures
- (IBAction)editDidBegin:(id)sender {
    tap = [[UITapGestureRecognizer alloc] 
                                   initWithTarget:self
           action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    
    // Close date picker
    [datePicker setCenter:CGPointMake(self.view.frame.size.width - self.view.frame.size.width/2, self.view.frame.size.height - datePicker.frame.size.height/2)];
    [self.view addSubview:datePicker];
    [UIView beginAnimations:@"slideIn" context:nil];
    [datePicker setCenter:CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height + datePicker.frame.size.height/2)];
    doneBar.hidden = YES;
    [UIView commitAnimations];
    datePicker.hidden = YES;
}

-(void)dismissKeyboard {
    [reasonField resignFirstResponder];
    [self.view removeGestureRecognizer:tap];
    
    // Close date picker
    [datePicker setCenter:CGPointMake(self.view.frame.size.width - self.view.frame.size.width/2, self.view.frame.size.height - datePicker.frame.size.height/2)];
    [self.view addSubview:datePicker];
    [UIView beginAnimations:@"slideIn" context:nil];
    [datePicker setCenter:CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height + datePicker.frame.size.height/2)];
    doneBar.hidden = YES;
    [UIView commitAnimations];
    datePicker.hidden = YES;
}


@end
