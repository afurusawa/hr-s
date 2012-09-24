//
//  MLRDetailViewController.h
//  Timesheet
//
//  Created by Andrew Furusawa on 7/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MLRDetailViewController;

@protocol MLRDetailViewControllerDelegate <NSObject>

- (void)reloadView;

@end

@interface MLRDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *employeeName;
@property (weak, nonatomic) IBOutlet UILabel *submittedOn;
@property (weak, nonatomic) IBOutlet UITextField *startDate;
@property (weak, nonatomic) IBOutlet UITextField *endDate;
@property (weak, nonatomic) IBOutlet UIButton *leaveType;
@property (weak, nonatomic) IBOutlet UITextField *reason;
@property (weak, nonatomic) IBOutlet UITextView *managerNotes;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

- (IBAction)approve:(id)sender;
- (IBAction)deny:(id)sender;

@property (weak, nonatomic) id <MLRDetailViewControllerDelegate> delegate;

@end
