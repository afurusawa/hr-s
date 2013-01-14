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

@synthesize nextWeekButton, previousWeekButton, status, managerNotesButton, navbar, delegate, mainView;
@synthesize mondayButton, tuesdayButton, wednesdayButton, thursdayButton, fridayButton, saturdayButton, sundayButton;
@synthesize submitButton, submitLabel, totalHoursLabel;

@synthesize mondayLabel, tuesdayLabel, wednesdayLabel, thursdayLabel, fridayLabel, saturdayLabel, sundayLabel;
@synthesize mondayTasks, tuesdayTasks, wednesdayTasks, thursdayTasks, fridayTasks, saturdayTasks, sundayTasks;
@synthesize mondayHours, tuesdayHours, wednesdayHours, thursdayHours, fridayHours, saturdayHours, sundayHours, totalHours;
@synthesize mondaysDate, tuesdaysDate, wednesdaysDate, thursdaysDate, fridaysDate, saturdaysDate, sundaysDate;
@synthesize selectedDay;
@synthesize selectedDate;



/****************************************************************************************************
 Protocol Methods
 ****************************************************************************************************/
- (void)reloadView
{    
    [self configureLabels];
    weekPositionOffset = 0;
    currentWeek = d.selectedDate;
    tsDate = [[TimesheetDate alloc] init];
    
    //bg
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"ts-bg-bg.png"]]];
    
    //navbar title bg
    [navbar setBackgroundImage:[UIImage imageNamed:@"ts.topappbar-bg.png"] forBarMetrics:UIBarMetricsDefault];
    
    [self configureStateForWeek:d.selectedDate];
}


/****************************************************************************************************
 View Did Load
 ****************************************************************************************************/
- (void)viewDidLoad {  
    
    // Initializations
    d = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [self configureLabels];
    weekPositionOffset = 0;
    currentWeek = d.selectedDate;

    //bg
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"ts-bg-bg.png"]]];
    
    //navbar title bg
    [navbar setBackgroundImage:[UIImage imageNamed:@"ts.topappbar-bg.png"] forBarMetrics:UIBarMetricsDefault];
    
    [self configureStateForWeek:d.selectedDate];
    
    //set view for iphone 4 or 5
    NSLog(@"size = %f", self.view.frame.size.height);
    if (self.view.frame.size.height > 460) { //iphone5
        [mainView setCenter:CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2)];
    }
    [mainView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"ts-bg-bg.png"]]];
    
}

// 1. Sets which button is current day, and configures rest of the buttons accordingly.
// ---- Set font colors accordingly.
// ---- Set enabled/disabled accordingly.
// 2. Set date
// 3. Set hours and tasks for each day.
- (void)configureStateForWeek:(NSString *)date
{
    // Initial constants
    UIColor *gray = [UIColor colorWithRed:182.0/255.0 green:189.0/255.0 blue:195.0/255.0 alpha:1];
    UIColor *white = [UIColor whiteColor];
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    
    // Set Dates
    [format setDateFormat:@"MM/dd/yyyy"];
    NSDate *pivot = [format dateFromString:date];
    
    [format setDateFormat:@"MM/dd"];
    mondaysDate.text = [format stringFromDate:pivot];
    pivot = [pivot dateByAddingTimeInterval:60*60*24*1];
    tuesdaysDate.text = [format stringFromDate:pivot];
    pivot = [pivot dateByAddingTimeInterval:60*60*24*1];
    wednesdaysDate.text = [format stringFromDate:pivot];
    pivot = [pivot dateByAddingTimeInterval:60*60*24*1];
    thursdaysDate.text = [format stringFromDate:pivot];
    pivot = [pivot dateByAddingTimeInterval:60*60*24*1];
    fridaysDate.text = [format stringFromDate:pivot];
    pivot = [pivot dateByAddingTimeInterval:60*60*24*1];
    saturdaysDate.text = [format stringFromDate:pivot];
    pivot = [pivot dateByAddingTimeInterval:60*60*24*1];
    sundaysDate.text = [format stringFromDate:pivot];
    
    // Check if week is current week and adjust accordingly
    //NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"MM/dd/yyyy"];
    NSDate *currentDate = [format dateFromString:date];
    NSDate *todaysDate = [NSDate date];
    NSTimeInterval difference = [todaysDate timeIntervalSinceDate:currentDate];
    NSInteger diff = difference;
    //NSLog(@"difference: %i", diff);
    
    diff = diff/(60*60*24*7); //diff=week difference
    
    NSLog(@"difference in days: %i", diff);
    weekPositionOffset=diff;
    
    
    if(weekPositionOffset==0) {
        nextWeekButton.hidden = YES;
        [format setDateFormat:@"EEEE"];
        NSString *today = [format stringFromDate:[NSDate date]];
        if ([today isEqualToString:@"Monday"]) {
            [mondayButton setImage:[UIImage imageNamed:@"ts-timeentry-day-bg-current"] forState:UIControlStateNormal];
            [mondayButton setEnabled:YES];
            [self setColorsForMonday:white andTuesday:gray andWednesday:gray andThursday:gray andFriday:gray andSaturday:gray andSunday:gray];
            
            [tuesdayButton setImage:[UIImage imageNamed:@"ts-timeentry-day-bg-dsbl"] forState:UIControlStateNormal];
            [wednesdayButton setImage:[UIImage imageNamed:@"ts-timeentry-day-bg-dsbl"] forState:UIControlStateNormal];
            [thursdayButton setImage:[UIImage imageNamed:@"ts-timeentry-day-bg-dsbl"] forState:UIControlStateNormal];
            [fridayButton setImage:[UIImage imageNamed:@"ts-timeentry-day-bg-dsbl"] forState:UIControlStateNormal];
            [saturdayButton setImage:[UIImage imageNamed:@"ts-timeentry-day-bg-dsbl"] forState:UIControlStateNormal];
            [sundayButton setImage:[UIImage imageNamed:@"ts-timeentry-day-bg-dsbl"] forState:UIControlStateNormal];
            [tuesdayButton setEnabled:NO];
            [wednesdayButton setEnabled:NO];
            [thursdayButton setEnabled:NO];
            [fridayButton setEnabled:NO];
            [saturdayButton setEnabled:NO];
            [sundayButton setEnabled:NO];
            
        }
        else if([today isEqualToString:@"Tuesday"]) {
            [mondayButton setImage:[UIImage imageNamed:@"ts-timeentry-day-bg-past"] forState:UIControlStateNormal];
            [tuesdayButton setImage:[UIImage imageNamed:@"ts-timeentry-day-bg-current"] forState:UIControlStateNormal];
            [mondayButton setEnabled:YES];
            [tuesdayButton setEnabled:YES];
            [self setColorsForMonday:white andTuesday:white andWednesday:gray andThursday:gray andFriday:gray andSaturday:gray andSunday:gray];
            
            [wednesdayButton setImage:[UIImage imageNamed:@"ts-timeentry-day-bg-dsbl"] forState:UIControlStateNormal];
            [thursdayButton setImage:[UIImage imageNamed:@"ts-timeentry-day-bg-dsbl"] forState:UIControlStateNormal];
            [fridayButton setImage:[UIImage imageNamed:@"ts-timeentry-day-bg-dsbl"] forState:UIControlStateNormal];
            [saturdayButton setImage:[UIImage imageNamed:@"ts-timeentry-day-bg-dsbl"] forState:UIControlStateNormal];
            [sundayButton setImage:[UIImage imageNamed:@"ts-timeentry-day-bg-dsbl"] forState:UIControlStateNormal];
            [wednesdayButton setEnabled:NO];
            [thursdayButton setEnabled:NO];
            [fridayButton setEnabled:NO];
            [saturdayButton setEnabled:NO];
            [sundayButton setEnabled:NO];
        }
        else if([today isEqualToString:@"Wednesday"]) {
            [mondayButton setImage:[UIImage imageNamed:@"ts-timeentry-day-bg-past"] forState:UIControlStateNormal];
            [tuesdayButton setImage:[UIImage imageNamed:@"ts-timeentry-day-bg-past"] forState:UIControlStateNormal];
            [wednesdayButton setImage:[UIImage imageNamed:@"ts-timeentry-day-bg-current"] forState:UIControlStateNormal];
            [mondayButton setEnabled:YES];
            [tuesdayButton setEnabled:YES];
            [wednesdayButton setEnabled:YES];
            [self setColorsForMonday:white andTuesday:white andWednesday:white andThursday:gray andFriday:gray andSaturday:gray andSunday:gray];
            
            [thursdayButton setImage:[UIImage imageNamed:@"ts-timeentry-day-bg-dsbl"] forState:UIControlStateNormal];
            [fridayButton setImage:[UIImage imageNamed:@"ts-timeentry-day-bg-dsbl"] forState:UIControlStateNormal];
            [saturdayButton setImage:[UIImage imageNamed:@"ts-timeentry-day-bg-dsbl"] forState:UIControlStateNormal];
            [sundayButton setImage:[UIImage imageNamed:@"ts-timeentry-day-bg-dsbl"] forState:UIControlStateNormal];
            [thursdayButton setEnabled:NO];
            [fridayButton setEnabled:NO];
            [saturdayButton setEnabled:NO];
            [sundayButton setEnabled:NO];
        }
        else if([today isEqualToString:@"Thursday"]) {
            [mondayButton setImage:[UIImage imageNamed:@"ts-timeentry-day-bg-past"] forState:UIControlStateNormal];
            [tuesdayButton setImage:[UIImage imageNamed:@"ts-timeentry-day-bg-past"] forState:UIControlStateNormal];
            [wednesdayButton setImage:[UIImage imageNamed:@"ts-timeentry-day-bg-past"] forState:UIControlStateNormal];
            [thursdayButton setImage:[UIImage imageNamed:@"ts-timeentry-day-bg-current"] forState:UIControlStateNormal];
            [mondayButton setEnabled:YES];
            [tuesdayButton setEnabled:YES];
            [wednesdayButton setEnabled:YES];
            [thursdayButton setEnabled:YES];
            [self setColorsForMonday:white andTuesday:white andWednesday:white andThursday:white andFriday:gray andSaturday:gray andSunday:gray];
            
            [fridayButton setImage:[UIImage imageNamed:@"ts-timeentry-day-bg-dsbl"] forState:UIControlStateNormal];
            [saturdayButton setImage:[UIImage imageNamed:@"ts-timeentry-day-bg-dsbl"] forState:UIControlStateNormal];
            [sundayButton setImage:[UIImage imageNamed:@"ts-timeentry-day-bg-dsbl"] forState:UIControlStateNormal];
            [fridayButton setEnabled:NO];
            [saturdayButton setEnabled:NO];
            [sundayButton setEnabled:NO];
        }
        else if([today isEqualToString:@"Friday"]) {
            [mondayButton setImage:[UIImage imageNamed:@"ts-timeentry-day-bg-past"] forState:UIControlStateNormal];
            [tuesdayButton setImage:[UIImage imageNamed:@"ts-timeentry-day-bg-past"] forState:UIControlStateNormal];
            [wednesdayButton setImage:[UIImage imageNamed:@"ts-timeentry-day-bg-past"] forState:UIControlStateNormal];
            [thursdayButton setImage:[UIImage imageNamed:@"ts-timeentry-day-bg-past"] forState:UIControlStateNormal];
            [fridayButton setImage:[UIImage imageNamed:@"ts-timeentry-day-bg-current"] forState:UIControlStateNormal];
            [mondayButton setEnabled:YES];
            [tuesdayButton setEnabled:YES];
            [wednesdayButton setEnabled:YES];
            [thursdayButton setEnabled:YES];
            [fridayButton setEnabled:YES];
            [self setColorsForMonday:white andTuesday:white andWednesday:white andThursday:white andFriday:white andSaturday:gray andSunday:gray];
            
            [saturdayButton setImage:[UIImage imageNamed:@"ts-timeentry-day-bg-dsbl"] forState:UIControlStateNormal];
            [sundayButton setImage:[UIImage imageNamed:@"ts-timeentry-day-bg-dsbl"] forState:UIControlStateNormal];
            [saturdayButton setEnabled:NO];
            [sundayButton setEnabled:NO];
        }
        else if([today isEqualToString:@"Saturday"]) {
            [mondayButton setImage:[UIImage imageNamed:@"ts-timeentry-day-bg-past"] forState:UIControlStateNormal];
            [tuesdayButton setImage:[UIImage imageNamed:@"ts-timeentry-day-bg-past"] forState:UIControlStateNormal];
            [wednesdayButton setImage:[UIImage imageNamed:@"ts-timeentry-day-bg-past"] forState:UIControlStateNormal];
            [thursdayButton setImage:[UIImage imageNamed:@"ts-timeentry-day-bg-past"] forState:UIControlStateNormal];
            [fridayButton setImage:[UIImage imageNamed:@"ts-timeentry-day-bg-past"] forState:UIControlStateNormal];
            [saturdayButton setImage:[UIImage imageNamed:@"ts-timeentry-day-bg-current"] forState:UIControlStateNormal];
            [mondayButton setEnabled:YES];
            [tuesdayButton setEnabled:YES];
            [wednesdayButton setEnabled:YES];
            [thursdayButton setEnabled:YES];
            [fridayButton setEnabled:YES];
            [saturdayButton setEnabled:YES];
            [self setColorsForMonday:white andTuesday:white andWednesday:white andThursday:white andFriday:white andSaturday:white andSunday:gray];
            
            [sundayButton setImage:[UIImage imageNamed:@"ts-timeentry-day-bg-dsbl"] forState:UIControlStateNormal];
            [sundayButton setEnabled:NO];
        }
        else if([today isEqualToString:@"Sunday"]) {
            [mondayButton setImage:[UIImage imageNamed:@"ts-timeentry-day-bg-past"] forState:UIControlStateNormal];
            [tuesdayButton setImage:[UIImage imageNamed:@"ts-timeentry-day-bg-past"] forState:UIControlStateNormal];
            [wednesdayButton setImage:[UIImage imageNamed:@"ts-timeentry-day-bg-past"] forState:UIControlStateNormal];
            [thursdayButton setImage:[UIImage imageNamed:@"ts-timeentry-day-bg-past"] forState:UIControlStateNormal];
            [fridayButton setImage:[UIImage imageNamed:@"ts-timeentry-day-bg-past"] forState:UIControlStateNormal];
            [saturdayButton setImage:[UIImage imageNamed:@"ts-timeentry-day-bg-past"] forState:UIControlStateNormal];
            [sundayButton setImage:[UIImage imageNamed:@"ts-timeentry-day-bg-current"] forState:UIControlStateNormal];
            [mondayButton setEnabled:YES];
            [tuesdayButton setEnabled:YES];
            [wednesdayButton setEnabled:YES];
            [thursdayButton setEnabled:YES];
            [fridayButton setEnabled:YES];
            [saturdayButton setEnabled:YES];
            [sundayButton setEnabled:YES];
            [self setColorsForMonday:white andTuesday:white andWednesday:white andThursday:white andFriday:white andSaturday:white andSunday:white];
        }
    }
    else {
        nextWeekButton.hidden = NO;
        [mondayButton setImage:[UIImage imageNamed:@"ts-timeentry-day-bg-past"] forState:UIControlStateNormal];
        [tuesdayButton setImage:[UIImage imageNamed:@"ts-timeentry-day-bg-past"] forState:UIControlStateNormal];
        [wednesdayButton setImage:[UIImage imageNamed:@"ts-timeentry-day-bg-past"] forState:UIControlStateNormal];
        [thursdayButton setImage:[UIImage imageNamed:@"ts-timeentry-day-bg-past"] forState:UIControlStateNormal];
        [fridayButton setImage:[UIImage imageNamed:@"ts-timeentry-day-bg-past"] forState:UIControlStateNormal];
        [saturdayButton setImage:[UIImage imageNamed:@"ts-timeentry-day-bg-past"] forState:UIControlStateNormal];
        [sundayButton setImage:[UIImage imageNamed:@"ts-timeentry-day-bg-past"] forState:UIControlStateNormal];
        [mondayButton setEnabled:YES];
        [tuesdayButton setEnabled:YES];
        [wednesdayButton setEnabled:YES];
        [thursdayButton setEnabled:YES];
        [fridayButton setEnabled:YES];
        [saturdayButton setEnabled:YES];
        [sundayButton setEnabled:YES];
        [self setColorsForMonday:white andTuesday:white andWednesday:white andThursday:white andFriday:white andSaturday:white andSunday:white];
    }
    
    // 07/08/2012 -convert-> 07/8/2012
    NSArray *a = [date componentsSeparatedByString:@"/"];
    NSString *first = [a objectAtIndex:0];
    NSString *second = [a objectAtIndex:1];
    if ([[a objectAtIndex:1] intValue] < 10) {
        first = [[a objectAtIndex:0] stringByReplacingOccurrencesOfString:@"0" withString:@""];
    }
    if ([[a objectAtIndex:1] intValue] < 10) {
        second = [[a objectAtIndex:1] stringByReplacingOccurrencesOfString:@"0" withString:@""];
    }
    NSString *ndate = [NSString stringWithFormat:@"%@/%@/%@", first, second, [a objectAtIndex:2]];
    
    //If SUP Connection    
    if (d.isSUPConnection) {
        // Set Hours and Tasks
        HR_SuiteTimesheetList *list = [HR_SuiteTimesheet findByEmployeeIDandDate:d.user withDate:ndate];
        if ([list length] > 0) {
            NSLog(@"calculating stats...");
            NSInteger hm=0, ht=0, hw=0, hth=0, hf=0, hs=0, hsu=0; //total hours per day for each day.
            NSInteger tm=0, tt=0, tw=0, tth=0, tf=0, ts=0, tsu=0; //total tasks per day for each day.

            for (HR_SuiteTimesheet *supItem in list)
            {
                if ([supItem.day isEqualToString:@"Monday"]) {
                    hm += [supItem.hours intValue]; //Add hours.
                    if([supItem.job length] > 1) {
                        tm++; //If a job is found, increment job count.
                    }
                }
                else if ([supItem.day isEqualToString:@"Tuesday"]) {
                    ht += [supItem.hours intValue];
                    if([supItem.job length] > 1) {
                        tt++;
                    }
                }
                else if ([supItem.day isEqualToString:@"Wednesday"]) {
                    hw += [supItem.hours intValue];
                    if([supItem.job length] > 1) {
                        tw++;
                    }
                }
                else if ([supItem.day isEqualToString:@"Thursday"]) {
                    hth += [supItem.hours intValue];
                    if([supItem.job length] > 1) {
                        tth++;
                    }
                }
                else if ([supItem.day isEqualToString:@"Friday"]) {
                    hf += [supItem.hours intValue];
                    if([supItem.job length] > 1) {
                        tf++;
                    }
                }
                else if ([supItem.day isEqualToString:@"Saturday"]) {
                    hs += [supItem.hours intValue];
                    if([supItem.job length] > 1) {
                        ts++;
                    }
                }
                else if ([supItem.day isEqualToString:@"Sunday"]) {
                    hsu += [supItem.hours intValue];
                    if([supItem.job length] > 1) {
                        tsu++;
                    }
                }
                
            } //end for
            
            [mondayHours setText:[NSString stringWithFormat:@"H: %i", hm]];
            [mondayTasks setText:[NSString stringWithFormat:@"T: %i", tm]];
            [tuesdayHours setText:[NSString stringWithFormat:@"H: %i", ht]];
            [tuesdayTasks setText:[NSString stringWithFormat:@"T: %i", tt]];
            [wednesdayHours setText:[NSString stringWithFormat:@"H: %i", hw]];
            [wednesdayTasks setText:[NSString stringWithFormat:@"T: %i", tw]];
            [thursdayHours setText:[NSString stringWithFormat:@"H: %i", hth]];
            [thursdayTasks setText:[NSString stringWithFormat:@"T: %i", tth]];
            [fridayHours setText:[NSString stringWithFormat:@"H: %i", hf]];
            [fridayTasks setText:[NSString stringWithFormat:@"T: %i", tf]];
            [saturdayHours setText:[NSString stringWithFormat:@"H: %i", hs]];
            [saturdayTasks setText:[NSString stringWithFormat:@"T: %i", ts]];
            [sundayHours setText:[NSString stringWithFormat:@"H: %i", hsu]];
            [sundayTasks setText:[NSString stringWithFormat:@"T: %i", tsu]];
            
            // Set Total Hours
            totalHours.text = [NSString stringWithFormat:@"%i", hm+ht+hw+hth+hf+hs+hsu];
            
        } //end if
        
        else {
            [mondayHours setText:@"H: 0"];
            [mondayTasks setText:@"T: 0"];
            [tuesdayHours setText:@"H: 0"];
            [tuesdayTasks setText:@"T: 0"];
            [wednesdayHours setText:@"H: 0"];
            [wednesdayTasks setText:@"T: 0"];
            [thursdayHours setText:@"H: 0"];
            [thursdayTasks setText:@"T: 0"];
            [fridayHours setText:@"H: 0"];
            [fridayTasks setText:@"T: 0"];
            [saturdayHours setText:@"H: 0"];
            [saturdayTasks setText:@"T: 0"];
            [sundayHours setText:@"H: 0"];
            [sundayTasks setText:@"T: 0"];
            totalHours.text = @"0";
        }
    }
    
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
                [mondayHours setText:[NSString stringWithFormat:@"H: %i", hm]];
                [mondayTasks setText:[NSString stringWithFormat:@"T: %i", jm]];
                [tuesdayHours setText:[NSString stringWithFormat:@"H: %i", ht]];
                [tuesdayTasks setText:[NSString stringWithFormat:@"T: %i", jt]];
                [wednesdayHours setText:[NSString stringWithFormat:@"H: %i", hw]];
                [wednesdayTasks setText:[NSString stringWithFormat:@"T: %i", jw]];
                [thursdayHours setText:[NSString stringWithFormat:@"H: %i", hth]];
                [thursdayTasks setText:[NSString stringWithFormat:@"T: %i", jth]];
                [fridayHours setText:[NSString stringWithFormat:@"H: %i", hf]];
                [fridayTasks setText:[NSString stringWithFormat:@"T: %i", jf]];
                [saturdayHours setText:[NSString stringWithFormat:@"H: %i", hs]];
                [saturdayTasks setText:[NSString stringWithFormat:@"T: %i", js]];
                [sundayHours setText:[NSString stringWithFormat:@"H: %i", hsu]];
                [sundayTasks setText:[NSString stringWithFormat:@"T: %i", jsu]];
                
                // Set Total Hours
                totalHours.text = [NSString stringWithFormat:@"%i", hm+ht+hw+hth+hf+hs+hsu];
                
//                NSLog(@"WHASDASDJKALHSDJASD \n\n\n\n\n %@", d.hr_approvals);
//                
//                //Set the sign using TimesheetApprovals
//                NSInteger signState = 0;
//                //HR_SuiteTimesheetApprovalsList *list = [HR_SuiteTimesheetApprovals findAll];
//                for (NSDictionary *item in d.hr_approvals) {
//                    if ([[item objectForKey:@"date"] isEqualToString:d.selectedDate] && [[item objectForKey:@"employeeID"] isEqualToString:d.user]) {
//                        signState = [[item objectForKey:@"signCode"] intValue];
//                    }
//                }
//                
//                
//                if(signState == 1) {
//                    status.text = @"Waiting for approval";
//                    managerNotesButton.hidden = YES;
//                }
//                else if(signState == 99) {
//                    //NSLog(@"STATUS IS Rejected");
//                    status.text = @"Rejected";
//                    managerNotesButton.hidden = NO;
//                    
//                }
//                else if(signState == 100) {
//                    status.text = @"Approved";
//                    managerNotesButton.hidden = YES;
//                }
//                else {
//                    status.text = @"Not yet submitted";
//                    managerNotesButton.hidden = YES;
//                }
//                
//                // Change button label/availability depending on the status
//                if ([status.text isEqualToString:@"Rejected"] || [status.text isEqualToString:@"Waiting for approval"]) {
//                    [submitButton setTitle:@"Resubmit" forState:UIControlStateNormal];
//                    submitButton.hidden = NO;
//                    d.historyState = @"";
//                }
//                else if ([status.text isEqualToString:@"Approved"]) {
//                    submitButton.hidden = YES;
//                    d.historyState = @"Status: Approved";
//                }
//                else if ([status.text isEqualToString:@"Not yet submitted"]) {
//                    [submitButton setTitle:@"Submit" forState:UIControlStateNormal];
//                    submitButton.hidden = NO;
//                    d.historyState = @"";
//                }
                
                
            } //if
        } //for
        
    }
    
}

- (void)setColorsForMonday:(UIColor *)monColor andTuesday:(UIColor *)tueColor andWednesday:(UIColor *)wedColor andThursday:(UIColor *)thuColor andFriday:(UIColor *)friColor andSaturday:(UIColor *)satColor andSunday:(UIColor *)sunColor
{
    [mondayLabel setTextColor:monColor];
    [mondaysDate setTextColor:monColor];
    [mondayHours setTextColor:monColor];
    [mondayTasks setTextColor:monColor];
    
    [tuesdayLabel setTextColor:tueColor];
    [tuesdaysDate setTextColor:tueColor];
    [tuesdayHours setTextColor:tueColor];
    [tuesdayTasks setTextColor:tueColor];
    
    [wednesdayLabel setTextColor:wedColor];
    [wednesdaysDate setTextColor:wedColor];
    [wednesdayHours setTextColor:wedColor];
    [wednesdayTasks setTextColor:wedColor];
    
    [thursdayLabel setTextColor:thuColor];
    [thursdaysDate setTextColor:thuColor];
    [thursdayHours setTextColor:thuColor];
    [thursdayTasks setTextColor:thuColor];
    
    [fridayLabel setTextColor:friColor];
    [fridaysDate setTextColor:friColor];
    [fridayHours setTextColor:friColor];
    [fridayTasks setTextColor:friColor];
    
    [saturdayLabel setTextColor:satColor];
    [saturdaysDate setTextColor:satColor];
    [saturdayHours setTextColor:satColor];
    [saturdayTasks setTextColor:satColor];
    
    [sundayLabel setTextColor:sunColor];
    [sundaysDate setTextColor:sunColor];
    [sundayHours setTextColor:sunColor];
    [sundayTasks setTextColor:sunColor];
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
    [self setMondayTasks:nil];
    [self setTuesdayTasks:nil];
    [self setWednesdayTasks:nil];
    [self setThursdayTasks:nil];
    [self setFridayTasks:nil];
    [self setSaturdayTasks:nil];
    [self setSundayTasks:nil];
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
    [self setTotalHoursLabel:nil];
    [self setSubmitLabel:nil];
    [self setMondayButton:nil];
    [self setTuesdayButton:nil];
    [self setWednesdayButton:nil];
    [self setThursdayButton:nil];
    [self setFridayButton:nil];
    [self setSaturdayButton:nil];
    [self setSundayButton:nil];
    [self setMondayLabel:nil];
    [self setTuesdayLabel:nil];
    [self setWednesdayLabel:nil];
    [self setThursdayLabel:nil];
    [self setFridayLabel:nil];
    [self setSaturdayLabel:nil];
    [self setSundayLabel:nil];
    [self setNavbar:nil];
    [self setMainView:nil];
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

- (void)configureLabels
{
    /* Font, Size */
    [mondayLabel setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:22]];
    [mondaysDate setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:22]];
    [mondayHours setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:11]];
    [mondayHours setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:11]];
    
    [tuesdayLabel setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:22]];
    [tuesdaysDate setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:22]];
    [tuesdayHours setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:11]];
    [tuesdayHours setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:11]];
    
    [wednesdayLabel setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:22]];
    [wednesdaysDate setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:22]];
    [wednesdayHours setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:11]];
    [wednesdayHours setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:11]];
    
    [thursdayLabel setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:22]];
    [thursdaysDate setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:22]];
    [thursdayHours setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:11]];
    [thursdayHours setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:11]];
    
    [fridayLabel setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:22]];
    [fridaysDate setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:22]];
    [fridayHours setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:11]];
    [fridayHours setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:11]];
    
    [saturdayLabel setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:22]];
    [saturdaysDate setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:22]];
    [saturdayHours setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:11]];
    [saturdayHours setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:11]];
    
    [sundayLabel setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:22]];
    [sundaysDate setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:22]];
    [sundayHours setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:11]];
    [sundayHours setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:11]];
    
    [totalHours setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:56]];
    [totalHoursLabel setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:12]];
    [submitLabel setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:15]];
}


/****************************************************************************************************
 Action for when a day is selected
 ****************************************************************************************************/
//Store the selected day and transition to the day view.
- (IBAction)mondaySelected:(id)sender {
    d.currentDate = currentWeek;
    d.selectedDay = @"Monday";
    [self performSegueWithIdentifier:@"toDayView" sender:self];    
}

- (IBAction)tuesdaySelected:(id)sender {
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"MM/dd/yyyy"];
    NSDate *temp = [format dateFromString:currentWeek];
    temp = [temp dateByAddingTimeInterval:60*60*24*1]; //back 7 days
    d.currentDate = [format stringFromDate:temp];
    d.selectedDay = @"Tuesday";
    [self performSegueWithIdentifier:@"toDayView" sender:self];    
}

- (IBAction)wednesdaySelected:(id)sender {
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"MM/dd/yyyy"];
    NSDate *temp = [format dateFromString:currentWeek];
    temp = [temp dateByAddingTimeInterval:60*60*24*2];
    d.currentDate = [format stringFromDate:temp];
    d.selectedDay = @"Wednesday";
    [self performSegueWithIdentifier:@"toDayView" sender:self];    
}

- (IBAction)thursdaySelected:(id)sender {
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"MM/dd/yyyy"];
    NSDate *temp = [format dateFromString:currentWeek];
    [temp dateByAddingTimeInterval:60*60*24*3];
    d.currentDate = [format stringFromDate:temp];
    d.selectedDay = @"Thursday";
    [self performSegueWithIdentifier:@"toDayView" sender:self];    
}

- (IBAction)fridaySelected:(id)sender {
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"MM/dd/yyyy"];
    NSDate *temp = [format dateFromString:currentWeek];
    temp = [temp dateByAddingTimeInterval:60*60*24*4];
    d.currentDate = [format stringFromDate:temp];
    d.selectedDay = @"Friday";
    [self setSelectedDate:mondaysDate.text];
    [self performSegueWithIdentifier:@"toDayView" sender:self];    
}

- (IBAction)saturdaySelected:(id)sender {
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"MM/dd/yyyy"];
    NSDate *temp = [format dateFromString:currentWeek];
    temp = [temp dateByAddingTimeInterval:60*60*24*5];
    d.currentDate = [format stringFromDate:temp];
    d.selectedDay = @"Saturday";
    [self performSegueWithIdentifier:@"toDayView" sender:self];    
}

- (IBAction)sundaySelected:(id)sender {
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"MM/dd/yyyy"];
    NSDate *temp = [format dateFromString:currentWeek];
    temp = [temp dateByAddingTimeInterval:60*60*24*6];
    d.currentDate = [format stringFromDate:temp];
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
    // get timestamp
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"MM/dd/yyy, HH:mm:ss"];
    NSString *timestamp = [format stringFromDate:[NSDate date]];

    // 07/08/2012 -convert-> 7/8/2012
    NSArray *a = [d.selectedDate componentsSeparatedByString:@"/"];
    NSString *first = [a objectAtIndex:0];
    NSString *second = [a objectAtIndex:1];
    if ([[a objectAtIndex:0] intValue] < 10) {
        first = [[a objectAtIndex:0] stringByReplacingOccurrencesOfString:@"0" withString:@""];
    }
    if ([[a objectAtIndex:1] intValue] < 10) {
        second = [[a objectAtIndex:1] stringByReplacingOccurrencesOfString:@"0" withString:@""];
    }
    NSString *date = [NSString stringWithFormat:@"%@/%@/%@", first, second, [a objectAtIndex:2]];

    
    /**********************/
    /*   SUP Connection   */
    /**********************/
    if (d.isSUPConnection) {
        if (buttonIndex == 1) {
            
            //Check the password.
            NSString *password = [[alertView textFieldAtIndex:0] text];
            
            // To find if entry exists, get list of submissions for current employee
            HR_SuiteUsersList *ulist = [HR_SuiteUsers findByEmployeeIDAndPassword:d.user withEmployeePassword:password];
            
            // If result is empty, password is wrong
            if ([ulist length] == 0) {
                UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Enter Password:" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Verify", nil];
                [message setAlertViewStyle:UIAlertViewStyleSecureTextInput];
                [message show];
                
                message = [[UIAlertView alloc] initWithTitle:@"Authentication Error:" message:@"Your password is incorrect!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [message setAlertViewStyle:UIAlertViewStyleDefault];
                [message show];
                return;
            }

                [LoadingScreen startLoadingScreenWithView:self.view];
            for (HR_SuiteUsers *users in ulist) {
                
                HR_SuiteTimesheetApprovalsList *list = [HR_SuiteTimesheetApprovals findAll];
                
                // If no entries were ever made, simply add it
                if ([list length] < 1) {
                    HR_SuiteTimesheetApprovals *item = [[HR_SuiteTimesheetApprovals alloc] init];
                    [item setEmployeeID:d.user];
                    [item setSignCode:[NSNumber numberWithInt:1]];
                    [item setDate:date];
                    [item setTimestamp:timestamp];
                    [item create];
                    [item submitPending];
                    [HR_SuiteHR_SuiteDB synchronize:@"default"];
                }
                
                BOOL matchFound = NO;
                for (HR_SuiteTimesheetApprovals *item in list) {
                    // Check for same id and date
                    if ([users.employeeID isEqualToString:item.employeeID] && [item.date isEqualToString:date]) {
                        NSLog(@"updating timesheet submission");
                        [item setSignCode:[NSNumber numberWithInt:1]];
                        [item setTimestamp:timestamp];
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
                    [item setDate:date];
                    [item setTimestamp:timestamp];
                    [item create];
                    [item submitPending];
                    [HR_SuiteHR_SuiteDB synchronize:@"default"];
                }
            } //end for
        
            [LoadingScreen stopLoadingScreenWithView:self.view];
            
            
            RCToast *t = [[RCToast alloc] init];
            [t showToastInView:self.view withMessage:@"Timesheet Submitted"];
            
        //status.text = @"Waiting for approval";
        //[submitButton setTitle:@"Resubmit" forState:UIControlStateNormal];
        } 
    }//end sup
    /************/
    /*   DEMO   */
    /************/
    else {
        if (buttonIndex == 1) {
            NSLog(@"%@", totalHours.text);
            entry = [NSDictionary dictionaryWithObjectsAndKeys:
                     d.user, @"employeeID",
                     totalHours.text, @"hours",
                     @"manager", @"manager",
                     @"User", @"employeeName",
                     timestamp, @"timestamp",
                     @"1", @"signCode",
                     @"", @"managerNotes",
                     date, @"date",
                     nil];
            [d.hr_approvals addObject:entry];
            
            RCToast *t = [[RCToast alloc] init];
            [t showToastInView:self.view withMessage:@"Timesheet Submitted"];
            
            managerNotesButton.hidden = YES;
            status.text = @"Waiting for approval";
            [submitButton setTitle:@"Resubmit" forState:UIControlStateNormal];
            //NSLog(@"submitted timesheet: \n %@", d.hr_approvals);
        }
    }
}


/****************************************************************************************************
 Internal Methods
 ****************************************************************************************************/
- (IBAction)goBack:(id)sender {
    [self.delegate reloadView];
    [self.navigationController popViewControllerAnimated:YES];
}



/****************************************************************************************************
 Show Manager's Note
 ****************************************************************************************************/
//- (IBAction)showManagerNotes:(id)sender 
//{
//
//    /**********************/
//    /*** SUP Connection ***/
//    /**********************/
//    if(d.isSUPConnection) {
//        NSString *managerNotes;
//        HR_SuiteTimesheetList *list = [HR_SuiteTimesheet findByEmployeeIDandDate:d.user withDate:d.selectedDate];
//        for (HR_SuiteTimesheet *item in list) {
//            managerNotes = item.managerNotes;
//        }
//        
//        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Reason for Rejection:" message:managerNotes delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil];
//        [message setAlertViewStyle:UIAlertViewStyleDefault];
//        [message show];
//    }
//    
//    /************/
//    /*   DEMO   */
//    /************/
//    else {
//        NSString *managerNotes;
//        for (NSDictionary *item in d.hr_approvals) {
//            if ([[item objectForKey:@"date"] isEqualToString:d.selectedDate] && [[item objectForKey:@"employeeID"] isEqualToString:d.user]) {
//                managerNotes = [item objectForKey:@"managerNotes"];
//            }
//        }
//        
//        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Reason for Rejection:" message:managerNotes delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil];
//        [message setAlertViewStyle:UIAlertViewStyleDefault];
//        [message show];
//    }
//}



/****************************************************************************************************
 Go to previous week
 ****************************************************************************************************/
- (IBAction)previousWeek:(id)sender 
{
    tsDate = [[TimesheetDate alloc] init];
    weekPositionOffset--;
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"MM/dd/yyyy"];
    NSDate *temp = [format dateFromString:currentWeek];
//    temp = [temp dateByAddingTimeInterval:60*60*24*-7]; //back 7 days
//    currentWeek = [format stringFromDate:temp]; NSLog(@"going to week %@", currentWeek);
//    [self configureStateForWeek:currentWeek];
    
    [format setDateFormat:@"MM"];
    NSInteger m = [[format stringFromDate:temp] intValue];
    
    [format setDateFormat:@"dd"];
    NSInteger dd = [[format stringFromDate:temp] intValue];
    
    [format setDateFormat:@"yyyy"];
    NSInteger y = [[format stringFromDate:temp] intValue];
    
    NSLog(@"going to week %@", [tsDate getDate:m day:dd-7 year:y]);
    currentWeek = [tsDate getDate:m day:dd-7 year:y];
    [self configureStateForWeek:currentWeek];
}



/****************************************************************************************************
 Go to next week
 ****************************************************************************************************/
- (IBAction)nextWeek:(id)sender 
{
    weekPositionOffset++;
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"MM/dd/yyyy"];
    NSDate *temp = [format dateFromString:currentWeek];
    
    [format setDateFormat:@"MM"];
    NSInteger m = [[format stringFromDate:temp] intValue];
    
    [format setDateFormat:@"dd"];
    NSInteger dd = [[format stringFromDate:temp] intValue];
    
    [format setDateFormat:@"yyyy"];
    NSInteger y = [[format stringFromDate:temp] intValue]; 
    
    NSLog(@"going to week %@", [tsDate getDate:m day:dd+7 year:y]);
    currentWeek = [tsDate getDate:m day:dd+7 year:y];
    [self configureStateForWeek:currentWeek];

}



@end
