//
//  UMonthViewController.h
//  Timesheet
//
//  Created by Andrew Furusawa on 11/15/12.
//
//

#import <UIKit/UIKit.h>
#import "UserWeekViewController.h"
#import "AppDelegate.h"

@interface UMonthViewController : UIViewController <UserWeekViewControllerDelegate, SUPSyncStatusListener>

@property (weak, nonatomic) IBOutlet UILabel *monthLabel;
@property (weak, nonatomic) IBOutlet UILabel *yearLabel;

- (NSString *)getMondayFromDate:(NSDate *)date forDay:(NSString *)day;

/* 2 Weeks Ago*/
@property (weak, nonatomic) IBOutlet UILabel *w1DateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *w1StatusImage;
@property (weak, nonatomic) IBOutlet UILabel *w1HoursLabel;
@property (weak, nonatomic) IBOutlet UILabel *w1TasksLabel;
@property (weak, nonatomic) IBOutlet UILabel *w1HoursTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *w1TasksTextLabel;
- (IBAction)w1Selected:(id)sender;


/* Last Week */
@property (weak, nonatomic) IBOutlet UILabel *w2DateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *w2StatusImage;
@property (weak, nonatomic) IBOutlet UILabel *w2HoursLabel;
@property (weak, nonatomic) IBOutlet UILabel *w2TasksLabel;
@property (weak, nonatomic) IBOutlet UILabel *w2HoursTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *w2TasksTextLabel;
- (IBAction)w2Selected:(id)sender;

/* Current Week */
@property (weak, nonatomic) IBOutlet UILabel *w3DateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *w3StatusImage;
@property (weak, nonatomic) IBOutlet UILabel *w3HoursLabel;
@property (weak, nonatomic) IBOutlet UILabel *w3TasksLabel;
@property (weak, nonatomic) IBOutlet UILabel *w3HoursTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *w3TasksTextLabel;
- (IBAction)w3Selected:(id)sender;

/* Next Week */
@property (weak, nonatomic) IBOutlet UILabel *w4DateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *w4StatusImage;
@property (weak, nonatomic) IBOutlet UILabel *w4HoursLabel;
@property (weak, nonatomic) IBOutlet UILabel *w4TasksLabel;
@property (weak, nonatomic) IBOutlet UILabel *w4HoursTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *w4TasksTextLabel;

/* In 2 Weeks */
@property (weak, nonatomic) IBOutlet UILabel *w5DateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *w5StatusImage;
@property (weak, nonatomic) IBOutlet UILabel *w5HoursLabel;
@property (weak, nonatomic) IBOutlet UILabel *w5TasksLabel;
@property (weak, nonatomic) IBOutlet UILabel *w5HoursTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *w5TasksTextLabel;



@property (weak, nonatomic) IBOutlet UINavigationBar *navbar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backBarButtonItem;
@property (weak, nonatomic) IBOutlet UIButton *homebutton;
- (IBAction)goHome:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *mainView;

@end
