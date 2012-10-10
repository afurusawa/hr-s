//
//  LocationAnnotation.m
//  HRDirectory
//
//  Created by Alex Chiu on 10/1/12.
//  Copyright (c) 2012 Alex Chiu. All rights reserved.
//

#import "LocationAnnotation.h"

@implementation LocationAnnotation

-(id)initWithName:(NSString *)name address:(NSString *)address coordinate:(CLLocationCoordinate2D)coordinate
{
    if(self = [super init])
    {
        self.name = [name copy];
        self.address = [address copy];
        _coordinate = coordinate;
    }
    return self;
}

-(NSString *)title
{
    if([self.name isKindOfClass:[NSNull class]])
    {
        return @"Unknown charge";
    }
    else
        return self.name;
}

-(NSString *)subtitle
{
    return self.address;
}

@end
