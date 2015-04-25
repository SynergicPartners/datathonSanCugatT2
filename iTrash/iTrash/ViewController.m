//
//  ViewController.m
//  iTrash
//
//  Created by biid on 24/4/15.
//  Copyright (c) 2015 shibboleth. All rights reserved.
//

#import "ViewController.h"
#import "MBProgressHUD.h"
#import <CoreLocation/CoreLocation.h>
#import "TrashServices.h"
#import "ContainersMapViewController.h"

@interface ViewController () <CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager* locationManager;

@property (nonatomic, strong) CLLocation* location;

@property (nonatomic, strong) NSArray* containers;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
        [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager startUpdatingLocation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)radioSliderValueChanged:(id)sender {
    // Set the label text to the value of the slider as it changes
    self.radioLabel.text = [NSString stringWithFormat:@"%d m", (int)self.radioSlider.value];
}

- (void)showAlert:(NSString*)title withMessage:(NSString*)message{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                      message:message
                                                     delegate:nil
                                            cancelButtonTitle:@"OK"
                                            otherButtonTitles:nil];
    
    [alert show];
}

- (IBAction)searchClicked:(id)sender
{
    if (self.location != nil){
         //[self performSegueWithIdentifier:@"Containers" sender:sender];
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [[TrashServices getInstance] getContainersWithLatitude:[NSString stringWithFormat:@"%f", self.location.coordinate.latitude] longitude:[NSString stringWithFormat:@"%f", self.location.coordinate.longitude] distance:[NSString stringWithFormat:@"%d", (int)self.radioSlider.value] categories:nil
        onSuccess:^(NSArray *containers) {
            NSLog(@"Success: %@", containers);
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            self.containers = containers;
            [self performSegueWithIdentifier:@"Containers" sender:sender];
        } onError:^(NSError *error) {
            NSLog(@"Error: %@", error.description);
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            [self showAlert:@"Error" withMessage:@"No s'han pogut obtenir els contenidors. Si us plau torni a intentar."];
        }];
    }else{
        [self showAlert:@"Error" withMessage:@"No s'ha pogut obtenir la localització. Si us plau comprovi l'autorització."];
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    self.location = newLocation;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"Containers"])
    {
        ContainersMapViewController* containersVC = [segue destinationViewController];
        containersVC.containers = self.containers;
    }
}

@end
