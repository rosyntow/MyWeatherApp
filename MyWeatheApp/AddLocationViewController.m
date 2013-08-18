//
//  AddLocationViewController.m
//  MyWeatheApp
//
//  Created by Rosina Otchere-Nyarko on 8/17/13.
//  Copyright (c) 2013 xperttech. All rights reserved.
//

#import "AddLocationViewController.h"
#import <MapKit/MapKit.h>
#import "LocationPin.h"
#import "ViewController.h"

@interface AddLocationViewController ()<UISearchBarDelegate, MKMapViewDelegate>
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) CLGeocoder *geocoder;
@property (nonatomic, assign) CLLocationCoordinate2D locCoordinate;

@end

@implementation AddLocationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Location";
        _geocoder = [[CLGeocoder alloc] init];    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController.navigationBar setOpaque:NO];
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveButtonPressed)];
    
    [self.navigationItem setRightBarButtonItem:saveButton animated:YES];
    
    [self addAnnotationAt:self.mapView.centerCoordinate];
}

- (void)saveButtonPressed {
    NSLog(@"%f",self.locCoordinate.latitude);
    [self.delegate locationViewControllerFoundLocation:self.locCoordinate];
    //[self.navigationController popViewControllerAnimated:YES];

}


- (void)addAnnotationAt:(CLLocationCoordinate2D)coordinate {
    
    [self.mapView removeAnnotations:[self.mapView annotations]];
    LocationPin *pin = [[LocationPin alloc] init];
    [pin setCoordinate:coordinate];
    [pin setName:@"New location"];
    [self.mapView addAnnotation:pin];
    [self.mapView setCenterCoordinate:pin.coordinate animated:YES];
     
    self.locCoordinate = coordinate;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    NSString *searchTerm = searchBar.text;
    
    CLLocation *location = [[CLLocation alloc] initWithLatitude:self.mapView.centerCoordinate.latitude
                                                      longitude:self.mapView.centerCoordinate.longitude];
    
    [self.geocoder geocodeAddressString:searchTerm
                      completionHandler:^(NSArray *placemarks, NSError *error) {
                          if (placemarks) {
                              NSArray *sorted = [self distanceSortPlacemarks:placemarks fromLocation:location];
                              CLPlacemark *placemark = sorted[0];
                              [self addAnnotationAt:placemark.location.coordinate];
                              
                          }
                      }];
}

- (void)findAddressForCoordinate:(CLLocationCoordinate2D)coordinate {
    [self.geocoder cancelGeocode];
    CLLocation *location = [[CLLocation alloc] initWithLatitude:coordinate.latitude
                                                      longitude:coordinate.longitude];
    [self.geocoder reverseGeocodeLocation:location
                        completionHandler:^(NSArray *placemarks, NSError *error) {
                            
                            if (placemarks) {
                                NSArray *sorted = [self distanceSortPlacemarks:placemarks fromLocation:location];
                                CLPlacemark *placemark = sorted[0];
                                [self.searchBar setText:placemark.name];
                                
                            }
                            
                        }];
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)annotationView didChangeDragState:(MKAnnotationViewDragState)newState fromOldState:(MKAnnotationViewDragState)oldState
{
    if (newState == MKAnnotationViewDragStateEnding) {
        self.locCoordinate = annotationView.annotation.coordinate;
        [self findAddressForCoordinate:self.locCoordinate];
    }
}


-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    static NSString *identifier = @"MyLocation";
    
    MKAnnotationView *annotationView = (MKPinAnnotationView *) [_mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    if (annotationView == nil) {
        annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        annotationView.enabled = YES;
        annotationView.canShowCallout = YES;
        annotationView.draggable = YES;
        // [annotationView setImage:[UIImage imageNamed:@"cat.jpg"]];
    } else {
        annotationView.annotation = annotation;
    }
    
    return annotationView;
}

-(NSMutableArray *)distanceSortPlacemarks:(NSArray *)inputArray fromLocation:(CLLocation *)originLocation
{
    NSMutableArray *returnValue = [[NSMutableArray alloc] initWithCapacity:[inputArray count]];
    
    NSMutableDictionary *sortDictionary = [[NSMutableDictionary alloc] initWithCapacity:[inputArray count]];
    for( int i = 0; i < [inputArray count]; i++ )
    {
        CLPlacemark *currentPlacemark = [inputArray objectAtIndex:i];
        
        [sortDictionary
         setObject:currentPlacemark
         forKey:[NSNumber numberWithDouble:[currentPlacemark.location distanceFromLocation:originLocation]]
         ];
    }
    
    NSArray *sortedKeys = [[sortDictionary allKeys] sortedArrayUsingSelector:@selector(compare:)];
    
    for( int i = 0; i < [sortedKeys count]; i++ )
    {
        CLPlacemark *currentPlacemark = [sortDictionary objectForKey:[sortedKeys objectAtIndex:i]];
        [returnValue insertObject:currentPlacemark atIndex:i];
    }
    
    return returnValue;
}

@end
