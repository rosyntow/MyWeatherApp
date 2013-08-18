//
//  ViewController.m
//  MyWeatheApp
//
//  Created by Rosina Otchere-Nyarko on 8/17/13.
//  Copyright (c) 2013 xperttech. All rights reserved.
//

#import "ViewController.h"
#import "EditCell.h"
#import "AddLocationViewController.h"
#import "DataViewController.h"
#import "coordinates.h"

@interface ViewController ()<AddLocationViewControllerDelegate,UITextFieldDelegate, UITableViewDataSource,EditCellDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) IBOutlet UITextField *textField;

@property (strong,nonatomic) NSURL *openWeatherUrl;
@property(strong,nonatomic)NSArray *arrayLabels;
@property (strong,nonatomic)coordinates *coordinates;
@end

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.coordinates = [[coordinates alloc] init];
        //UITabBarItem *tabBarItem = [self tabBarItem];
        self.title = NSLocalizedString(@"Weather Report", @"Weather Report");
        
    }
    
    return self;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.openWeatherUrl = [NSURL URLWithString:@"http://api.openweathermap.org/data/2.5/weather?q=London"];
    //self.arrayLabels = [NSArray arrayWithObjects:@"City or Location",@"GO",nil];
    [self displayTemperature];
    
}


-(void)displayTemperature{

    DataViewController *data = [[DataViewController alloc] init];
    NSNumber *temp = [data fetchTemperature:self.openWeatherUrl];
    NSLog(@"%@",temp);
    [self.textField setText:[NSString stringWithFormat:@"%@",temp]];
    
}

-(void)addLocationCellPressed{
    
    AddLocationViewController *addLocation = [[AddLocationViewController alloc] initWithNibName:@"AddLocationViewController" bundle:nil];
    [addLocation setDelegate:self];
    [[self navigationController] pushViewController:addLocation animated:YES];

}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 1){
        return 3;
    }
    return 2;

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    if(indexPath.section == 0)
    {
       EditCell *newcell = [EditCell newCellWithDelegate:self andText:@"City" forProperty:@"City or Location"];
    
    
    if (indexPath.row==1) {
        newcell.type = EditCellTypeTextResult;
        
    }
        return newcell;

    }else if(indexPath.section ==1)
    {
        NSString *defaultText = @"";
        if(self.coordinates.longitude){
        defaultText = [NSString stringWithFormat:@"%@ long %@ lat", self.coordinates.longitude,self.coordinates.latitude];
    }
        EditCell *newcell = [EditCell newCellWithDelegate:self andText:defaultText forProperty:@"Add Location"];
        if(indexPath.row == 0){
            newcell.type = EditCellTypeLabel;
        }else if(indexPath.row == 2){
            newcell.type = EditCellTypeTextResult;
        
        }else{
        newcell.type = EditTextTableCellTypeNotEditable;
        }
        return newcell;

    }else{
    
        EditCell *newcell = [EditCell newCellWithDelegate:self andText:@"City ID" forProperty:@"City ID"];
        return newcell;

    }
    

}

-(BOOL)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(indexPath.section == 1 && indexPath.row == 0)
    {
        [self addLocationCellPressed];
    }
    return YES;
}

-(void)locationViewControllerFoundLocation:(CLLocationCoordinate2D)location{
    
    [self.coordinates setLongitude:[NSNumber numberWithFloat:location.longitude]];
    [self.coordinates setLatitude:[NSNumber numberWithFloat:location.latitude]];
    [self.coordinates addCoordinates:self.coordinates];
    [self.navigationController popViewControllerAnimated:YES];
    [self.tableView reloadData];

}

- (void)cell:(EditCell *)cell forProperty:(NSString *)property{

}


@end
