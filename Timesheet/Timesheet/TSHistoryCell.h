//
//  HistoryCell.h
//  Timesheet
//
//  Created by Andrew Furusawa on 8/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TSHistoryCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *periodLabel;
@property (weak, nonatomic) IBOutlet UILabel *submittedLabel;
@property (weak, nonatomic) IBOutlet UILabel *hoursLabel;
@property (weak, nonatomic) IBOutlet UILabel *tasksLabel;
@property (weak, nonatomic) IBOutlet UIImageView *statusImage;

@property (weak, nonatomic) IBOutlet UILabel *periodTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *submittedTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *hoursTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *tasksTextLabel;
@end
