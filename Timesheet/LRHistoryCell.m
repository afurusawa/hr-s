//
//  LRHistoryCell.m
//  Timesheet
//
//  Created by Rapid Consulting on 8/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LRHistoryCell.h"

@implementation LRHistoryCell
@synthesize date;
@synthesize leaveType;
@synthesize status;
@synthesize reason;
@synthesize managersNote;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
