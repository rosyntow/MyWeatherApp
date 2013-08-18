//
//  LocationPin.m
//  InventoryManager
//
//  Created by Boris Erceg on 10.8.2013..
//  Copyright (c) 2013. xperttech. All rights reserved.
//

#import "LocationPin.h"
@interface LocationPin()

@end
@implementation LocationPin

- (NSString *)title {
    return _name;
}

- (NSString *)subtitle {
    return _address;
}

-(CLLocationCoordinate2D)coordinate {
    return _newCoordinate;
}
-(void)setCoordinate:(CLLocationCoordinate2D)newCoordinate {
    _newCoordinate = newCoordinate;
}


@end
