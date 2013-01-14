//
//  DayCell.h
//  Timesheet
//
//  Created by Rapid Consulting on 8/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DayCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *taskLabel;
@property (weak, nonatomic) IBOutlet UITextField *hoursField;

@property (weak, nonatomic) IBOutlet UIButton *deleteButton;

@end
