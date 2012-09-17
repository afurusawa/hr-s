//
//  AFQuartzCore.m
//  Timesheet
//
//  Created by Rapid Consulting on 8/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AFQuartzCore.h"

@interface AFQuartzCore ()

@end

@implementation AFQuartzCore

- (void)modifyButton:(UIButton *)button {
    [[button layer] setCornerRadius:12.0f]; // Used to round edges
    [[button layer] setMasksToBounds:YES]; //
    [[button layer] setBorderWidth:3.0f]; // Width of the border
    [[button layer] setBorderColor:[[UIColor blueColor] CGColor]]; // Color of the border
    
}


@end
