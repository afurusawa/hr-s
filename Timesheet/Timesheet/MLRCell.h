//
//  MLRCell.h
//  Timesheet
//
//  Created by Andrew Furusawa on 12/3/12.
//
//

#import <UIKit/UIKit.h>

@interface MLRCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *submittedLabel;
@property (weak, nonatomic) IBOutlet UILabel *periodLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;

@property (weak, nonatomic) IBOutlet UILabel *submittedTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *periodTextLabel;


@property (weak, nonatomic) NSString *user;
@property (weak, nonatomic) NSString *date;
@property (weak, nonatomic) NSString *index;
@property (weak, nonatomic) UIViewController *vc;
- (IBAction)goNext:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *indexLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *userLabel;
@end
