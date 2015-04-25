//
//  ContainersMapViewController.m
//  iTrash
//
//  Created by biid on 25/4/15.
//  Copyright (c) 2015 shibboleth. All rights reserved.
//

#import "ContainersMapViewController.h"
#import "MKContainerAnnotation.h"
#import "Container.h"
#import "MBProgressHUD.h"
#import "TrashServices.h"
#import "ContainerDetailsViewController.h"

@interface ContainersMapViewController ()

@property (nonatomic, strong) Container * container;

@end

@implementation ContainersMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _mapView.delegate = self;
    _mapView.showsUserLocation = YES;
    
    
    if (self.containers != nil && [self.containers count] > 0){
        for (Container* container in self.containers){
            MKContainerAnnotation * containerAnnotation =[[MKContainerAnnotation alloc] initWithId:container.containerId andLocation:container.containerLocation];
            [self.mapView addAnnotation:containerAnnotation];
        }
    }
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
    }else{
        return nil;
    }
}

- (void)showAlert:(NSString*)title withMessage:(NSString*)message{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    
    [alert show];
}

-(void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[TrashServices getInstance] getContainerDetails:((MKContainerAnnotation*)view.annotation).containerId onSuccess:^(Container *container) {
        NSLog(@"Success: %@", container);
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        self.container = container;
        [self performSegueWithIdentifier:@"ContainerDetail" sender:self];
    } onError:^(NSError *error) {
        NSLog(@"Error: %@", error.description);
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [self showAlert:@"Error" withMessage:@"No s'han pogut obtenir informació del contenidor. Si us plau torni a intentar"];
    }];
}

- (void)mapView:(MKMapView *)mapView
didUpdateUserLocation:
(MKUserLocation *)userLocation
{
    CLLocationCoordinate2D coord = self.mapView.userLocation.location.coordinate;
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coord, 600.0, 600.0);
    [self.mapView setRegion:region animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"ContainerDetail"])
    {
        ContainerDetailsViewController* containerDetailsVC = [segue destinationViewController];
        containerDetailsVC.container = self.container;
    }
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
