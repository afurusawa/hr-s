//
//  HistoryCell.m
//  Timesheet
//
//  Created by Andrew Furusawa on 8/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HistoryCell.h"

@implementation HistoryCell
@synthesize date;
@synthesize status;
@synthesize hours;
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
    
}

@end
