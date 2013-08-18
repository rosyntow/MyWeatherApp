//
//  coordinates.m
//  MyWeatheApp
//
//  Created by Rosina Otchere-Nyarko on 8/18/13.
//  Copyright (c) 2013 xperttech. All rights reserved.
//

#import "coordinates.h"


@implementation coordinates
- (id)initWithDictionary:(NSDictionary *)dictionary {
    self =  [super init];
    if (self) {
        self.longitude = [dictionary objectForKey:KCoordinateLongitude];
        self.latitude = [dictionary objectForKey:KCoordinateLatitude];
           }
    return self;
}


- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *returnDictionary = [NSMutableDictionary dictionary];
    
    if (self.longitude) {
        [returnDictionary setObject:self.longitude forKey:KCoordinateLongitude];
    }
    if (self.latitude) {
        [returnDictionary setObject:self.latitude forKey:KCoordinateLatitude];
    }
    
    
    
    return [NSDictionary dictionaryWithDictionary:returnDictionary];
    
}



- (void)addCoordinates:(coordinates *)coordinate {
    if (self.coordinates == nil) {
        self.coordinates = [NSMutableArray array];
    }
    [self.coordinates addObject:coordinate];
}
@end
