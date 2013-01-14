//
//  MTimesheetCell.h
//  Timesheet
//
//  Created by Andrew Furusawa on 11/28/12.
//
//

#import <UIKit/UIKit.h>

@interface MTimesheetCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timestampLabel;
@property (weak, nonatomic) IBOutlet UILabel *weekLabel;
@property (weak, nonatomic) IBOutlet UILabel *hoursLabel;
@property (weak, nonatomic) IBOutlet UILabel *submittedTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *periodTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *hoursTextLabel;


//these labels will be hidden and contain the employee id (user) and timestamp (date) so it can be passed.
@property (weak, nonatomic) IBOutlet UILabel *user;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *index;

- (IBAction)goNext:(id)sender;

@property (weak, nonatomic) UIViewController *vc;
@end
