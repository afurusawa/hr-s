//
//  MapViewController.h
//  HRDirectory
//
//  Created by Alex Chiu on 10/1/12.
//  Copyright (c) 2012 Alex Chiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "LocationAnnotation.h"

@interface MapViewController : UIViewController <MKMapViewDelegate>
{
    CLGeocoder *geocoder;
    __strong LocationAnnotation *annotationLocation;
    __weak IBOutlet UINavigationBar *navbar;
}

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) NSString *address;
@property (weak, nonatomic) NSString *name;
- (IBAction)goBack:(id)sender;


-(void)fetchCoordinates;

@end
