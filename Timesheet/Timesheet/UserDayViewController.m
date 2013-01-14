//
//  UserDayViewController.m
//  Timesheet
//
//  Created by Andrew Furusawa on 7/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UserDayViewController.h"
#import "AppDelegate.h"
#import "HR_TimesheetTimesheet.h"
#import "HR_TimesheetHR_TimesheetDB.h"
#import "SUPQuery.h"

@implementation UserDayViewController
{
    NSString *response;
    AppDelegate *d;
}
@synthesize grayOutImage;
@synthesize activity;
@synthesize jobSlot1;
@synthesize jobSlot2;
@synthesize jobSlot3;
@synthesize jobSlot4;
@synthesize jobSlot5;
@synthesize jobSlot6;
@synthesize jobSlot7;
@synthesize jobSlot8;
@synthesize jobSlot9;
@synthesize jobSlot10;
@synthesize hoursField1;
@synthesize hoursField2;
@synthesize hoursField3;
@synthesize hoursField4;
@synthesize hoursField5;
@synthesize hoursField6;
@synthesize hoursfield7;
@synthesize hoursField8;
@synthesize hoursField9;
@synthesize hoursField10;
@synthesize totalHoursField;
@synthesize currentDayField;
@synthesize currentDateField;

@synthesize doneButton;
@synthesize delegate;
@synthesize jobIndex;
@synthesize scrollView;

/****************************************************************************************************
 Protocol Methods
 ****************************************************************************************************/
- (NSInteger)getJobIndex
{
    return jobIndex;
}
- (void)setJobName:(NSString *)name atIndex:(NSInteger)i
{
    if (i==1) {
        [jobSlot1 setTitle:name forState:UIControlStateNormal];
    }
    if (i==2) {
        [jobSlot2 setTitle:name forState:UIControlStateNormal];
    }
    if (i==3) {
        [jobSlot3 setTitle:name forState:UIControlStateNormal];
    }
    if (i==4) {
        [jobSlot4 setTitle:name forState:UIControlStateNormal];
    }
    if (i==5) {
        [jobSlot5 setTitle:name forState:UIControlStateNormal];
    }
    if (i==6) {
        [jobSlot6 setTitle:name forState:UIControlStateNormal];
    }
    if (i==7) {
        [jobSlot7 setTitle:name forState:UIControlStateNormal];
    }
    if (i==8) {
        [jobSlot8 setTitle:name forState:UIControlStateNormal];
    }
    if (i==9) {
        [jobSlot9 setTitle:name forState:UIControlStateNormal];
    }
    if (i==10) {
        [jobSlot10 setTitle:name forState:UIControlStateNormal];
    }
}
- (UIPopoverController *)getPopover
{
    return popover;
}
- (void)refreshView
{    
    
    /*** Web Host Connection ***/
    //    NSString *myRequestString = [NSString stringWithFormat:@"currentUser=%@ &currentDay=%@ &currentDate=%@", d.user, d.selectedDay, d.selectedDate];
    //    NSData *myRequestData = [NSData dataWithBytes:[myRequestString UTF8String] length:[myRequestString length]];
    //    
    //    NSString *url = @"http://rapidcon.startlogic.com/afurusawa/RapidHR/dayView_retriever.php";
    //    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0];
    //    [request setHTTPMethod:@"POST"];
    //    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
    //    [request setHTTPBody: myRequestData];
    //    [[[NSURLConnection alloc] initWithRequest:request delegate:self] start];
    
    [self updateJobSlots];
    [self updateHourSlots];
}


// Method to dismiss keyboard when "return" button is pressed.
- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    if(theTextField == self.hoursField1 || theTextField == self.hoursField2 || theTextField == self.hoursField3 || theTextField == self.hoursField4 || theTextField == self.hoursField5 || theTextField == self.hoursField6  || theTextField == self.hoursfield7  || theTextField == self.hoursField8 || theTextField == self.hoursField9 || theTextField == self.hoursField10) {
        [theTextField resignFirstResponder];
    }
    return YES;
}

/****************************************************************************************************
 View Did Load
 ****************************************************************************************************/
- (void)viewDidLoad
{
    [self startLoading];
    
    d = (AppDelegate *)[[UIApplication sharedApplication] delegate]; //initialize.
    
    //initial job slot displayed.
    jobSlot1.hidden = NO;
    hoursField1.hidden = NO;
    
    jobSlot2.hidden = YES;
    hoursField2.hidden = YES;
    
    jobSlot3.hidden = YES;
    hoursField3.hidden = YES;
    
    jobSlot4.hidden = YES;
    hoursField4.hidden = YES;
    
    jobSlot5.hidden = YES;
    hoursField5.hidden = YES;
    
    jobSlot6.hidden = YES;
    hoursField6.hidden = YES;
    
    jobSlot7.hidden = YES;
    hoursfield7.hidden = YES;
    
    jobSlot8.hidden = YES;
    hoursField8.hidden = YES;
    
    jobSlot9.hidden = YES;
    hoursField9.hidden = YES;
    
    jobSlot10.hidden = YES;
    hoursField10.hidden = YES;    
    
    //Shift for keyboard (for iPhone).
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];    
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];
    
    // Set day and date
    currentDayField.text = d.selectedDay;
    currentDateField.text = d.selectedDate;
    
    /*** SUP Connection ***/
    // Set values to display in the day-view
    HR_TimesheetTimesheetList *tsList = [HR_TimesheetTimesheet findStatsFromDay:d.user withDate:d.selectedDate withDay:d.selectedDay];
    
    if ([tsList length] > 0)
    {
        for (HR_TimesheetTimesheet *item in tsList) {
            
            if([item.jobIndex isEqualToNumber:[NSNumber numberWithInt:1]]) {
                [jobSlot1 setTitle:item.job forState:UIControlStateNormal];
                [hoursField1 setText:[item.hours stringValue]];
                
                if([item.job length] > 1) {
                    jobSlot2.hidden=NO;
                    hoursField2.hidden=NO;
                }
            }
            else if([item.jobIndex isEqualToNumber:[NSNumber numberWithInt:2]]) {
                if([item.job length] > 1) {
                    jobSlot2.hidden=NO;
                    hoursField2.hidden=NO;
                    jobSlot3.hidden=NO;
                    hoursField3.hidden=NO;
                }
                [jobSlot2 setTitle:item.job forState:UIControlStateNormal];
                [hoursField2 setText:[item.hours stringValue]];
            }
            else if([item.jobIndex isEqualToNumber:[NSNumber numberWithInt:3]]) {
                if([item.job length] > 1) {
                    jobSlot3.hidden=NO;
                    hoursField3.hidden=NO;
                    jobSlot4.hidden=NO;
                    hoursField4.hidden=NO;
                }
                [jobSlot3 setTitle:item.job forState:UIControlStateNormal];
                [hoursField3 setText:[item.hours stringValue]];
            }
            else if([item.jobIndex isEqualToNumber:[NSNumber numberWithInt:4]]) {
                if([item.job length] > 1) {
                    jobSlot4.hidden=NO;
                    hoursField4.hidden=NO;
                    jobSlot5.hidden=NO;
                    hoursField5.hidden=NO;
                }
                [jobSlot4 setTitle:item.job forState:UIControlStateNormal];
                [hoursField4 setText:[item.hours stringValue]];
            }
            else if([item.jobIndex isEqualToNumber:[NSNumber numberWithInt:5]]) {
                if([item.job length] > 1) {
                    jobSlot5.hidden=NO;
                    hoursField5.hidden=NO;
                    jobSlot6.hidden=NO;
                    hoursField6.hidden=NO;
                }
                [jobSlot5 setTitle:item.job forState:UIControlStateNormal];
                [hoursField5 setText:[item.hours stringValue]];
            }
            
            else if([item.jobIndex isEqualToNumber:[NSNumber numberWithInt:6]]) {
                if([item.job length] > 1) {
                    jobSlot6.hidden=NO;
                    hoursField6.hidden=NO;
                    jobSlot7.hidden=NO;
                    hoursfield7.hidden=NO;
                }
                [jobSlot6 setTitle:item.job forState:UIControlStateNormal];
                [hoursField6 setText:[item.hours stringValue]];
            }
            else if([item.jobIndex isEqualToNumber:[NSNumber numberWithInt:7]]) {
                if([item.job length] > 1) {
                    jobSlot7.hidden=NO;
                    hoursfield7.hidden=NO;
                    jobSlot8.hidden=NO;
                    hoursField8.hidden=NO;
                }
                [jobSlot7 setTitle:item.job forState:UIControlStateNormal];
                [hoursfield7 setText:[item.hours stringValue]];
            }
            else if([item.jobIndex isEqualToNumber:[NSNumber numberWithInt:8]]) {
                if([item.job length] > 1) {
                    jobSlot8.hidden=NO;
                    hoursField8.hidden=NO;
                    jobSlot9.hidden=NO;
                    hoursField9.hidden=NO;
                }
                [jobSlot8 setTitle:item.job forState:UIControlStateNormal];
                [hoursField8 setText:[item.hours stringValue]];
            }
            else if([item.jobIndex isEqualToNumber:[NSNumber numberWithInt:9]]) {
                if([item.job length] > 1) {
                    jobSlot9.hidden=NO;
                    hoursField9.hidden=NO;
                    jobSlot10.hidden=NO;
                    hoursField10.hidden=NO;
                }
                [jobSlot9 setTitle:item.job forState:UIControlStateNormal];
                [hoursField9 setText:[item.hours stringValue]];
            }
            else if([item.jobIndex isEqualToNumber:[NSNumber numberWithInt:10]]) {
                if([item.job length] > 1) {
                    jobSlot10.hidden=NO;
                    hoursField10.hidden=NO;
                }
                [jobSlot10 setTitle:item.job forState:UIControlStateNormal];
                [hoursField10 setText:[item.hours stringValue]];
            }
        }
        
        //Calculate and display the total hours worked on the given day.
        NSInteger totalHours = [hoursField1.text integerValue] + [hoursField2.text integerValue] + [hoursField3.text integerValue] + [hoursField4.text integerValue] + [hoursField5.text integerValue] + [hoursField6.text integerValue] + [hoursfield7.text integerValue] + [hoursField8.text integerValue] + [hoursField9.text integerValue] + [hoursField10.text integerValue];
        totalHoursField.text = [NSString stringWithFormat:@"Total: %i hours", totalHours];

        [self updateJobSlots];
        
        /*** Web Host Connection ***/
        /*
        NSString *myRequestString = [NSString stringWithFormat:@"currentUser=%@ &currentDay=%@ &currentDate=%@", d.user, d.selectedDay, d.selectedDate];
        NSData *myRequestData = [NSData dataWithBytes:[myRequestString UTF8String] length:[myRequestString length]];
        
        NSString *url = @"http://rapidcon.startlogic.com/afurusawa/RapidHR/dayView_retriever.php";
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0];
        [request setHTTPMethod:@"POST"];
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
        [request setHTTPBody: myRequestData];
        [[[NSURLConnection alloc] initWithRequest:request delegate:self] start];    
        [self updateJobSlots];
         */
    }
    
    //If empty
    else {
        NSLog(@"entered empty set");
        //add 10 empty entries.
        for (int i = 1; i <= 10; i++) {
       
            HR_TimesheetTimesheet *temp = [[HR_TimesheetTimesheet alloc] init];
            
            [temp setEmployeeID:d.user];
            [temp setDay:d.selectedDay];
            [temp setDate:d.selectedDate];
            [temp setJobIndex:[NSNumber numberWithInt:i]];
            [temp setHours:[NSNumber numberWithInt:0]];

            [temp create];
            [temp submitPending];
            [HR_TimesheetHR_TimesheetDB synchronize:@"default"];
        }
        //[self addEmptyEntryAtIndex:1];
    }
    
    [self endLoading];
}

- (void)viewDidUnload
{
    [self setJobSlot1:nil];
    [self setJobSlot2:nil];
    [self setJobSlot3:nil];
    [self setJobSlot4:nil];
    [self setJobSlot5:nil];
    [self setHoursField1:nil];
    [self setHoursField2:nil];
    [self setHoursField3:nil];
    [self setHoursField4:nil];
    [self setHoursField5:nil];
    [self setTotalHoursField:nil];
    [self setCurrentDayField:nil];
    [self setCurrentDateField:nil];
    [self setScrollView:nil];
    [self setJobSlot6:nil];
    [self setJobSlot7:nil];
    [self setJobSlot8:nil];
    [self setJobSlot9:nil];
    [self setJobSlot10:nil];
    [self setHoursField6:nil];
    [self setHoursfield7:nil];
    [self setHoursField8:nil];
    [self setHoursField9:nil];
    [self setHoursField10:nil];
    [self setGrayOutImage:nil];
    [self setActivity:nil];
    [self setDoneButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
    

/****************************************************************************************************
 Connection Methods - START
 ****************************************************************************************************/
- (void)connection: (NSURLConnection *)connection didReceiveData:(NSData *)data
{
    response = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"response: %@", response);
}

- (void)connectionDidFinishLoading: (NSURLConnection *) connection
{
    NSString *string = response;
    NSArray *temp = [string componentsSeparatedByString: @";"];
    
    for (int i = 0; i < [temp count]-1; i++) {
        NSArray *temp2 = [[temp objectAtIndex:i] componentsSeparatedByString: @"="];
        
        if(i==0) {
            [jobSlot1 setTitle:[temp2 objectAtIndex:0] forState:UIControlStateNormal];
            [hoursField1 setText:[temp2 objectAtIndex:1]];
            
            if([[temp2 objectAtIndex:0] length] > 1) {
                jobSlot2.hidden=NO;
                hoursField2.hidden=NO;
            }
        }
        else if(i==1) {
            if([[temp2 objectAtIndex:0] length] > 1) {
                jobSlot2.hidden=NO;
                hoursField2.hidden=NO;
                jobSlot3.hidden=NO;
                hoursField3.hidden=NO;
            }
            [jobSlot2 setTitle:[temp2 objectAtIndex:0] forState:UIControlStateNormal];
            [hoursField2 setText:[temp2 objectAtIndex:1]];
        }
        else if(i==2) {
            if([[temp2 objectAtIndex:0] length] > 1) {
                jobSlot3.hidden=NO;
                hoursField3.hidden=NO;
                jobSlot4.hidden=NO;
                hoursField4.hidden=NO;
            }
            [jobSlot3 setTitle:[temp2 objectAtIndex:0] forState:UIControlStateNormal];
            [hoursField3 setText:[temp2 objectAtIndex:1]];
        }
        else if(i==3) {
            if([[temp2 objectAtIndex:0] length] > 1) {
                jobSlot4.hidden=NO;
                hoursField4.hidden=NO;
                jobSlot5.hidden=NO;
                hoursField5.hidden=NO;
            }
            [jobSlot4 setTitle:[temp2 objectAtIndex:0] forState:UIControlStateNormal];
            [hoursField4 setText:[temp2 objectAtIndex:1]];
        }
        else if(i==4) {
            if([[temp2 objectAtIndex:0] length] > 1) {
                jobSlot5.hidden=NO;
                hoursField5.hidden=NO;
                jobSlot6.hidden=NO;
                hoursField6.hidden=NO;
            }
            [jobSlot5 setTitle:[temp2 objectAtIndex:0] forState:UIControlStateNormal];
            [hoursField5 setText:[temp2 objectAtIndex:1]];
        }
        
        else if(i==5) {
            if([[temp2 objectAtIndex:0] length] > 1) {
                jobSlot6.hidden=NO;
                hoursField6.hidden=NO;
                jobSlot7.hidden=NO;
                hoursfield7.hidden=NO;
            }
            [jobSlot6 setTitle:[temp2 objectAtIndex:0] forState:UIControlStateNormal];
            [hoursField6 setText:[temp2 objectAtIndex:1]];
        }
        else if(i==6) {
            if([[temp2 objectAtIndex:0] length] > 1) {
                jobSlot7.hidden=NO;
                hoursfield7.hidden=NO;
                jobSlot8.hidden=NO;
                hoursField8.hidden=NO;
            }
            [jobSlot7 setTitle:[temp2 objectAtIndex:0] forState:UIControlStateNormal];
            [hoursfield7 setText:[temp2 objectAtIndex:1]];
        }
        else if(i==7) {
            if([[temp2 objectAtIndex:0] length] > 1) {
                jobSlot8.hidden=NO;
                hoursField8.hidden=NO;
                jobSlot9.hidden=NO;
                hoursField9.hidden=NO;
            }
            [jobSlot8 setTitle:[temp2 objectAtIndex:0] forState:UIControlStateNormal];
            [hoursField8 setText:[temp2 objectAtIndex:1]];
        }
        else if(i==8) {
            if([[temp2 objectAtIndex:0] length] > 1) {
                jobSlot9.hidden=NO;
                hoursField9.hidden=NO;
                jobSlot10.hidden=NO;
                hoursField10.hidden=NO;
            }
            [jobSlot9 setTitle:[temp2 objectAtIndex:0] forState:UIControlStateNormal];
            [hoursField9 setText:[temp2 objectAtIndex:1]];
        }
        else if(i==9) {
            if([[temp2 objectAtIndex:0] length] > 1) {
                jobSlot10.hidden=NO;
                hoursField10.hidden=NO;
            }
            [jobSlot10 setTitle:[temp2 objectAtIndex:0] forState:UIControlStateNormal];
            [hoursField10 setText:[temp2 objectAtIndex:1]];
        }
    }
    
    //Calculate and display the total hours worked on the given day.
    NSInteger totalHours = [hoursField1.text integerValue] + [hoursField2.text integerValue] + [hoursField3.text integerValue] + [hoursField4.text integerValue] + [hoursField5.text integerValue] + [hoursField6.text integerValue] + [hoursfield7.text integerValue] + [hoursField8.text integerValue] + [hoursField9.text integerValue] + [hoursField10.text integerValue];
    totalHoursField.text = [NSString stringWithFormat:@"Total: %i hours", totalHours];
    
    [self updateHourSlots];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    hoursSelected = textField;
}

- (IBAction)jobSelector:(id)sender {
    [hoursSelected resignFirstResponder];
    
    UIButton *button = (UIButton *)sender;
    if (button.tag == 100)
    {
        [self setJobIndex:1];        
    }
    else if (button.tag == 101)
    {
        [self setJobIndex:2];
    }
    else if (button.tag == 102)
    {
        [self setJobIndex:3];
    }
    else if (button.tag == 103)
    {
        [self setJobIndex:4];
    }
    else if (button.tag == 104)
    {
        [self setJobIndex:5];
    }
    
    else if (button.tag == 105)
    {
        [self setJobIndex:6];
    }
    else if (button.tag == 106)
    {
        [self setJobIndex:7];
    }
    else if (button.tag == 107)
    {
        [self setJobIndex:8];
    }
    else if (button.tag == 108)
    {
        [self setJobIndex:9];
    }
    else if (button.tag == 109)
    {
        [self setJobIndex:10];
    }
    
    JobViewController *jobView = [self.storyboard instantiateViewControllerWithIdentifier:@"jobView"];
    jobView.delegate = self;
    popover = [[UIPopoverController alloc] initWithContentViewController:jobView];
    
    CGRect position = CGRectMake(150, 30, 1, 1);
    [popover presentPopoverFromRect:position inView:button permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
}


- (void) prepareForSegue:(UIStoryboardPopoverSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"toJobView"]) {
        
        JobViewController *jobView = [segue destinationViewController];
        jobView.delegate = self;
    }
}


/****************************************************************************************************
 Done
 ****************************************************************************************************/
// When the "Done" button is pressed, update the database with the current hours and return to Week View.
- (IBAction)submitDay:(id)sender {
    [self startLoading];
    
    /*** SUP Connection ***/
    HR_TimesheetTimesheetList *resultList  = [HR_TimesheetTimesheet findStatsFromDay:d.user withDate:d.selectedDate withDay:d.selectedDay];
    if ([resultList length] > 0) {
        
        for (HR_TimesheetTimesheet *res in resultList)
        {      
            @try
            {  
                //Update the job name and hours
                if (res.jobIndex == [NSNumber numberWithInt:1]) {
                    [res setJob:jobSlot1.titleLabel.text];
                    [res setHours:[NSNumber numberWithInt:[hoursField1.text intValue]]];
                }
                else if (res.jobIndex == [NSNumber numberWithInt:2]) {
                    [res setJob:jobSlot2.titleLabel.text];
                    [res setHours:[NSNumber numberWithInt:[hoursField2.text intValue]]];
                }
                else if (res.jobIndex == [NSNumber numberWithInt:3]) {
                    [res setJob:jobSlot3.titleLabel.text];
                    [res setHours:[NSNumber numberWithInt:[hoursField3.text intValue]]];
                }
                else if (res.jobIndex == [NSNumber numberWithInt:4]) {
                    [res setJob:jobSlot4.titleLabel.text];
                    [res setHours:[NSNumber numberWithInt:[hoursField4.text intValue]]];
                }
                else if (res.jobIndex == [NSNumber numberWithInt:5]) {
                    [res setJob:jobSlot5.titleLabel.text];
                    [res setHours:[NSNumber numberWithInt:[hoursField5.text intValue]]];
                }
                else if (res.jobIndex == [NSNumber numberWithInt:6]) {
                    [res setJob:jobSlot6.titleLabel.text];
                    [res setHours:[NSNumber numberWithInt:[hoursField6.text intValue]]];
                }
                else if (res.jobIndex == [NSNumber numberWithInt:7]) {
                    [res setJob:jobSlot7.titleLabel.text];
                    [res setHours:[NSNumber numberWithInt:[hoursfield7.text intValue]]];
                }
                else if (res.jobIndex == [NSNumber numberWithInt:8]) {
                    [res setJob:jobSlot8.titleLabel.text];
                    [res setHours:[NSNumber numberWithInt:[hoursField8.text intValue]]];
                }
                else if (res.jobIndex == [NSNumber numberWithInt:9]) {
                    [res setJob:jobSlot9.titleLabel.text];
                    [res setHours:[NSNumber numberWithInt:[hoursField9.text intValue]]];
                }
                else if (res.jobIndex == [NSNumber numberWithInt:10]) {
                    [res setJob:jobSlot10.titleLabel.text];
                    [res setHours:[NSNumber numberWithInt:[hoursField10.text intValue]]];
                }
                
                [res update];
                [res submitPending];
                [HR_TimesheetHR_TimesheetDB synchronize:@"default"];
            }
            
            @catch (NSException *exception)
            {
                NSLog(@"UPDATE FAILED: %@: %@", [exception name], [exception reason]);
            }
        } //end for-loop
    } //end if-statement
    
    
    /*** Web Host Connection ***/
    /*
    NSString *myRequestString = [NSString stringWithFormat:@"currentUser=%@ &currentDay=%@ &currentDate=%@ &hrs1=%@ &hrs2=%@ &hrs3=%@ &hrs4=%@ &hrs5=%@  &hrs6=%@  &hrs7=%@  &hrs8=%@  &hrs9=%@  &hrs10=%@", d.selectedUser, d.selectedDay, d.selectedDate, hoursField1.text, hoursField2.text, hoursField3.text, hoursField4.text, hoursField5.text, hoursField6.text, hoursfield7.text, hoursField8.text, hoursField9.text, hoursField10.text];
    NSData *myRequestData = [NSData dataWithBytes:[myRequestString UTF8String] length:[myRequestString length]];
    
    NSString *url = @"http://rapidcon.startlogic.com/afurusawa/RapidHR/dayView_updater.php";
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
    [request setHTTPBody: myRequestData];
    [[[NSURLConnection alloc] initWithRequest:request delegate:self] start];
     */
    
    [self endLoading];
    [self.delegate reloadView];
    [self.navigationController popViewControllerAnimated:YES]; //Pop view
}

    //Checks if the input for the hours is greater than 24. If it is, the value of the field is set to 24. The new total is calculated and displayed.
    - (IBAction)updateHours:(UITextField *)sender {
        if([sender.text intValue] > 24)
        {
            sender.text = @"24"; 
        }
        
        NSInteger total = [hoursField1.text integerValue] + [hoursField2.text integerValue] + [hoursField3.text integerValue] + [hoursField4.text integerValue] + [hoursField5.text integerValue] + [hoursField6.text integerValue] + [hoursfield7.text integerValue] + [hoursField8.text integerValue] + [hoursField9.text integerValue] + [hoursField10.text integerValue];
        totalHoursField.text = [NSString stringWithFormat:@"Total: %i hours", total];
    }
    
    /*
     - (IBAction)iPhoneJobSelector:(id)sender {
     UIButton *button = (UIButton *)sender;
     if (button.tag == 100)
     {
     [self setJobIndex:1];
     [self performSegueWithIdentifier:@"toJobView" sender:self];
     }
     else if (button.tag == 101)
     {
     [self setJobIndex:2];
     [self performSegueWithIdentifier:@"toJobView" sender:self];
     }
     else if (button.tag == 102)
     {
     [self setJobIndex:3];
     [self performSegueWithIdentifier:@"toJobView" sender:self];
     }
     else if (button.tag == 103)
     {
     [self setJobIndex:4];
     [self performSegueWithIdentifier:@"toJobView" sender:self];
     }
     else if (button.tag == 104)
     {
     [self setJobIndex:5];
     [self performSegueWithIdentifier:@"toJobView" sender:self];
     }
     
     else if (button.tag == 105)
     {
     [self setJobIndex:6];
     [self performSegueWithIdentifier:@"toJobView" sender:self];
     }
     else if (button.tag == 106)
     {
     [self setJobIndex:7];
     [self performSegueWithIdentifier:@"toJobView" sender:self];
     }
     else if (button.tag == 107)
     {
     [self setJobIndex:8];
     [self performSegueWithIdentifier:@"toJobView" sender:self];
     }
     else if (button.tag == 108)
     {
     [self setJobIndex:9];
     [self performSegueWithIdentifier:@"toJobView" sender:self];
     }
     else if (button.tag == 109)
     {
     [self setJobIndex:10];
     [self performSegueWithIdentifier:@"toJobView" sender:self];
     }
     }
     
     // Called when the UIKeyboardDidShowNotification is sent.
     - (void)keyboardWasShown:(NSNotification*)aNotification
     {
     NSDictionary* info = [aNotification userInfo];
     CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
     
     UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
     scrollView.contentInset = contentInsets;
     scrollView.scrollIndicatorInsets = contentInsets;
     
     // If active text field is hidden by keyboard, scroll it so it's visible
     // Your application might not need or want this behavior.
     CGRect aRect = self.view.frame;
     aRect.size.height -= kbSize.height;
     if (!CGRectContainsPoint(aRect, hoursSelected.frame.origin) ) {
     CGPoint scrollPoint = CGPointMake(0.0, hoursSelected.frame.origin.y-kbSize.height +50);
     [scrollView setContentOffset:scrollPoint animated:YES];
     }
     }
     
     // Called when the UIKeyboardWillHideNotification is sent
     - (void)keyboardWillBeHidden:(NSNotification*)aNotification
     {
     UIEdgeInsets contentInsets = UIEdgeInsetsZero;
     scrollView.contentInset = contentInsets;
     scrollView.scrollIndicatorInsets = contentInsets;
     }
     */

/****************************************************************************************************
 Internal Methods
 ****************************************************************************************************/
- (void)updateJobSlots
{
    if([jobSlot1.titleLabel.text length] > 1) {
        jobSlot2.hidden = NO;
        hoursField2.hidden = NO;
    }
    else {
        jobSlot2.hidden = YES;
        hoursField2.hidden = YES;
    }
    
    if([jobSlot2.titleLabel.text length] > 1) {
        jobSlot3.hidden = NO;
        hoursField3.hidden = NO;
    }
    else {
        jobSlot3.hidden = YES;
        hoursField3.hidden = YES;
    }
    
    if([jobSlot3.titleLabel.text length] > 1) {
        jobSlot4.hidden = NO;
        hoursField4.hidden = NO;
    }
    else {
        jobSlot4.hidden = YES;
        hoursField4.hidden = YES;
    }
    
    if([jobSlot4.titleLabel.text length] > 1) {
        jobSlot5.hidden = NO;
        hoursField5.hidden = NO;
    }
    else {
        jobSlot5.hidden = YES;
        hoursField5.hidden = YES;
    }
    
    if([jobSlot5.titleLabel.text length] > 1) {
        jobSlot6.hidden = NO;
        hoursField6.hidden = NO;
    }
    else {
        jobSlot6.hidden = YES;
        hoursField6.hidden = YES;
    }
    
    if([jobSlot6.titleLabel.text length] > 1) {
        jobSlot7.hidden = NO;
        hoursfield7.hidden = NO;
    }
    else {
        jobSlot7.hidden = YES;
        hoursfield7.hidden = YES;
    }
    
    if([jobSlot7.titleLabel.text length] > 1) {
        jobSlot8.hidden = NO;
        hoursField8.hidden = NO;
    }
    else {
        jobSlot8.hidden = YES;
        hoursField8.hidden = YES;
    }
    
    if([jobSlot8.titleLabel.text length] > 1) {
        jobSlot9.hidden = NO;
        hoursField9.hidden = NO;
    }
    else {
        jobSlot9.hidden = YES;
        hoursField9.hidden = YES;
    }
    
    if([jobSlot9.titleLabel.text length] > 1) {
        jobSlot10.hidden = NO;
        hoursField10.hidden = NO;
    }
    else {
        jobSlot10.hidden = YES;
        hoursField10.hidden = YES;
    }
}

-(void)updateHourSlots
{    
    if([jobSlot1.currentTitle length] > 1) {
        hoursField1.enabled = YES;
        hoursField1.textColor = [UIColor blackColor];
    }
    else {
        hoursField1.enabled = NO;
        hoursField1.textColor = [UIColor lightGrayColor];
    }
    
    if([jobSlot2.currentTitle length] > 1) {
        hoursField2.enabled = YES;
        hoursField2.textColor = [UIColor blackColor];
    }
    else {
        hoursField2.enabled = NO;
        hoursField2.textColor = [UIColor lightGrayColor];
    }
    
    if([jobSlot3.currentTitle length] > 1) {
        hoursField3.textColor = [UIColor blackColor];
        hoursField3.enabled = YES;
    }
    else {
        hoursField3.enabled = NO;
        hoursField3.textColor = [UIColor lightGrayColor];
    }
    
    if([jobSlot4.currentTitle length] > 1) {
        hoursField4.textColor = [UIColor blackColor];
        hoursField4.enabled = YES;
    }
    else {
        hoursField4.enabled = NO;
        hoursField4.textColor = [UIColor lightGrayColor];
    }
    
    if([jobSlot5.currentTitle length] > 1) {
        hoursField5.textColor = [UIColor blackColor];
        hoursField5.enabled = YES;
    }
    else {
        hoursField5.enabled = NO;
        hoursField5.textColor = [UIColor lightGrayColor];
    }
    
    if([jobSlot6.currentTitle length] > 1) {
        hoursField6.textColor = [UIColor blackColor];
        hoursField6.enabled = YES;
    }
    else {
        hoursField6.enabled = NO;
        hoursField6.textColor = [UIColor lightGrayColor];
    }
    if([jobSlot7.currentTitle length] > 1) {
        hoursfield7.textColor = [UIColor blackColor];
        hoursfield7.enabled = YES;
    }
    else {
        hoursfield7.enabled = NO;
        hoursfield7.textColor = [UIColor lightGrayColor];
    }
    if([jobSlot8.currentTitle length] > 1) {
        hoursField8.textColor = [UIColor blackColor];
        hoursField8.enabled = YES;
    }
    else {
        hoursField8.enabled = NO;
        hoursField8.textColor = [UIColor lightGrayColor];
    }
    if([jobSlot9.currentTitle length] > 1) {
        hoursField9.textColor = [UIColor blackColor];
        hoursField9.enabled = YES;
    }
    else {
        hoursField9.enabled = NO;
        hoursField9.textColor = [UIColor lightGrayColor];
    }
    if([jobSlot10.currentTitle length] > 1) {
        hoursField10.textColor = [UIColor blackColor];
        hoursField10.enabled = YES;
    }
    else {
        hoursField10.enabled = NO;
        hoursField10.textColor = [UIColor lightGrayColor];
    }
}

- (void) addEmptyEntryAtIndex:(NSInteger)i
{
    HR_TimesheetTimesheet *temp = [[HR_TimesheetTimesheet alloc] init];
    
    [temp setEmployeeID:d.user];
    [temp setDay:d.selectedDay];
    [temp setDate:d.selectedDate];
    [temp setJobIndex:[NSNumber numberWithInt:i]];
    [temp setHours:[NSNumber numberWithInt:0]];
    
    [temp create];
    [temp submitPending];
    [HR_TimesheetHR_TimesheetDB synchronize:@"default"];
}

//Indicator Methods
- (void)startLoading {
    
    [activity startAnimating];
    grayOutImage.hidden = NO;
    
    hoursField1.enabled = NO;
    hoursField2.enabled = NO;
    hoursField3.enabled = NO;
    hoursField4.enabled = NO;
    hoursField5.enabled = NO;
    hoursField6.enabled = NO;
    hoursfield7.enabled = NO;
    hoursField8.enabled = NO;
    hoursField9.enabled = NO;
    hoursField10.enabled = NO;
    
    jobSlot1.enabled = NO;
    jobSlot2.enabled = NO;
    jobSlot3.enabled = NO;
    jobSlot4.enabled = NO;
    jobSlot5.enabled = NO;
    jobSlot6.enabled = NO;
    jobSlot7.enabled = NO;
    jobSlot8.enabled = NO;
    jobSlot9.enabled = NO;
    jobSlot10.enabled = NO;
}
- (void)endLoading {
    
    [activity stopAnimating];
    grayOutImage.hidden = YES;
    
    hoursField1.enabled = YES;
    hoursField2.enabled = YES;
    hoursField3.enabled = YES;
    hoursField4.enabled = YES;
    hoursField5.enabled = YES;
    hoursField6.enabled = YES;
    hoursfield7.enabled = YES;
    hoursField8.enabled = YES;
    hoursField9.enabled = YES;
    hoursField10.enabled = YES;
    
    jobSlot1.enabled = YES;
    jobSlot2.enabled = YES;
    jobSlot3.enabled = YES;
    jobSlot4.enabled = YES;
    jobSlot5.enabled = YES;
    jobSlot6.enabled = YES;
    jobSlot7.enabled = YES;
    jobSlot8.enabled = YES;
    jobSlot9.enabled = YES;
    jobSlot10.enabled = YES;
    
}
@end
