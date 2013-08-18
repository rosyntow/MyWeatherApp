//
//  AddLocationViewController.h
//  MyWeatheApp
//
//  Created by Rosina Otchere-Nyarko on 8/17/13.
//  Copyright (c) 2013 xperttech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@protocol AddLocationViewControllerDelegate <NSObject>
@required
-(void)locationViewControllerFoundLocation:(CLLocationCoordinate2D)location;

@end
@interface AddLocationViewController : UIViewController
@property (nonatomic, weak) id<AddLocationViewControllerDelegate> delegate;

@end
