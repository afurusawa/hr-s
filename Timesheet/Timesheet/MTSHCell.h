//
//  MTSHCell.h
//  Timesheet
//
//  Created by Andrew Furusawa on 12/3/12.
//
//

#import <UIKit/UIKit.h>

@interface MTSHCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *submittedLabel;
@property (weak, nonatomic) IBOutlet UILabel *periodLabel;
@property (weak, nonatomic) IBOutlet UILabel *hoursLabel;
@property (weak, nonatomic) IBOutlet UIImageView *statusImage;

@property (weak, nonatomic) IBOutlet UILabel *submittedTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *periodTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *hoursTextLabel;


@end
