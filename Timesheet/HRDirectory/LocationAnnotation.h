//
//  LocationAnnotation.h
//  HRDirectory
//
//  Created by Alex Chiu on 10/1/12.
//  Copyright (c) 2012 Alex Chiu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface LocationAnnotation : NSObject <MKAnnotation>

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (copy) NSString *name;
@property (copy) NSString *address;

- (id)initWithName:(NSString*)name address:(NSString*)address coordinate:(CLLocationCoordinate2D)coordinate;

@end
