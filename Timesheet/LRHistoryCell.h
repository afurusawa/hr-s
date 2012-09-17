//
//  LRHistoryCell.h
//  Timesheet
//
//  Created by Rapid Consulting on 8/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LRHistoryCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *leaveType;
@property (weak, nonatomic) IBOutlet UILabel *status;
@property (weak, nonatomic) IBOutlet UILabel *reason;

@property (weak, nonatomic) IBOutlet UILabel *managersNote;

@end
