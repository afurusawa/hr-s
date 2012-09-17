//
//  UserWeekViewController.m
//  Timesheet
//
//  Created by Andrew Furusawa on 7/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UserWeekViewController.h"
#import "TimesheetDate.h"
#import "AppDelegate.h"
#import "HR_SuiteTimesheet.h"
#import "HR_SuiteUsers.h"
#import "HR_SuiteTimesheetApprovals.h"
#import "HR_SuiteHR_SuiteDB.h"

@implementation UserWeekViewController
{
    AppDelegate *d;
    TimesheetDate *tsDate;
    NSDictionary *entry;
    HR_SuiteTimesheetList *SUPTimesheet;
    NSString *currentWeek; //Stores value of the Monday of this week
    int weekPositionOffset; //Stores the offset for the current week (e.g. last week = -1)
}

@synthesize nextWeekButton, previousWeekButton, status, managerNotesButton;
@synthesize mondayButton, tuesdayButton, wednesdayButton, thursdayButton, fridayButton, saturdayButton, sundayButton;
@synthesize submitButton;
@synthesize mondayProjects, tuesdayProjects, wednesdayProjects, thursdayProjects, fridayProjects, saturdayProjects, sundayProjects;
@synthesize mondayHours, tuesdayHours, wednesdayHours, thursdayHours, fridayHours, saturdayHours, sundayHours, totalHours;
@synthesize mondaysDate, tuesdaysDate, wednesdaysDate, thursdaysDate, fridaysDate, saturdaysDate, sundaysDate;
@synthesize selectedDay;
@synthesize selectedDate;



/****************************************************************************************************
 Protocol Methods
 ****************************************************************************************************/
- (void)reloadView
{    

    // View arrived through Time Entry
    if ([d.weekView isEqualToString:@"current"])
    {
        //[self highlightToday];
        
        if (weekPositionOffset == 0)
            nextWeekButton.hidden = YES;
        else
            nextWeekButton.hidden = NO;

        // Load data for the previous week and display it
        NSArray *temp = [d.selectedDate componentsSeparatedByString:@"/"];
        NSInteger day = [[temp objectAtIndex:1] intValue];
        NSInteger month = [[temp objectAtIndex:0] intValue];
        NSInteger year = [[temp objectAtIndex:2] intValue];
        [self loadCurrentWeek:month day:day year:year];
    }
    
    // View arrived through History
    else {
        
        // Disable week navigation buttons
        nextWeekButton.hidden = YES;
        previousWeekButton.hidden = YES;
        
        if ([d.historyState isEqualToString:@"Status: Denied"] || [d.historyState isEqualToString:@"Status: Waiting for approval"]) {
            [submitButton setTitle:@"Resubmit" forState:UIControlStateNormal];
            submitButton.hidden = NO;
        }
        else if ([d.historyState isEqualToString:@"Status: Approved"]) {
            submitButton.hidden = YES;
        }
        
        //d.selectedDate = d.weekView; // "d.weekView"s value is the date when it comes from history. 
        
        // Parse the current date to set the dates on the view using setDates.
        NSArray *temp = [d.selectedDate componentsSeparatedByString:@"/"]; //index 0=month 1=day 2=year
        NSInteger month = [[temp objectAtIndex:0] intValue];
        NSInteger day = [[temp objectAtIndex:1] intValue];
        NSInteger year = [[temp objectAtIndex:2] intValue];
        [self setDates:@"Monday" month:month day:day year:year];
    }
    
    
    /**********************/
    /*** SUP Connection ***/
    /**********************/
    if (d.isSUPConnection) {
        
        //Find the timesheets for a given week, and calculate the hours and tasks per day.
        SUPTimesheet = [HR_SuiteTimesheet findByEmployeeIDandDate:d.user withDate:d.selectedDate]; //load from SUP.
        
        if ([SUPTimesheet length] > 0)
        {
            NSInteger hm=0, ht=0, hw=0, hth=0, hf=0, hs=0, hsu=0; //total hours per day for each day.
            NSInteger jm=0, jt=0, jw=0, jth=0, jf=0, js=0, jsu=0; //total jobs per day for each day.
            
            // Set totals hours and total tasks per day for every day of the week
            for (HR_SuiteTimesheet *supItem in SUPTimesheet)
            {
                if ([supItem.day isEqualToString:@"Monday"]) {
                    hm += [supItem.hours intValue]; //Add hours.
                    if([supItem.job length] > 1) {
                        jm++; //If a job is found, increment job count.
                    }
                }
                else if ([supItem.day isEqualToString:@"Tuesday"]) {
                    ht += [supItem.hours intValue];
                    if([supItem.job length] > 1) {
                        jt++;
                    }               
                }
                else if ([supItem.day isEqualToString:@"Wednesday"]) {
                    hw += [supItem.hours intValue];
                    if([supItem.job length] > 1) {
                        jw++;
                    }               
                }
                else if ([supItem.day isEqualToString:@"Thursday"]) {
                    hth += [supItem.hours intValue];
                    if([supItem.job length] > 1) {
                        jth++;
                    }               
                }
                else if ([supItem.day isEqualToString:@"Friday"]) {
                    hf += [supItem.hours intValue];
                    if([supItem.job length] > 1) {
                        jf++;
                    }               
                }
                else if ([supItem.day isEqualToString:@"Saturday"]) {
                    hs += [supItem.hours intValue];
                    if([supItem.job length] > 1) {
                        js++;
                    }               
                }
                else if ([supItem.day isEqualToString:@"Sunday"]) {
                    hsu += [supItem.hours intValue];
                    if([supItem.job length] > 1) {
                        jsu++;
                    }               
                }
                
            } //end for-loop
            
            //Set hours and tasks in view
            [mondayHours setText:[NSString stringWithFormat:@"%i hours", hm]];
            [mondayProjects setText:[NSString stringWithFormat:@"on %i tasks", jm]];
            [tuesdayHours setText:[NSString stringWithFormat:@"%i hours", ht]];
            [tuesdayProjects setText:[NSString stringWithFormat:@"on %i tasks", jt]];
            [wednesdayHours setText:[NSString stringWithFormat:@"%i hours", hw]];
            [wednesdayProjects setText:[NSString stringWithFormat:@"on %i tasks", jw]];
            [thursdayHours setText:[NSString stringWithFormat:@"%i hours", hth]];
            [thursdayProjects setText:[NSString stringWithFormat:@"on %i tasks", jth]];
            [fridayHours setText:[NSString stringWithFormat:@"%i hours", hf]];
            [fridayProjects setText:[NSString stringWithFormat:@"on %i tasks", jf]];
            [saturdayHours setText:[NSString stringWithFormat:@"%i hours", hs]];
            [saturdayProjects setText:[NSString stringWithFormat:@"on %i tasks", js]];
            [sundayHours setText:[NSString stringWithFormat:@"%i hours", hsu]];
            [sundayProjects setText:[NSString stringWithFormat:@"on %i tasks", jsu]];
            
            //Set the sign using TimesheetApprovals
            NSInteger signState = 0;
            HR_SuiteTimesheetApprovalsList *list = [HR_SuiteTimesheetApprovals findAll];
            for (HR_SuiteTimesheetApprovals *item in list) {
                if ([item.date isEqualToString:d.selectedDate]) {
                    signState = [item.signCode intValue];
                }
            }
            
            if(signState == 1) {
                status.text = @"Waiting for approval";
                managerNotesButton.hidden = YES;
            }
            else if(signState == 99) {
                status.text = @"Denied";
                managerNotesButton.hidden = NO;
                
            }
            else if(signState == 100) {
                status.text = @"Approved";
                managerNotesButton.hidden = YES;
            }
            else {
                status.text = @"Waiting for submission";
                managerNotesButton.hidden = YES;
            }
            
        }    
    } //end sup
    
    
    /************/
    /*   DEMO   */
    /************/
    else {
        NSInteger hm=0, ht=0, hw=0, hth=0, hf=0, hs=0, hsu=0; //total hours per day for each day.
        NSInteger jm=0, jt=0, jw=0, jth=0, jf=0, js=0, jsu=0; //total jobs per day for each day.
        
        for (int i = 0; i < [d.HR_Suite count]; i++) {
            NSDictionary *item = [d.HR_Suite objectAtIndex:i];
            BOOL isUser = [[item objectForKey:@"employeeID"] isEqualToString:d.user];
            BOOL isDate = [[item objectForKey:@"date"] isEqualToString:d.selectedDate];
            
            if (isUser && isDate) {
                
                // Set totals hours and total tasks per day for every day of the week
                if ([[item objectForKey:@"day"] isEqualToString:@"Monday"]) {
                    hm += [[item objectForKey:@"hours"] intValue]; //Add hours.
                    if([[item objectForKey:@"job"] length] > 1) {
                        jm++; //If a job is found, increment job count.
                    }
                }
                else if ([[item objectForKey:@"day"] isEqualToString:@"Tuesday"]) {
                    ht += [[item objectForKey:@"hours"] intValue];
                    if([[item objectForKey:@"job"] length] > 1) {
                        jt++;
                    }               
                }
                else if ([[item objectForKey:@"day"] isEqualToString:@"Wednesday"]) {
                    hw += [[item objectForKey:@"hours"] intValue];
                    if([[item objectForKey:@"job"] length] > 1) {
                        jw++;
                    }               
                }
                else if ([[item objectForKey:@"day"] isEqualToString:@"Thursday"]) {
                    hth += [[item objectForKey:@"hours"] intValue];
                    if([[item objectForKey:@"job"] length] > 1) {
                        jth++;
                    }               
                }
                else if ([[item objectForKey:@"day"] isEqualToString:@"Friday"]) {
                    hf += [[item objectForKey:@"hours"] intValue];
                    if([[item objectForKey:@"job"] length] > 1) {
                        jf++;
                    }               
                }
                else if ([[item objectForKey:@"day"] isEqualToString:@"Saturday"]) {
                    hs += [[item objectForKey:@"hours"] intValue];
                    if([[item objectForKey:@"job"] length] > 1) {
                        js++;
                    }               
                }
                else if ([[item objectForKey:@"day"] isEqualToString:@"Sunday"]) {
                    hsu += [[item objectForKey:@"hours"] intValue];
                    if([[item objectForKey:@"job"] length] > 1) {
                        jsu++;
                    }               
                }
                
                //Set hours and tasks in view
                [mondayHours setText:[NSString stringWithFormat:@"%i hours", hm]];
                [mondayProjects setText:[NSString stringWithFormat:@"on %i tasks", jm]];
                [tuesdayHours setText:[NSString stringWithFormat:@"%i hours", ht]];
                [tuesdayProjects setText:[NSString stringWithFormat:@"on %i tasks", jt]];
                [wednesdayHours setText:[NSString stringWithFormat:@"%i hours", hw]];
                [wednesdayProjects setText:[NSString stringWithFormat:@"on %i tasks", jw]];
                [thursdayHours setText:[NSString stringWithFormat:@"%i hours", hth]];
                [thursdayProjects setText:[NSString stringWithFormat:@"on %i tasks", jth]];
                [fridayHours setText:[NSString stringWithFormat:@"%i hours", hf]];
                [fridayProjects setText:[NSString stringWithFormat:@"on %i tasks", jf]];
                [saturdayHours setText:[NSString stringWithFormat:@"%i hours", hs]];
                [saturdayProjects setText:[NSString stringWithFormat:@"on %i tasks", js]];
                [sundayHours setText:[NSString stringWithFormat:@"%i hours", hsu]];
                [sundayProjects setText:[NSString stringWithFormat:@"on %i tasks", jsu]];
                

                
                //Set the sign using TimesheetApprovals
                NSInteger signState = 0;
                //HR_SuiteTimesheetApprovalsList *list = [HR_SuiteTimesheetApprovals findAll];
                for (NSDictionary *item in d.hr_approvals) {
                    if ([[item objectForKey:@"date"] isEqualToString:d.selectedDate] && [[item objectForKey:@"employeeID"] isEqualToString:d.user]) {
                        signState = [[item objectForKey:@"signCode"] intValue];
                    }
                }

                if(signState == 1) {
                    status.text = @"Waiting for approval";
                    managerNotesButton.hidden = YES;
                }
                else if(signState == 99) {
                    status.text = @"Denied";
                    managerNotesButton.hidden = NO;
                }
                else if(signState == 100) {
                    status.text = @"Approved";
                    managerNotesButton.hidden = YES;
                }
                else {
                    status.text = @"Waiting for submission";
                    managerNotesButton.hidden = YES;
                }
                
                
            } //if
        } //for
        
    } //end demo
    
    
    // Using the text fields, calculate the total number of hours worked for the current week.
    NSInteger total = [mondayHours.text integerValue] + [tuesdayHours.text integerValue] + [wednesdayHours.text integerValue] + [thursdayHours.text integerValue] + [fridayHours.text integerValue] + [saturdayHours.text integerValue] + [sundayHours.text integerValue];
    totalHours.text = [NSString stringWithFormat:@"%i hours", total];   
}



/****************************************************************************************************
 View Did Appear
 ****************************************************************************************************/
- (void)viewDidAppear:(BOOL)animated {
    if ([d.weekView isEqualToString:@"current"])
    {
        //[self highlightToday];
    }
}



/****************************************************************************************************
 View Did Load
 ****************************************************************************************************/
- (void)viewDidLoad {  
    
    // Initializations
    d = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    tsDate = [[TimesheetDate alloc] init];
    weekPositionOffset = 0;


    // View arrived through Time Entry
    if ([d.weekView isEqualToString:@"current"])
    {
        [self highlightToday];
        
        NSString *today = [tsDate getTodaysDay];
        NSDateComponents *components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:[NSDate date]];
        NSInteger day = [components day];
        NSInteger month = [components month];
        NSInteger year = [components year];
     
        [self setDates:today month:month day:day year:year]; // sets the dates for the view.
        
        d.selectedDate = mondaysDate.text; // save mondays date of this week. 
        currentWeek = d.selectedDate; // save the value of this week.
    }
    
    // View arrived through History
    else {
        
        // Disable week navigation buttons
        nextWeekButton.hidden = YES;
        previousWeekButton.hidden = YES;
        
        if ([d.historyState isEqualToString:@"Status: Denied"] || [d.historyState isEqualToString:@"Status: Waiting for approval"]) {
            [submitButton setTitle:@"Resubmit" forState:UIControlStateNormal];
            submitButton.hidden = NO;
            d.historyState = @"";
        }
        else if ([d.historyState isEqualToString:@"Status: Approved"]) {
            submitButton.hidden = YES;
            d.historyState = @"Status: Approved";
        }
        else if ([status.text isEqualToString:@"Waiting for submission"]) {
            [submitButton setTitle:@"Submit" forState:UIControlStateNormal];
            submitButton.hidden = NO;
            d.historyState = @"";
        }
        
        d.selectedDate = d.weekView; // "d.weekView"s value is the date when it comes from history. 

        // Parse the current date to set the dates on the view using setDates.
        NSArray *temp = [d.selectedDate componentsSeparatedByString:@"/"]; //index 0=month 1=day 2=year
        NSInteger month = [[temp objectAtIndex:0] intValue];
        NSInteger day = [[temp objectAtIndex:1] intValue];
        NSInteger year = [[temp objectAtIndex:2] intValue];
        [self setDates:@"Monday" month:month day:day year:year];
    }
    
    
    /**********************/
    /*   SUP Connection   */
    /**********************/
    if (d.isSUPConnection) {
        
        //Find the timesheets for a given week, and calculate the hours and tasks per day.
        SUPTimesheet = [HR_SuiteTimesheet findByEmployeeIDandDate:d.user withDate:d.selectedDate]; //load from SUP.
        
        if ([SUPTimesheet length] > 0)
        {
            NSInteger hm=0, ht=0, hw=0, hth=0, hf=0, hs=0, hsu=0; //total hours per day for each day.
            NSInteger jm=0, jt=0, jw=0, jth=0, jf=0, js=0, jsu=0; //total jobs per day for each day.
            
            // Set totals hours and total tasks per day for every day of the week
            for (HR_SuiteTimesheet *supItem in SUPTimesheet)
            {
                if ([supItem.day isEqualToString:@"Monday"]) {
                    hm += [supItem.hours intValue]; //Add hours.
                    if([supItem.job length] > 1) {
                        jm++; //If a job is found, increment job count.
                    }
                }
                else if ([supItem.day isEqualToString:@"Tuesday"]) {
                    ht += [supItem.hours intValue];
                    if([supItem.job length] > 1) {
                        jt++;
                    }               
                }
                else if ([supItem.day isEqualToString:@"Wednesday"]) {
                    hw += [supItem.hours intValue];
                    if([supItem.job length] > 1) {
                        jw++;
                    }               
                }
                else if ([supItem.day isEqualToString:@"Thursday"]) {
                    hth += [supItem.hours intValue];
                    if([supItem.job length] > 1) {
                        jth++;
                    }               
                }
                else if ([supItem.day isEqualToString:@"Friday"]) {
                    hf += [supItem.hours intValue];
                    if([supItem.job length] > 1) {
                        jf++;
                    }               
                }
                else if ([supItem.day isEqualToString:@"Saturday"]) {
                    hs += [supItem.hours intValue];
                    if([supItem.job length] > 1) {
                        js++;
                    }               
                }
                else if ([supItem.day isEqualToString:@"Sunday"]) {
                    hsu += [supItem.hours intValue];
                    if([supItem.job length] > 1) {
                        jsu++;
                    }               
                }
                
            } //end for-loop
            
            //Set hours and tasks in view
            [mondayHours setText:[NSString stringWithFormat:@"%i hours", hm]];
            [mondayProjects setText:[NSString stringWithFormat:@"on %i tasks", jm]];
            [tuesdayHours setText:[NSString stringWithFormat:@"%i hours", ht]];
            [tuesdayProjects setText:[NSString stringWithFormat:@"on %i tasks", jt]];
            [wednesdayHours setText:[NSString stringWithFormat:@"%i hours", hw]];
            [wednesdayProjects setText:[NSString stringWithFormat:@"on %i tasks", jw]];
            [thursdayHours setText:[NSString stringWithFormat:@"%i hours", hth]];
            [thursdayProjects setText:[NSString stringWithFormat:@"on %i tasks", jth]];
            [fridayHours setText:[NSString stringWithFormat:@"%i hours", hf]];
            [fridayProjects setText:[NSString stringWithFormat:@"on %i tasks", jf]];
            [saturdayHours setText:[NSString stringWithFormat:@"%i hours", hs]];
            [saturdayProjects setText:[NSString stringWithFormat:@"on %i tasks", js]];
            [sundayHours setText:[NSString stringWithFormat:@"%i hours", hsu]];
            [sundayProjects setText:[NSString stringWithFormat:@"on %i tasks", jsu]];
            
            //Set the sign using TimesheetApprovals
            NSInteger signState = 0;
            HR_SuiteTimesheetApprovalsList *list = [HR_SuiteTimesheetApprovals findAll];
            for (HR_SuiteTimesheetApprovals *item in list) {
                if ([item.date isEqualToString:d.selectedDate]) {
                    signState = [item.signCode intValue];
                }
            }
            
            NSLog(@"SIGN STATE +======= %i", signState);
            
            if(signState == 1) {
                status.text = @"Waiting for approval";
                managerNotesButton.hidden = YES;
            }
            else if(signState == 99) {
                status.text = @"Denied";
                managerNotesButton.hidden = NO;
                
            }
            else if(signState == 100) {
                status.text = @"Approved";
                managerNotesButton.hidden = YES;
            }
            else {
                status.text = @"Waiting for submission";
                managerNotesButton.hidden = YES;
            }
            
            // Change button label/availability depending on the status
            if ([status.text isEqualToString:@"Denied"] || [status.text isEqualToString:@"Waiting for approval"]) {
                [submitButton setTitle:@"Resubmit" forState:UIControlStateNormal];
                submitButton.hidden = NO;
                d.historyState = @"";
            }
            else if ([status.text isEqualToString:@"Approved"]) {
                submitButton.hidden = YES;
                d.historyState = @"Status: Approved";
            }
            else if ([status.text isEqualToString:@"Waiting for submission"]) {
                [submitButton setTitle:@"Submit" forState:UIControlStateNormal];
                submitButton.hidden = NO;
                d.historyState = @"";
            }
        }    
    } //end sup
    
    
    /************/
    /*   DEMO   */
    /************/
    else {
        NSInteger hm=0, ht=0, hw=0, hth=0, hf=0, hs=0, hsu=0; //total hours per day for each day.
        NSInteger jm=0, jt=0, jw=0, jth=0, jf=0, js=0, jsu=0; //total jobs per day for each day.
        
        for (int i = 0; i < [d.HR_Suite count]; i++) {
            NSDictionary *item = [d.HR_Suite objectAtIndex:i];
            BOOL isUser = [[item objectForKey:@"employeeID"] isEqualToString:d.user];
            BOOL isDate = [[item objectForKey:@"date"] isEqualToString:d.selectedDate];
            
            if (isUser && isDate) {
                
                // Set totals hours and total tasks per day for every day of the week
                if ([[item objectForKey:@"day"] isEqualToString:@"Monday"]) {
                    hm += [[item objectForKey:@"hours"] intValue]; //Add hours.
                    if([[item objectForKey:@"job"] length] > 1) {
                        jm++; //If a job is found, increment job count.
                    }
                }
                else if ([[item objectForKey:@"day"] isEqualToString:@"Tuesday"]) {
                    ht += [[item objectForKey:@"hours"] intValue];
                    if([[item objectForKey:@"job"] length] > 1) {
                        jt++;
                    }               
                }
                else if ([[item objectForKey:@"day"] isEqualToString:@"Wednesday"]) {
                    hw += [[item objectForKey:@"hours"] intValue];
                    if([[item objectForKey:@"job"] length] > 1) {
                        jw++;
                    }               
                }
                else if ([[item objectForKey:@"day"] isEqualToString:@"Thursday"]) {
                    hth += [[item objectForKey:@"hours"] intValue];
                    if([[item objectForKey:@"job"] length] > 1) {
                        jth++;
                    }               
                }
                else if ([[item objectForKey:@"day"] isEqualToString:@"Friday"]) {
                    hf += [[item objectForKey:@"hours"] intValue];
                    if([[item objectForKey:@"job"] length] > 1) {
                        jf++;
                    }               
                }
                else if ([[item objectForKey:@"day"] isEqualToString:@"Saturday"]) {
                    hs += [[item objectForKey:@"hours"] intValue];
                    if([[item objectForKey:@"job"] length] > 1) {
                        js++;
                    }               
                }
                else if ([[item objectForKey:@"day"] isEqualToString:@"Sunday"]) {
                    hsu += [[item objectForKey:@"hours"] intValue];
                    if([[item objectForKey:@"job"] length] > 1) {
                        jsu++;
                    }               
                }

                //Set hours and tasks in view
                [mondayHours setText:[NSString stringWithFormat:@"%i hours", hm]];
                [mondayProjects setText:[NSString stringWithFormat:@"on %i tasks", jm]];
                [tuesdayHours setText:[NSString stringWithFormat:@"%i hours", ht]];
                [tuesdayProjects setText:[NSString stringWithFormat:@"on %i tasks", jt]];
                [wednesdayHours setText:[NSString stringWithFormat:@"%i hours", hw]];
                [wednesdayProjects setText:[NSString stringWithFormat:@"on %i tasks", jw]];
                [thursdayHours setText:[NSString stringWithFormat:@"%i hours", hth]];
                [thursdayProjects setText:[NSString stringWithFormat:@"on %i tasks", jth]];
                [fridayHours setText:[NSString stringWithFormat:@"%i hours", hf]];
                [fridayProjects setText:[NSString stringWithFormat:@"on %i tasks", jf]];
                [saturdayHours setText:[NSString stringWithFormat:@"%i hours", hs]];
                [saturdayProjects setText:[NSString stringWithFormat:@"on %i tasks", js]];
                [sundayHours setText:[NSString stringWithFormat:@"%i hours", hsu]];
                [sundayProjects setText:[NSString stringWithFormat:@"on %i tasks", jsu]];
                
                
                NSLog(@"WHASDASDJKALHSDJASD \n\n\n\n\n %@", d.hr_approvals);
                
                //Set the sign using TimesheetApprovals
                NSInteger signState = 0;
                //HR_SuiteTimesheetApprovalsList *list = [HR_SuiteTimesheetApprovals findAll];
                for (NSDictionary *item in d.hr_approvals) {
                    if ([[item objectForKey:@"date"] isEqualToString:d.selectedDate] && [[item objectForKey:@"employeeID"] isEqualToString:d.user]) {
                        signState = [[item objectForKey:@"signCode"] intValue];
                    }
                }
                
                
                NSLog(@"SIGN STATE +======= %i", signState);
                

                
                if(signState == 1) {
                    status.text = @"Waiting for approval";
                    managerNotesButton.hidden = YES;
                }
                else if(signState == 99) {
                    //NSLog(@"STATUS IS DENIED");
                    status.text = @"Denied";
                    managerNotesButton.hidden = NO;
                    
                }
                else if(signState == 100) {
                    status.text = @"Approved";
                    managerNotesButton.hidden = YES;
                }
                else {
                    status.text = @"Waiting for submission";
                    managerNotesButton.hidden = YES;
                }
                                     
                // Change button label/availability depending on the status
                if ([status.text isEqualToString:@"Denied"] || [status.text isEqualToString:@"Waiting for approval"]) {
                    [submitButton setTitle:@"Resubmit" forState:UIControlStateNormal];
                    submitButton.hidden = NO;
                    d.historyState = @"";
                }
                else if ([status.text isEqualToString:@"Approved"]) {
                    submitButton.hidden = YES;
                    d.historyState = @"Status: Approved";
                }
                else if ([status.text isEqualToString:@"Waiting for submission"]) {
                    [submitButton setTitle:@"Submit" forState:UIControlStateNormal];
                    submitButton.hidden = NO;
                    d.historyState = @"";
                }
                                     
                                     
            } //if
        } //for
        
    } //end demo
    
    
    // Using the text fields, calculate the total number of hours worked for the current week.
    NSInteger total = [mondayHours.text integerValue] + [tuesdayHours.text integerValue] + [wednesdayHours.text integerValue] + [thursdayHours.text integerValue] + [fridayHours.text integerValue] + [saturdayHours.text integerValue] + [sundayHours.text integerValue];
    totalHours.text = [NSString stringWithFormat:@"%i hours", total];   
}



- (void)viewDidUnload
{
    [self setMondaysDate:nil];
    [self setTuesdaysDate:nil];
    [self setWednesdaysDate:nil];
    [self setThursdaysDate:nil];
    [self setFridaysDate:nil];
    [self setSaturdaysDate:nil];
    [self setSundaysDate:nil];
    [self setMondayHours:nil];
    [self setTuesdayHours:nil];
    [self setWednesdayHours:nil];
    [self setThursdayHours:nil];
    [self setFridayHours:nil];
    [self setSaturdayHours:nil];
    [self setSundayHours:nil];
    [self setMondayProjects:nil];
    [self setTuesdayProjects:nil];
    [self setWednesdayProjects:nil];
    [self setThursdayProjects:nil];
    [self setFridayProjects:nil];
    [self setSaturdayProjects:nil];
    [self setSundayProjects:nil];
    [self setTotalHours:nil];
    [self setMondayButton:nil];
    [self setTuesdayButton:nil];
    [self setWednesdayButton:nil];
    [self setThursdayButton:nil];
    [self setFridayButton:nil];
    [self setSaturdayButton:nil];
    [self setSundayButton:nil];
    [self setStatus:nil];
    [self setSubmitButton:nil];
    [self setManagerNotesButton:nil];
    [self setNextWeekButton:nil];
    [self setPreviousWeekButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}



/****************************************************************************************************
 Prepare for segue and delegate control
 ****************************************************************************************************/
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"toDayView"]) {
        UDayViewController *dayView = [segue destinationViewController];
        dayView.delegate = self;
    }
}


/****************************************************************************************************
 Action for when a day is selected
 ****************************************************************************************************/
//Store the selected day and transition to the day view.
- (IBAction)mondaySelected:(id)sender {
    d.currentDate = mondaysDate.text;
    d.selectedDay = @"Monday";
    [self performSegueWithIdentifier:@"toDayView" sender:self];
    
}
- (IBAction)tuesdaySelected:(id)sender {
    d.currentDate = tuesdaysDate.text;
    d.selectedDay = @"Tuesday";
    [self performSegueWithIdentifier:@"toDayView" sender:self];
    
}
- (IBAction)wednesdaySelected:(id)sender {
    d.currentDate = wednesdaysDate.text;
    d.selectedDay = @"Wednesday";
    [self performSegueWithIdentifier:@"toDayView" sender:self];
    
}
- (IBAction)thursdaySelected:(id)sender {
    d.currentDate = thursdaysDate.text;
    d.selectedDay = @"Thursday";
    [self performSegueWithIdentifier:@"toDayView" sender:self];
    
}
- (IBAction)fridaySelected:(id)sender {
    d.currentDate = fridaysDate.text;
    d.selectedDay = @"Friday";
    [self setSelectedDate:mondaysDate.text];
    [self performSegueWithIdentifier:@"toDayView" sender:self];
    
}
- (IBAction)saturdaySelected:(id)sender {
    d.currentDate = saturdaysDate.text;
    d.selectedDay = @"Saturday";
    [self performSegueWithIdentifier:@"toDayView" sender:self];
    
}
- (IBAction)sundaySelected:(id)sender {
    d.currentDate = sundaysDate.text;
    d.selectedDay = @"Sunday";
    [self performSegueWithIdentifier:@"toDayView" sender:self];
    
}


/****************************************************************************************************
 Submitting Timesheet - START
 ****************************************************************************************************/
// Button action when clicking the "submit" button.
- (IBAction)signTimesheet:(id)sender {
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Enter Password:" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Verify", nil];
    [message setAlertViewStyle:UIAlertViewStyleSecureTextInput];
    [message show];
}

// Button action for the UIAlertView when signing the timesheet.
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{

    /**********************/
    /*   SUP Connection   */
    /**********************/
    if (d.isSUPConnection) {
        
        //Check the password.
        NSString *password = [[alertView textFieldAtIndex:0] text];
        
        // To find if entry exists, get list of submissions for current employee
        HR_SuiteUsersList *ulist = [HR_SuiteUsers findByEmployeeIDAndPassword:d.user withEmployeePassword:password];
        
        // If empty, password is wrong
        if ([ulist length] == 0) {
            return;
        }
        
        for (HR_SuiteUsers *users in ulist) {
            
            HR_SuiteTimesheetApprovalsList *list = [HR_SuiteTimesheetApprovals findAll];
            
            // If no entries were ever made, simply add it
            if ([list length] < 1) {
                HR_SuiteTimesheetApprovals *item = [[HR_SuiteTimesheetApprovals alloc] init];
                [item setEmployeeID:d.user];
                [item setSignCode:[NSNumber numberWithInt:1]];
                [item setDate:d.selectedDate];
                [item setTimestamp:tsDate.getTimestamp];
                [item create];
                [item submitPending];
                [HR_SuiteHR_SuiteDB synchronize:@"default"];
            }
            
            BOOL matchFound = NO;
            for (HR_SuiteTimesheetApprovals *item in list) {
                // Check for same id and date
                if ([users.employeeID isEqualToString:item.employeeID] && [item.date isEqualToString:d.selectedDate]) {
                    NSLog(@"updating timesheet submission");
                    [item setSignCode:[NSNumber numberWithInt:1]];
                    [item setTimestamp:tsDate.getTimestamp];
                    [item updateSignCode];
                    [item submitPending];
                    [HR_SuiteHR_SuiteDB synchronize:@"default"];
                    
                    matchFound = YES;
                    managerNotesButton.hidden = YES;
                }
            }
            
            if (!matchFound) {
                NSLog(@"entry not found in db. adding...");
                HR_SuiteTimesheetApprovals *item = [[HR_SuiteTimesheetApprovals alloc] init];
                [item setEmployeeID:d.user];
                [item setSignCode:[NSNumber numberWithInt:1]];
                [item setDate:d.selectedDate];
                [item setTimestamp:tsDate.getTimestamp];
                [item create];
                [item submitPending];
                [HR_SuiteHR_SuiteDB synchronize:@"default"];
            }
        } //end for
        
        status.text = @"Waiting for approval";
    } //end sup
    
    /************/
    /*   DEMO   */
    /************/
    else {
        if (buttonIndex == 1) {
            
            entry = [NSDictionary dictionaryWithObjectsAndKeys:
                     d.user, @"employeeID",
                     @"manager", @"manager",
                     @"User", @"employeeName",
                     [tsDate getTimestamp], @"timestamp", 
                     @"1", @"signCode",
                     @"", @"managerNotes",
                     d.selectedDate, @"date",
                     nil];
            [d.hr_approvals addObject:entry];
            
            managerNotesButton.hidden = YES;
            status.text = @"Waiting for approval";
            
            //NSLog(@"submitted timesheet: \n %@", d.hr_approvals);
        }
    }
}



/****************************************************************************************************
 Internal Methods
 ****************************************************************************************************/
- (void)loadCurrentWeek:(NSInteger)month day:(NSInteger)day year:(NSInteger)year
{
    mondaysDate.text = [NSString stringWithFormat:[tsDate getDate:month day:day year:year]];
    tuesdaysDate.text = [NSString stringWithFormat:[tsDate getDate:month day:day+1 year:year]];
    wednesdaysDate.text = [NSString stringWithFormat:[tsDate getDate:month day:day+2 year:year]];
    thursdaysDate.text = [NSString stringWithFormat:[tsDate getDate:month day:day+3 year:year]];
    fridaysDate.text = [NSString stringWithFormat:[tsDate getDate:month day:day+4 year:year]];
    saturdaysDate.text = [NSString stringWithFormat:[tsDate getDate:month day:day+5 year:year]];
    sundaysDate.text = [NSString stringWithFormat:[tsDate getDate:month day:day+6 year:year]];
    
    //Store monday's date of the currently viewed week.
    d.selectedDate = mondaysDate.text; 
    NSLog(@"new selected date = %@", d.selectedDate);
    // If the week is not the current one, set everything viewable and turn off highlights
    if (![d.selectedDate isEqualToString:currentWeek]) {
        [self highlightOFF:mondayButton];
        [self highlightOFF:tuesdayButton];
        [self highlightOFF:wednesdayButton];
        [self highlightOFF:thursdayButton];
        [self highlightOFF:fridayButton];
        [self highlightOFF:saturdayButton];
        [self highlightOFF:sundayButton];
        
        [mondayButton setEnabled:YES];
        [tuesdayButton setEnabled:YES];
        [wednesdayButton setEnabled:YES];
        [thursdayButton setEnabled:YES];
        [fridayButton setEnabled:YES];
        [saturdayButton setEnabled:YES];
        [sundayButton setEnabled:YES];
        
        tuesdaysDate.hidden = NO;
        tuesdayHours.hidden = NO;
        tuesdayProjects.hidden = NO;
        
        wednesdaysDate.hidden = NO;
        wednesdayHours.hidden = NO;
        wednesdayProjects.hidden = NO;
        
        thursdaysDate.hidden = NO;
        thursdayHours.hidden = NO;
        thursdayProjects.hidden = NO;
        
        fridaysDate.hidden = NO;
        fridayHours.hidden = NO;
        fridayProjects.hidden = NO;
        
        saturdaysDate.hidden = NO;
        saturdayHours.hidden = NO;
        saturdayProjects.hidden = NO;
        
        sundaysDate.hidden = NO;
        sundayHours.hidden = NO;
        sundayProjects.hidden = NO;
        
    }
    else {
        [self highlightToday];
    }
    

    
    /**********************/
    /*** SUP Connection ***/
    /**********************/
    if (d.isSUPConnection) {

        NSInteger hm=0, ht=0, hw=0, hth=0, hf=0, hs=0, hsu=0; //total hours per day.
        NSInteger jm=0, jt=0, jw=0, jth=0, jf=0, js=0, jsu=0; //total jobs per day.
        
        //Find the timesheets for a given week, and calculate the hours and tasks per day.
        HR_SuiteTimesheetList *list = [HR_SuiteTimesheet findByEmployeeIDandDate:d.user withDate:d.selectedDate]; //load from SUP.
        if ([list length] > 0) {
            
            for (HR_SuiteTimesheet *item in list) {
                
                if ([item.day isEqualToString:@"Monday"]) {
                    hm += [item.hours intValue]; //Add hours.
                    if([item.job length] > 1) {
                        jm++; //If a job is found, increment job count.
                    }
                }
                else if ([item.day isEqualToString:@"Tuesday"]) {
                    ht += [item.hours intValue];
                    if([item.job length] > 1) {
                        jt++;
                    }               
                }
                else if ([item.day isEqualToString:@"Wednesday"]) {
                    hw += [item.hours intValue];
                    if([item.job length] > 1) {
                        jw++;
                    }               
                }
                else if ([item.day isEqualToString:@"Thursday"]) {
                    hth += [item.hours intValue];
                    if([item.job length] > 1) {
                        jth++;
                    }               
                }
                else if ([item.day isEqualToString:@"Friday"]) {
                    hf += [item.hours intValue];
                    if([item.job length] > 1) {
                        jf++;
                    }               
                }
                else if ([item.day isEqualToString:@"Saturday"]) {
                    hs += [item.hours intValue];
                    if([item.job length] > 1) {
                        js++;
                    }               
                }
                else if ([item.day isEqualToString:@"Sunday"]) {
                    hsu += [item.hours intValue];
                    if([item.job length] > 1) {
                        jsu++;
                    }               
                }
                
                
            } //end for-loop
        }
        
        //Set hours and tasks in view
        [mondayHours setText:[NSString stringWithFormat:@"%i hours", hm]];
        [mondayProjects setText:[NSString stringWithFormat:@"on %i tasks", jm]];
        [tuesdayHours setText:[NSString stringWithFormat:@"%i hours", ht]];
        [tuesdayProjects setText:[NSString stringWithFormat:@"on %i tasks", jt]];
        [wednesdayHours setText:[NSString stringWithFormat:@"%i hours", hw]];
        [wednesdayProjects setText:[NSString stringWithFormat:@"on %i tasks", jw]];
        [thursdayHours setText:[NSString stringWithFormat:@"%i hours", hth]];
        [thursdayProjects setText:[NSString stringWithFormat:@"on %i tasks", jth]];
        [fridayHours setText:[NSString stringWithFormat:@"%i hours", hf]];
        [fridayProjects setText:[NSString stringWithFormat:@"on %i tasks", jf]];
        [saturdayHours setText:[NSString stringWithFormat:@"%i hours", hs]];
        [saturdayProjects setText:[NSString stringWithFormat:@"on %i tasks", js]];
        [sundayHours setText:[NSString stringWithFormat:@"%i hours", hsu]];
        [sundayProjects setText:[NSString stringWithFormat:@"on %i tasks", jsu]];
        
        //Set the sign using TimesheetApprovals
        NSInteger signState = 0;
        HR_SuiteTimesheetApprovalsList *slist = [HR_SuiteTimesheetApprovals findAll];
        for (HR_SuiteTimesheetApprovals *item in slist) {
            if ([item.date isEqualToString:d.selectedDate]) {
                signState = [item.signCode intValue];
            }
        }
        
        // Update the status of the request
        if(signState == 1) {
            status.text = @"Waiting for approval";
            managerNotesButton.hidden = YES;
        }
        else if(signState == 99) {
            status.text = @"Denied";
            managerNotesButton.hidden = NO;
        }
        else if(signState == 100) {
            status.text = @"Approved";
            managerNotesButton.hidden = YES;
        }
        else {
            status.text = @"Waiting for submission";
            managerNotesButton.hidden = YES;
        }
        
        // Change button label/availability depending on the status
        if ([status.text isEqualToString:@"Denied"] || [status.text isEqualToString:@"Waiting for approval"]) {
            [submitButton setTitle:@"Resubmit" forState:UIControlStateNormal];
            submitButton.hidden = NO;
            d.historyState = @"";
        }
        else if ([status.text isEqualToString:@"Approved"]) {
            submitButton.hidden = YES;
            d.historyState = @"Status: Approved";
        }
        else if ([status.text isEqualToString:@"Waiting for submission"]) {
            [submitButton setTitle:@"Submit" forState:UIControlStateNormal];
            submitButton.hidden = NO;
            d.historyState = @"";
        }
        
    } //end sup
      
    
    /************/
    /*   DEMO   */
    /************/
    else {
        NSInteger hm=0, ht=0, hw=0, hth=0, hf=0, hs=0, hsu=0; //total hours per day for each day.
        NSInteger jm=0, jt=0, jw=0, jth=0, jf=0, js=0, jsu=0; //total jobs per day for each day.
        
        for (int i = 0; i < [d.HR_Suite count]; i++) {
            NSDictionary *item = [d.HR_Suite objectAtIndex:i];
            BOOL isUser = [[item objectForKey:@"employeeID"] isEqualToString:d.user];
            BOOL isDate = [[item objectForKey:@"date"] isEqualToString:d.selectedDate];
            
            int i = 0;
            if (isUser && isDate) {
                i++;
            }
            
            if (i > 0) {
                // Set totals hours and total tasks per day for every day of the week
                
                if ([[item objectForKey:@"day"] isEqualToString:@"Monday"]) {
                    hm += [[item objectForKey:@"hours"] intValue]; //Add hours.
                    if([[item objectForKey:@"job"] length] > 1) {
                        jm++; //If a job is found, increment job count.
                    }
                }
                else if ([[item objectForKey:@"day"] isEqualToString:@"Tuesday"]) {
                    ht += [[item objectForKey:@"hours"] intValue];
                    if([[item objectForKey:@"job"] length] > 1) {
                        jt++;
                    }               
                }
                else if ([[item objectForKey:@"day"] isEqualToString:@"Wednesday"]) {
                    hw += [[item objectForKey:@"hours"] intValue];
                    if([[item objectForKey:@"job"] length] > 1) {
                        jw++;
                    }               
                }
                else if ([[item objectForKey:@"day"] isEqualToString:@"Thursday"]) {
                    hth += [[item objectForKey:@"hours"] intValue];
                    if([[item objectForKey:@"job"] length] > 1) {
                        jth++;
                    }               
                }
                else if ([[item objectForKey:@"day"] isEqualToString:@"Friday"]) {
                    hf += [[item objectForKey:@"hours"] intValue];
                    if([[item objectForKey:@"job"] length] > 1) {
                        jf++;
                    }               
                }
                else if ([[item objectForKey:@"day"] isEqualToString:@"Saturday"]) {
                    hs += [[item objectForKey:@"hours"] intValue];
                    if([[item objectForKey:@"job"] length] > 1) {
                        js++;
                    }               
                }
                else if ([[item objectForKey:@"day"] isEqualToString:@"Sunday"]) {
                    hsu += [[item objectForKey:@"hours"] intValue];
                    if([[item objectForKey:@"job"] length] > 1) {
                        jsu++;
                    }               
                }
                
                //Set hours and tasks in view
                [mondayHours setText:[NSString stringWithFormat:@"%i hours", hm]];
                [mondayProjects setText:[NSString stringWithFormat:@"on %i tasks", jm]];
                [tuesdayHours setText:[NSString stringWithFormat:@"%i hours", ht]];
                [tuesdayProjects setText:[NSString stringWithFormat:@"on %i tasks", jt]];
                [wednesdayHours setText:[NSString stringWithFormat:@"%i hours", hw]];
                [wednesdayProjects setText:[NSString stringWithFormat:@"on %i tasks", jw]];
                [thursdayHours setText:[NSString stringWithFormat:@"%i hours", hth]];
                [thursdayProjects setText:[NSString stringWithFormat:@"on %i tasks", jth]];
                [fridayHours setText:[NSString stringWithFormat:@"%i hours", hf]];
                [fridayProjects setText:[NSString stringWithFormat:@"on %i tasks", jf]];
                [saturdayHours setText:[NSString stringWithFormat:@"%i hours", hs]];
                [saturdayProjects setText:[NSString stringWithFormat:@"on %i tasks", js]];
                [sundayHours setText:[NSString stringWithFormat:@"%i hours", hsu]];
                [sundayProjects setText:[NSString stringWithFormat:@"on %i tasks", jsu]];
                
                //Set the sign using TimesheetApprovals
                NSInteger signState = 0;
                //HR_SuiteTimesheetApprovalsList *list = [HR_SuiteTimesheetApprovals findAll];
                for (NSDictionary *item in d.hr_approvals) {
                    if ([[item objectForKey:@"date"] isEqualToString:d.selectedDate] && [[item objectForKey:@"employeeID"] isEqualToString:d.user]) {
                        signState = [[item objectForKey:@"signCode"] intValue];
                    }
                }

                if(signState == 1) {
                    status.text = @"Waiting for approval";
                    managerNotesButton.hidden = YES;
                }
                else if(signState == 99) {
                    status.text = @"Denied";
                    managerNotesButton.hidden = NO;
                    
                }
                else if(signState == 100) {
                    status.text = @"Approved";
                    managerNotesButton.hidden = YES;
                }
                else {
                    status.text = @"Waiting for submission";
                    managerNotesButton.hidden = YES;
                }
                
                // Change button label/availability depending on the status
                if ([status.text isEqualToString:@"Denied"] || [status.text isEqualToString:@"Waiting for approval"]) {
                    [submitButton setTitle:@"Resubmit" forState:UIControlStateNormal];
                    submitButton.hidden = NO;
                    d.historyState = @"";
                }
                else if ([status.text isEqualToString:@"Approved"]) {
                    submitButton.hidden = YES;
                    d.historyState = @"Status: Approved";
                }
                else if ([status.text isEqualToString:@"Waiting for submission"]) {
                    [submitButton setTitle:@"Submit" forState:UIControlStateNormal];
                    submitButton.hidden = NO;
                    d.historyState = @"";
                }
                
            } //if
            
            else {
                //Set hours and tasks in view
                [mondayHours setText:[NSString stringWithFormat:@"%i hours", hm]];
                [mondayProjects setText:[NSString stringWithFormat:@"on %i tasks", jm]];
                [tuesdayHours setText:[NSString stringWithFormat:@"%i hours", ht]];
                [tuesdayProjects setText:[NSString stringWithFormat:@"on %i tasks", jt]];
                [wednesdayHours setText:[NSString stringWithFormat:@"%i hours", hw]];
                [wednesdayProjects setText:[NSString stringWithFormat:@"on %i tasks", jw]];
                [thursdayHours setText:[NSString stringWithFormat:@"%i hours", hth]];
                [thursdayProjects setText:[NSString stringWithFormat:@"on %i tasks", jth]];
                [fridayHours setText:[NSString stringWithFormat:@"%i hours", hf]];
                [fridayProjects setText:[NSString stringWithFormat:@"on %i tasks", jf]];
                [saturdayHours setText:[NSString stringWithFormat:@"%i hours", hs]];
                [saturdayProjects setText:[NSString stringWithFormat:@"on %i tasks", js]];
                [sundayHours setText:[NSString stringWithFormat:@"%i hours", hsu]];
                [sundayProjects setText:[NSString stringWithFormat:@"on %i tasks", jsu]];

                
                //Set the sign using TimesheetApprovals
                NSInteger signState = 0;
                //HR_SuiteTimesheetApprovalsList *list = [HR_SuiteTimesheetApprovals findAll];
                for (NSDictionary *item in d.hr_approvals) {
                    if ([[item objectForKey:@"date"] isEqualToString:d.selectedDate] && [[item objectForKey:@"employeeID"] isEqualToString:d.user]) {
                        signState = [[item objectForKey:@"signCode"] intValue];
                    }
                }
                
                if(signState == 1) {
                    status.text = @"Waiting for approval";
                    managerNotesButton.hidden = YES;
                }
                else if(signState == 99) {
                    status.text = @"Denied";
                    managerNotesButton.hidden = NO;
                    
                }
                else if(signState == 100) {
                    status.text = @"Approved";
                    managerNotesButton.hidden = YES;
                }
                else {
                    status.text = @"Waiting for submission";
                    managerNotesButton.hidden = YES;
                }
                
                // Change button label/availability depending on the status
                if ([status.text isEqualToString:@"Denied"] || [status.text isEqualToString:@"Waiting for approval"]) {
                    [submitButton setTitle:@"Resubmit" forState:UIControlStateNormal];
                    submitButton.hidden = NO;
                    d.historyState = @"";
                }
                else if ([status.text isEqualToString:@"Approved"]) {
                    submitButton.hidden = YES;
                    d.historyState = @"Status: Approved";
                }
                else if ([status.text isEqualToString:@"Waiting for submission"]) {
                    [submitButton setTitle:@"Submit" forState:UIControlStateNormal];
                    submitButton.hidden = NO;
                    d.historyState = @"";
                }
                
            }
            
            
        } //for
        
    } //end demo
    
    
    
    // Using the text fields, calculate the total number of hours worked for the current week and update the label.
    NSInteger total = [mondayHours.text integerValue] + [tuesdayHours.text integerValue] + [wednesdayHours.text integerValue] + [thursdayHours.text integerValue] + [fridayHours.text integerValue] + [saturdayHours.text integerValue] + [sundayHours.text integerValue];
    totalHours.text = [NSString stringWithFormat:@"%i hours", total];    
}



/****************************************************************************************************
 Show Manager's Note
 ****************************************************************************************************/
- (IBAction)showManagerNotes:(id)sender 
{

    /**********************/
    /*** SUP Connection ***/
    /**********************/
    if(d.isSUPConnection) {
        NSString *managerNotes;
        HR_SuiteTimesheetList *list = [HR_SuiteTimesheet findByEmployeeIDandDate:d.user withDate:d.selectedDate];
        for (HR_SuiteTimesheet *item in list) {
            managerNotes = item.managerNotes;
        }
        
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Manager's Note:" message:managerNotes delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [message setAlertViewStyle:UIAlertViewStyleDefault];
        [message show];
    }
    
    /************/
    /*   DEMO   */
    /************/
    else {
        NSString *managerNotes;
        for (NSDictionary *item in d.hr_approvals) {
            if ([[item objectForKey:@"date"] isEqualToString:d.selectedDate] && [[item objectForKey:@"employeeID"] isEqualToString:d.user]) {
                managerNotes = [item objectForKey:@"managerNotes"];
            }
        }
        
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Manager's Note:" message:managerNotes delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [message setAlertViewStyle:UIAlertViewStyleDefault];
        [message show];
    }
}



/****************************************************************************************************
 Go to previous week
 ****************************************************************************************************/
- (IBAction)previousWeek:(id)sender 
{
    
    // Set the week offset back by one
    weekPositionOffset--;
    if (weekPositionOffset == 0)
        nextWeekButton.hidden = YES;
    else
        nextWeekButton.hidden = NO;
    
    // Load data for the previous week and display it
    NSArray *temp = [d.selectedDate componentsSeparatedByString:@"/"];
    NSInteger day = [[temp objectAtIndex:1] intValue];
    NSInteger month = [[temp objectAtIndex:0] intValue];
    NSInteger year = [[temp objectAtIndex:2] intValue];
    [self loadCurrentWeek:month day:day-7 year:year];
}



/****************************************************************************************************
 Go to next week
 ****************************************************************************************************/
- (IBAction)nextWeek:(id)sender 
{
    
    weekPositionOffset++;
    if (weekPositionOffset == 0) {
        nextWeekButton.hidden = YES;
    }
    else {
        nextWeekButton.hidden = NO;
    }
    
    NSArray *temp = [d.selectedDate componentsSeparatedByString:@"/"];
    NSInteger day = [[temp objectAtIndex:1] intValue];
    NSInteger month = [[temp objectAtIndex:0] intValue];
    NSInteger year = [[temp objectAtIndex:2] intValue];
    [self loadCurrentWeek:month day:day+7 year:year];
}



/****************************************************************************************************
 Highlight Today
 ****************************************************************************************************/
- (void)highlightToday
{
    TimesheetDate *ts = [[TimesheetDate alloc] init];
    NSString *today = [ts getTodaysDay];

    //Monday
    if ([today isEqualToString:@"Monday"]) {
        [self highlightON:mondayButton];
        [tuesdayButton setEnabled:NO];
        [wednesdayButton setEnabled:NO];
        [thursdayButton setEnabled:NO];
        [fridayButton setEnabled:NO];
        [saturdayButton setEnabled:NO];
        [sundayButton setEnabled:NO];
        
        tuesdaysDate.hidden = YES;
        tuesdayHours.hidden = YES;
        tuesdayProjects.hidden = YES;
        
        wednesdaysDate.hidden = YES;
        wednesdayHours.hidden = YES;
        wednesdayProjects.hidden = YES;
        
        thursdaysDate.hidden = YES;
        thursdayHours.hidden = YES;
        thursdayProjects.hidden = YES;
        
        fridaysDate.hidden = YES;
        fridayHours.hidden = YES;
        fridayProjects.hidden = YES;
        
        saturdaysDate.hidden = YES;
        saturdayHours.hidden = YES;
        saturdayProjects.hidden = YES;
        
        sundaysDate.hidden = YES;
        sundayHours.hidden = YES;
        sundayProjects.hidden = YES;
    }
    else {
        [self highlightOFF:mondayButton];
    }
    
    //Tuesday
    if ([today isEqualToString:@"Tuesday"]) {
        [self highlightON:tuesdayButton];
        [wednesdayButton setEnabled:NO];
        [thursdayButton setEnabled:NO];
        [fridayButton setEnabled:NO];
        [saturdayButton setEnabled:NO];
        [sundayButton setEnabled:NO];
        
        wednesdaysDate.hidden = YES;
        wednesdayHours.hidden = YES;
        wednesdayProjects.hidden = YES;
        
        thursdaysDate.hidden = YES;
        thursdayHours.hidden = YES;
        thursdayProjects.hidden = YES;
        
        fridaysDate.hidden = YES;
        fridayHours.hidden = YES;
        fridayProjects.hidden = YES;
        
        saturdaysDate.hidden = YES;
        saturdayHours.hidden = YES;
        saturdayProjects.hidden = YES;
        
        sundaysDate.hidden = YES;
        sundayHours.hidden = YES;
        sundayProjects.hidden = YES;
    }
    else {
        [self highlightOFF:tuesdayButton];
    }
    
    //Wednesday
    if ([today isEqualToString:@"Wednesday"]) {
        [self highlightON:wednesdayButton];
        [thursdayButton setEnabled:NO];
        [fridayButton setEnabled:NO];
        [saturdayButton setEnabled:NO];
        [sundayButton setEnabled:NO];
        
        thursdaysDate.hidden = YES;
        thursdayHours.hidden = YES;
        thursdayProjects.hidden = YES;
        
        fridaysDate.hidden = YES;
        fridayHours.hidden = YES;
        fridayProjects.hidden = YES;
        
        saturdaysDate.hidden = YES;
        saturdayHours.hidden = YES;
        saturdayProjects.hidden = YES;
        
        sundaysDate.hidden = YES;
        sundayHours.hidden = YES;
        sundayProjects.hidden = YES;
    }
    else {
        [self highlightOFF:wednesdayButton];
    }
    
    //Thursday
    if ([today isEqualToString:@"Thursday"]) {
        [self highlightON:thursdayButton];
        [fridayButton setEnabled:NO];
        [saturdayButton setEnabled:NO];
        [sundayButton setEnabled:NO];
        
        fridaysDate.hidden = YES;
        fridayHours.hidden = YES;
        fridayProjects.hidden = YES;
        
        saturdaysDate.hidden = YES;
        saturdayHours.hidden = YES;
        saturdayProjects.hidden = YES;
        
        sundaysDate.hidden = YES;
        sundayHours.hidden = YES;
        sundayProjects.hidden = YES;
    }
    else {
        [self highlightOFF:thursdayButton];
    }
    
    //Friday
    if ([today isEqualToString:@"Friday"]) {
        [self highlightON:fridayButton];
        [saturdayButton setEnabled:NO];
        [sundayButton setEnabled:NO];
        
        saturdaysDate.hidden = YES;
        saturdayHours.hidden = YES;
        saturdayProjects.hidden = YES;
        
        sundaysDate.hidden = YES;
        sundayHours.hidden = YES;
        sundayProjects.hidden = YES;
    }
    else {
        [self highlightOFF:fridayButton];
    }
    
    //Saturday
    if ([today isEqualToString:@"Saturday"]) {
        [self highlightON:saturdayButton];
        [sundayButton setEnabled:NO];
        
        sundaysDate.hidden = YES;
        sundayHours.hidden = YES;
        sundayProjects.hidden = YES;
    }
    else {
        [self highlightOFF:saturdayButton];
    }
    
    //Sunday
    if ([today isEqualToString:@"Sunday"]) {
        [self highlightON:sundayButton];
    }
    else {
        [self highlightOFF:sundayButton];
    }
}


/****************************************************************************************************
 Turn Highlight ON
 ****************************************************************************************************/
-(void)highlightON:(UIButton *)button
{
    [[button layer] setCornerRadius:12.0f];
    [[button layer] setMasksToBounds:YES];
    [[button layer] setBorderWidth:3.0f];
    [[button layer] setBorderColor:[[UIColor blueColor] CGColor]];
}



/****************************************************************************************************
 Turn Highlight OFF
 ****************************************************************************************************/
-(void)highlightOFF:(UIButton *)button
{
    [[button layer] setCornerRadius:12.0f];
    [[button layer] setMasksToBounds:YES];
    [[button layer] setBorderWidth:1.0f];
    [[button layer] setBorderColor:[[UIColor grayColor] CGColor]];
}



/****************************************************************************************************
 Set the date for each day of the week given the name of day, month, day, and year value
 ****************************************************************************************************/
- (void)setDates:(NSString *)today month:(NSInteger)month day:(NSInteger)day year:(NSInteger)year
{
    
    if ([today isEqualToString:@"Monday"])
    {
        mondaysDate.text = [NSString stringWithFormat:[tsDate getDate:month day:day year:year]];
        day++;
        tuesdaysDate.text = [NSString stringWithFormat:[tsDate getDate:month day:day year:year]];
        day++;
        wednesdaysDate.text = [NSString stringWithFormat:[tsDate getDate:month day:day year:year]];
        day++;
        thursdaysDate.text = [NSString stringWithFormat:[tsDate getDate:month day:day year:year]];
        day++;
        fridaysDate.text = [NSString stringWithFormat:[tsDate getDate:month day:day year:year]];
        day++;
        saturdaysDate.text = [NSString stringWithFormat:[tsDate getDate:month day:day year:year]];
        day++;
        sundaysDate.text = [NSString stringWithFormat:[tsDate getDate:month day:day year:year]];
    }
    else if ([today isEqualToString:@"Tuesday"])
    {
        day--;
        mondaysDate.text = [NSString stringWithFormat:[tsDate getDate:month day:day year:year]];
        day++;
        tuesdaysDate.text = [NSString stringWithFormat:[tsDate getDate:month day:day year:year]];
        day++;
        wednesdaysDate.text = [NSString stringWithFormat:[tsDate getDate:month day:day year:year]];
        day++;
        thursdaysDate.text = [NSString stringWithFormat:[tsDate getDate:month day:day year:year]];
        day++;
        fridaysDate.text = [NSString stringWithFormat:[tsDate getDate:month day:day year:year]];
        day++;
        saturdaysDate.text = [NSString stringWithFormat:[tsDate getDate:month day:day year:year]];
        day++;
        sundaysDate.text = [NSString stringWithFormat:[tsDate getDate:month day:day year:year]];
    }
    else if ([today isEqualToString:@"Wednesday"])
    {        
        day = day-2;
        mondaysDate.text = [NSString stringWithFormat:[tsDate getDate:month day:day year:year]];
        day++;
        tuesdaysDate.text = [NSString stringWithFormat:[tsDate getDate:month day:day year:year]];
        day++;
        wednesdaysDate.text = [NSString stringWithFormat:[tsDate getDate:month day:day year:year]];
        day++;
        thursdaysDate.text = [NSString stringWithFormat:[tsDate getDate:month day:day year:year]];
        day++;
        fridaysDate.text = [NSString stringWithFormat:[tsDate getDate:month day:day year:year]];
        day++;
        saturdaysDate.text = [NSString stringWithFormat:[tsDate getDate:month day:day year:year]];
        day++;
        sundaysDate.text = [NSString stringWithFormat:[tsDate getDate:month day:day year:year]];
    }
    else if ([today isEqualToString:@"Thursday"])
    {
        day = day-3;
        mondaysDate.text = [NSString stringWithFormat:[tsDate getDate:month day:day year:year]];
        day++;
        tuesdaysDate.text = [NSString stringWithFormat:[tsDate getDate:month day:day year:year]];
        day++;
        wednesdaysDate.text = [NSString stringWithFormat:[tsDate getDate:month day:day year:year]];
        day++;
        thursdaysDate.text = [NSString stringWithFormat:[tsDate getDate:month day:day year:year]];
        day++;
        fridaysDate.text = [NSString stringWithFormat:[tsDate getDate:month day:day year:year]];
        day++;
        saturdaysDate.text = [NSString stringWithFormat:[tsDate getDate:month day:day year:year]];
        day++;
        sundaysDate.text = [NSString stringWithFormat:[tsDate getDate:month day:day year:year]];
    }
    else if ([today isEqualToString:@"Friday"])
    {
        day = day-4;
        mondaysDate.text = [NSString stringWithFormat:[tsDate getDate:month day:day year:year]];
        day++;
        tuesdaysDate.text = [NSString stringWithFormat:[tsDate getDate:month day:day year:year]];
        day++;
        wednesdaysDate.text = [NSString stringWithFormat:[tsDate getDate:month day:day year:year]];
        day++;
        thursdaysDate.text = [NSString stringWithFormat:[tsDate getDate:month day:day year:year]];
        day++;
        fridaysDate.text = [NSString stringWithFormat:[tsDate getDate:month day:day year:year]];
        day++;
        saturdaysDate.text = [NSString stringWithFormat:[tsDate getDate:month day:day year:year]];
        day++;
        sundaysDate.text = [NSString stringWithFormat:[tsDate getDate:month day:day year:year]];
    }
    else if ([today isEqualToString:@"Saturday"])
    {
        day = day-5;
        mondaysDate.text = [NSString stringWithFormat:[tsDate getDate:month day:day year:year]];
        day++;
        tuesdaysDate.text = [NSString stringWithFormat:[tsDate getDate:month day:day year:year]];
        day++;
        wednesdaysDate.text = [NSString stringWithFormat:[tsDate getDate:month day:day year:year]];
        day++;
        thursdaysDate.text = [NSString stringWithFormat:[tsDate getDate:month day:day year:year]];
        day++;
        fridaysDate.text = [NSString stringWithFormat:[tsDate getDate:month day:day year:year]];
        day++;
        saturdaysDate.text = [NSString stringWithFormat:[tsDate getDate:month day:day year:year]];
        day++;
        sundaysDate.text = [NSString stringWithFormat:[tsDate getDate:month day:day year:year]];
    }
    else if ([today isEqualToString:@"Sunday"])
    {
        day = day-6;
        mondaysDate.text = [NSString stringWithFormat:[tsDate getDate:month day:day year:year]];
        day++;
        tuesdaysDate.text = [NSString stringWithFormat:[tsDate getDate:month day:day year:year]];
        day++;
        wednesdaysDate.text = [NSString stringWithFormat:[tsDate getDate:month day:day year:year]];
        day++;
        thursdaysDate.text = [NSString stringWithFormat:[tsDate getDate:month day:day year:year]];
        day++;
        fridaysDate.text = [NSString stringWithFormat:[tsDate getDate:month day:day year:year]];
        day++;
        saturdaysDate.text = [NSString stringWithFormat:[tsDate getDate:month day:day year:year]];
        day++;
        sundaysDate.text = [NSString stringWithFormat:[tsDate getDate:month day:day year:year]];
    }
    else
    {
        NSLog(@"ALL DATES ARE WRONG");
    }
}



@end
