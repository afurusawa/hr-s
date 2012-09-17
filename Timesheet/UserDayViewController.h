//
//  UserDayViewController.h
//  Timesheet
//
//  Created by Andrew Furusawa on 7/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JobViewController.h"

@class UserDayViewController;

@protocol UserDayViewControllerDelegate <NSObject>
- (void)reloadView;
@end


@interface UserDayViewController : UIViewController <JobViewControllerDelegate, UITextFieldDelegate>
{
    UIPopoverController *popover;
    UITextField *hoursSelected;

}
/*** Job Selector Actions ***/
- (IBAction)jobSelector:(id)sender;
//- (IBAction)iPhoneJobSelector:(id)sender;

/*** Job Selector Buttons ***/
@property (weak, nonatomic) IBOutlet UIButton *jobSlot1;
@property (weak, nonatomic) IBOutlet UIButton *jobSlot2;
@property (weak, nonatomic) IBOutlet UIButton *jobSlot3;
@property (weak, nonatomic) IBOutlet UIButton *jobSlot4;
@property (weak, nonatomic) IBOutlet UIButton *jobSlot5;
@property (strong, nonatomic) IBOutlet UIButton *jobSlot6;
@property (strong, nonatomic) IBOutlet UIButton *jobSlot7;
@property (strong, nonatomic) IBOutlet UIButton *jobSlot8;
@property (strong, nonatomic) IBOutlet UIButton *jobSlot9;
@property (strong, nonatomic) IBOutlet UIButton *jobSlot10;

/*** Hours Textfield ***/
@property (weak, nonatomic) IBOutlet UITextField *hoursField1;
@property (weak, nonatomic) IBOutlet UITextField *hoursField2;
@property (weak, nonatomic) IBOutlet UITextField *hoursField3;
@property (weak, nonatomic) IBOutlet UITextField *hoursField4;
@property (weak, nonatomic) IBOutlet UITextField *hoursField5;
@property (strong, nonatomic) IBOutlet UITextField *hoursField6;
@property (strong, nonatomic) IBOutlet UITextField *hoursfield7;
@property (strong, nonatomic) IBOutlet UITextField *hoursField8;
@property (strong, nonatomic) IBOutlet UITextField *hoursField9;
@property (strong, nonatomic) IBOutlet UITextField *hoursField10;

/*** Labeles ***/
@property (weak, nonatomic) IBOutlet UILabel *totalHoursField;
@property (weak, nonatomic) IBOutlet UILabel *currentDayField;
@property (weak, nonatomic) IBOutlet UILabel *currentDateField;

- (IBAction)submitDay:(id)sender;
- (IBAction)updateHours:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *doneButton;

@property (weak, nonatomic) id <UserDayViewControllerDelegate> delegate;
@property NSInteger jobIndex;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

- (void)updateJobSlots;
- (void)updateHourSlots;

/*** Activity Indications ***/
@property (weak, nonatomic) IBOutlet UIImageView *grayOutImage;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activity;


@end
