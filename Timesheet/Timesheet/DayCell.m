//
//  DayCell.m
//  Timesheet
//
//  Created by Rapid Consulting on 8/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DayCell.h"

@implementation DayCell
@synthesize taskLabel;
@synthesize hoursField;
@synthesize deleteButton;

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    [theTextField resignFirstResponder];
    return YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



@end
