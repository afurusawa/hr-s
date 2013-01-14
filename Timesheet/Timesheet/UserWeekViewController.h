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

@class UserWeekViewController;

@protocol UserWeekViewControllerDelegate <NSObject>
- (void)reloadView;
@end

@interface UserWeekViewController : UIViewController <UDayViewControllerDelegate>
@property (weak, nonatomic) id <UserWeekViewControllerDelegate> delegate;
//Day Labels
@property (weak, nonatomic) IBOutlet UILabel *mondayLabel;
@property (weak, nonatomic) IBOutlet UILabel *tuesdayLabel;
@property (weak, nonatomic) IBOutlet UILabel *wednesdayLabel;
@property (weak, nonatomic) IBOutlet UILabel *thursdayLabel;
@property (weak, nonatomic) IBOutlet UILabel *fridayLabel;
@property (weak, nonatomic) IBOutlet UILabel *saturdayLabel;
@property (weak, nonatomic) IBOutlet UILabel *sundayLabel;

/*** Month/Day visited ***/
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

/*** Tasks per day ***/
@property (weak, nonatomic) IBOutlet UILabel *mondayTasks;
@property (weak, nonatomic) IBOutlet UILabel *tuesdayTasks;
@property (weak, nonatomic) IBOutlet UILabel *wednesdayTasks;
@property (weak, nonatomic) IBOutlet UILabel *thursdayTasks;
@property (weak, nonatomic) IBOutlet UILabel *fridayTasks;
@property (weak, nonatomic) IBOutlet UILabel *saturdayTasks;
@property (weak, nonatomic) IBOutlet UILabel *sundayTasks;


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
@property (weak, nonatomic) IBOutlet UILabel *totalHoursLabel;
@property (weak, nonatomic) IBOutlet UILabel *submitLabel;
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


- (void)setColorsForMonday:(UIColor *)monColor andTuesday:(UIColor *)tueColor andWednesday:(UIColor *)wedColor andThursday:(UIColor *)thuColor andFriday:(UIColor *)friColor andSaturday:(UIColor *)satColor andSunday:(UIColor *)sunColor;
- (void) loadCurrentWeek:(NSInteger)month day:(NSInteger)day year:(NSInteger)year;


@property (weak, nonatomic) IBOutlet UINavigationBar *navbar;
- (IBAction)goBack:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *mainView;




@end
