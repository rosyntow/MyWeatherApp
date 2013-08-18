//
//  DataViewController.m
//  MyWeatheApp
//
//  Created by Rosina Otchere-Nyarko on 8/17/13.
//  Copyright (c) 2013 xperttech. All rights reserved.
//

#import "DataViewController.h"
@interface DataViewController ()
@property (nonatomic,strong) NSNumber *temp;
@end
@implementation DataViewController

-(id)init{
    self = [super init];
    
    if(self)
    {
    }
    return self;

}


-(NSNumber *)fetchTemperature:(NSURL *)openWeatherUrl{
    
    NSError *error;

    NSData *openWeatherData = [[NSData alloc] initWithContentsOfURL:openWeatherUrl];
    NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:openWeatherData options:NSJSONReadingMutableContainers error:&error];
    if(jsonData){
        NSArray *mainData = [jsonData objectForKey:@"main"];
        self.temp = [mainData valueForKey:@"temp"];
       
        
    }
    return self.temp;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    //[self fetchTemperature];
	// Do any additional setup after loading the view.
}



@end
