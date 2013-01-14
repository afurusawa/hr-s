//
//  MemberCell.m
//  Timesheet
//
//  Created by Rapid Consulting on 8/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MemberCell.h"

@implementation MemberCell
@synthesize department;
@synthesize name;
@synthesize position;

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
