//
//  coordinates.h
//  MyWeatheApp
//
//  Created by Rosina Otchere-Nyarko on 8/18/13.
//  Copyright (c) 2013 xperttech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SerializibleObject.h"

#define KCoordinateLongitude @"longitude"
#define KCoordinateLatitude @"latitude"

@interface coordinates : NSObject<SerializibleObject>
- (void)addCoordinates:(coordinates *)coordinate;
@property (nonatomic, strong) NSMutableArray *coordinates;

@property (nonatomic, strong) NSNumber *longitude;
@property (nonatomic, strong) NSNumber *latitude;
@end
