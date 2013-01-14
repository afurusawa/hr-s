//
//  MapViewController.m
//  HRDirectory
//
//  Created by Alex Chiu on 10/1/12.
//  Copyright (c) 2012 Alex Chiu. All rights reserved.
//

#import "MapViewController.h"

#define METERS_PER_MILE 1609.344

@interface MapViewController ()

@end

@implementation MapViewController

@synthesize name = _name;
@synthesize address = _address;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //navbar title bg
    [navbar setBackgroundImage:[UIImage imageNamed:@"ts.topappbar-bg.png"] forBarMetrics:UIBarMetricsDefault];
       
}

- (void)viewDidUnload {
    [self setMapView:nil];
    navbar = nil;
    [super viewDidUnload];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)fetchCoordinates
{    
    if(!geocoder)
    {
        geocoder = [[CLGeocoder alloc] init];
    }    
    
    [geocoder geocodeAddressString:self.address completionHandler:^(NSArray *placemarks, NSError *error)
    {
        NSLog(@"%d", [placemarks count]);
        
        if([placemarks count] > 0)
        {
            CLPlacemark *placemark = [placemarks objectAtIndex:0];
            CLLocation *location = placemark.location;
            CLLocationCoordinate2D coordinate = location.coordinate;
            
            annotationLocation = [[LocationAnnotation alloc] initWithName:self.name address:self.address coordinate:coordinate];
            
            //Zooming onto location
            MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(annotationLocation.coordinate, METERS_PER_MILE, METERS_PER_MILE);
            [self.mapView setRegion:viewRegion animated:YES];
            
            //Setting annotation to said location
            [self.mapView addAnnotation:annotationLocation];
        }
        else
        {
            NSLog(@"Cannot find a location for this");
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Address Error" message:@"No location found" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
            
        
        
    }];    
}

#pragma mark - MKMapViewDelegate
-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    static NSString *identifier = @"Location";
    if([annotation isKindOfClass:[LocationAnnotation class]])
    {
        MKPinAnnotationView *annotationView = (MKPinAnnotationView *)[self.mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        
        if(annotationView == nil)
        {
            annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        }
        else
            annotationView.annotation = annotation;
        
        annotationView.enabled = YES;
        annotationView.canShowCallout = YES;
        
        return annotationView;
    }
    
    return nil;
}


@end
