//
//  JMCell.h
//  Timesheet
//
//  Created by Rapid Consulting on 8/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JMCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *removeButton;
@property (weak, nonatomic) IBOutlet UILabel *jobNameLabel;

@end
