//
//  LocationPin.h
//  InventoryManager
//
//  Created by Boris Erceg on 10.8.2013..
//  Copyright (c) 2013. xperttech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface LocationPin : NSObject <MKAnnotation>

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, assign) CLLocationCoordinate2D newCoordinate;
-(void)setCoordinate:(CLLocationCoordinate2D)newCoordinate;
@end
