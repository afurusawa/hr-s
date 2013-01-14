//
//  MApprovalCell.h
//  Timesheet
//
//  Created by Andrew Furusawa on 11/28/12.
//
//

#import <UIKit/UIKit.h>

@interface MApprovalCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UITextField *headerLabel;

@property (weak, nonatomic) IBOutlet UITextField *taskLabel;
@property (weak, nonatomic) IBOutlet UILabel *hoursLabel;
@property (weak, nonatomic) IBOutlet UILabel *hoursTextLabel;
@property (weak, nonatomic) IBOutlet UIImageView *bgImage;


@end
