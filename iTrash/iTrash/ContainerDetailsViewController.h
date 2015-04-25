//
//  ContainerDetailsViewController.h
//  iTrash
//
//  Created by biid on 25/4/15.
//  Copyright (c) 2015 shibboleth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Container.h"
#import <MapKit/MapKit.h>

@interface ContainerDetailsViewController : UIViewController <MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic, strong) Container * container;
@property (weak, nonatomic) IBOutlet UILabel *countDownLabel;

@end
