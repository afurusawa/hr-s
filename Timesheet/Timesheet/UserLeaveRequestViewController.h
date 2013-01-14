//
//  UserLeaveRequestViewController.h
//  Timesheet
//
//  Created by Andrew Furusawa on 7/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserLeaveTypeViewController.h"

@interface UserLeaveRequestViewController : UIViewController <UserLeaveTypeViewControllerDelegate, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource>
{
    UIPopoverController *popover;
}

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

- (IBAction)datePicked:(id)sender;
- (IBAction)dateSubmit:(id)sender;
- (IBAction)typeSelector:(id)sender;
- (IBAction)submitRequest:(id)sender;
- (IBAction)clearRequest:(id)sender;

@property (weak, nonatomic) IBOutlet UIToolbar *doneBar;

//ERROR CHECKING
@property (weak, nonatomic) IBOutlet UIButton *dateCheckBadge;
@property (weak, nonatomic) IBOutlet UILabel *dateCheckLabel;

@property (weak, nonatomic) IBOutlet UIButton *leaveTypeCheckBadge;
@property (weak, nonatomic) IBOutlet UILabel *leaveTypeCheckLabel;

@property (weak, nonatomic) IBOutlet UIButton *reasonCheckBadge;
@property (weak, nonatomic) IBOutlet UILabel *reasonCheckLabel;

- (IBAction)editDidBegin:(id)sender;


@property (weak, nonatomic) IBOutlet UINavigationBar *navbar;
- (IBAction)goBack:(id)sender;

//labels
@property (weak, nonatomic) IBOutlet UITextField *startField;
@property (weak, nonatomic) IBOutlet UITextField *endField;
@property (weak, nonatomic) IBOutlet UIButton *leaveType;
@property (weak, nonatomic) IBOutlet UITextField *reasonField;
@property (weak, nonatomic) IBOutlet UILabel *directionLabel;

/***** Input Accessory View required for toolbar above keyboard *****/
@property (strong, nonatomic) UIView *inputAccessoryView;

@property (weak, nonatomic) UITextField *activeTextField;
@property (strong, nonatomic) UITapGestureRecognizer *tap;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end
