//
//  MLRHCell.h
//  Timesheet
//
//  Created by Andrew Furusawa on 12/3/12.
//
//

#import <UIKit/UIKit.h>

@interface MLRHCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *submittedLabel;
@property (weak, nonatomic) IBOutlet UILabel *periodLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *statusImage;
@property (weak, nonatomic) IBOutlet UILabel *submittedTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *periodTextLabel;

@end
