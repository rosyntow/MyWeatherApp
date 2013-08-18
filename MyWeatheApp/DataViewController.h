//
//  DataViewController.h
//  MyWeatheApp
//
//  Created by Rosina Otchere-Nyarko on 8/17/13.
//  Copyright (c) 2013 xperttech. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DataViewController;
@interface DataViewController : UIViewController
@property(nonatomic,strong)NSURL *openWeatherUrl;
-(NSNumber *)fetchTemperature:(NSURL *)openWeatherUrl;
@end
