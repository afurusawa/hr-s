//
//  UserWeekViewController.h
//  Timesheet
//
//  Created by Andrew Furusawa on 7/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "UDayViewController.h"

@interface UserWeekViewController : UIViewController <UDayViewControllerDelegate>

/*** Month Day, Year ***/
@property (weak, nonatomic) IBOutlet UILabel *mondaysDate;
@property (weak, nonatomic) IBOutlet UILabel *tuesdaysDate;
@property (weak, nonatomic) IBOutlet UILabel *wednesdaysDate;
@property (weak, nonatomic) IBOutlet UILabel *thursdaysDate;
@property (weak, nonatomic) IBOutlet UILabel *fridaysDate;
@property (weak, nonatomic) IBOutlet UILabel *saturdaysDate;
@property (weak, nonatomic) IBOutlet UILabel *sundaysDate;

/*** Hours worked per day ***/
@property (weak, nonatomic) IBOutlet UILabel *mondayHours;
@property (weak, nonatomic) IBOutlet UILabel *tuesdayHours;
@property (weak, nonatomic) IBOutlet UILabel *wednesdayHours;
@property (weak, nonatomic) IBOutlet UILabel *thursdayHours;
@property (weak, nonatomic) IBOutlet UILabel *fridayHours;
@property (weak, nonatomic) IBOutlet UILabel *saturdayHours;
@property (weak, nonatomic) IBOutlet UILabel *sundayHours;

/*** Number of projects worked on per day ***/
@property (weak, nonatomic) IBOutlet UILabel *mondayProjects;
@property (weak, nonatomic) IBOutlet UILabel *tuesdayProjects;
@property (weak, nonatomic) IBOutlet UILabel *wednesdayProjects;
@property (weak, nonatomic) IBOutlet UILabel *thursdayProjects;
@property (weak, nonatomic) IBOutlet UILabel *fridayProjects;
@property (weak, nonatomic) IBOutlet UILabel *saturdayProjects;
@property (weak, nonatomic) IBOutlet UILabel *sundayProjects;


/*** Body Area ***/
- (IBAction)mondaySelected:(id)sender;
- (IBAction)tuesdaySelected:(id)sender;
- (IBAction)wednesdaySelected:(id)sender;
- (IBAction)thursdaySelected:(id)sender;
- (IBAction)fridaySelected:(id)sender;
- (IBAction)saturdaySelected:(id)sender;
- (IBAction)sundaySelected:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *mondayButton;
@property (strong, nonatomic) IBOutlet UIButton *tuesdayButton;
@property (strong, nonatomic) IBOutlet UIButton *wednesdayButton;
@property (strong, nonatomic) IBOutlet UIButton *thursdayButton;
@property (strong, nonatomic) IBOutlet UIButton *fridayButton;
@property (strong, nonatomic) IBOutlet UIButton *saturdayButton;
@property (strong, nonatomic) IBOutlet UIButton *sundayButton;



/*** Signing the timesheet ***/
@property (weak, nonatomic) IBOutlet UIButton *submitButton;
- (IBAction)signTimesheet:(id)sender;

/*** Total Hours worked this week ***/
@property (weak, nonatomic) IBOutlet UILabel *totalHours;



/*** State Variables ***/
@property (strong, nonatomic) NSString *selectedDay;
@property (strong, nonatomic) NSString *selectedDate;



/*** Header Area ***/
@property (weak, nonatomic) IBOutlet UIButton *nextWeekButton;
- (IBAction)nextWeek:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *previousWeekButton;
- (IBAction)previousWeek:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *status;
@property (weak, nonatomic) IBOutlet UIButton *managerNotesButton;
- (IBAction)showManagerNotes:(id)sender;



- (void) loadCurrentWeek:(NSInteger)month day:(NSInteger)day year:(NSInteger)year;



@end
