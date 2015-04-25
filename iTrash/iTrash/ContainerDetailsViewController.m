//
//  ContainerDetailsViewController.m
//  iTrash
//
//  Created by biid on 25/4/15.
//  Copyright (c) 2015 shibboleth. All rights reserved.
//

#import "ContainerDetailsViewController.h"
#import "MKContainerAnnotation.h"
#import "MKVehicleAnnotation.h"

@interface ContainerDetailsViewController ()

@property (nonatomic) int secondsLeft;
@property (nonatomic, strong) NSTimer* timer;

@end

@implementation ContainerDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mapView.delegate = self;
    // Do any additional setup after loading the view.
    self.secondsLeft = self.container.estimatedTimeRemaining;
    [self updateCountdown];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateCountdown) userInfo:nil repeats: YES];
    
    if (self.container != nil){
        MKContainerAnnotation * containerAnnotation =[[MKContainerAnnotation alloc] initWithId:self.container.containerId andLocation:self.container.containerLocation];
        MKVehicleAnnotation * vehicleAnnotation = [[MKVehicleAnnotation alloc] initWithLocation:self.container.lastVehicleLocation];
        [self.mapView addAnnotation:vehicleAnnotation];
    }
    
    CLLocation *locContainer = [[CLLocation alloc] initWithLatitude:self.container.containerLocation.latitude longitude:self.container.containerLocation.longitude];
    CLLocation *locVehicle = [[CLLocation alloc] initWithLatitude:self.container.lastVehicleLocation.latitude longitude:self.container.lastVehicleLocation.longitude];
    // This is a diag distance
    CLLocationDistance meters = [locContainer getDistanceFrom:locVehicle];
    
    MKCoordinateRegion region;
    region.center.latitude = (self.container.containerLocation.latitude + self.container.lastVehicleLocation.latitude) / 2.0;
    region.center.longitude = (self.container.containerLocation.longitude + self.container.lastVehicleLocation.longitude) / 2.0;
    region.span.latitudeDelta = meters / 111319.5;
    region.span.longitudeDelta = 0.0;
    
    MKCoordinateRegion savedRegion = [_mapView regionThatFits:region];
    [_mapView setRegion:savedRegion animated:YES];
}

-(void) updateCountdown {
    int hours, minutes, seconds;
    self.secondsLeft--;
    hours = self.secondsLeft / 3600;
    minutes = (self.secondsLeft % 3600) / 60;
    seconds = (self.secondsLeft %3600) % 60;
    self.countDownLabel.text = [NSString stringWithFormat:@"-%02d:%02d:%02d", hours, minutes, seconds];
}


- (MKAnnotationView*)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    if ([annotation isKindOfClass:[MKContainerAnnotation class]]){
        MKContainerAnnotation * customAnnot = (MKContainerAnnotation *)annotation;
        
        MKAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:@"ContainerAnnotation"];
        
        if (annotationView == nil){
            annotationView = customAnnot.annotationView;
            
        }else{
            annotationView.annotation = annotation;
        }
        annotationView.canShowCallout = NO;
        return annotationView;
    }else if ([annotation isKindOfClass:[MKVehicleAnnotation class]]){
        MKVehicleAnnotation * customAnnot = (MKVehicleAnnotation *)annotation;
        
        MKAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:@"VehicleAnnotation"];
        
        if (annotationView == nil){
            annotationView = customAnnot.annotationView;
            
        }else{
            annotationView.annotation = annotation;
        }
        annotationView.canShowCallout = NO;
        return annotationView;
    }else{
        return nil;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
