//
//  LRHistoryCell.h
//  Timesheet
//
//  Created by Rapid Consulting on 8/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LRHistoryCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *reasonLabel;
@property (weak, nonatomic) IBOutlet UILabel *submittedLabel;
@property (weak, nonatomic) IBOutlet UILabel *periodLabel;
@property (weak, nonatomic) IBOutlet UIImageView *statusImage;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *submittedTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *periodTextLabel;

@end
