//
//  ContainersMapViewController.h
//  iTrash
//
//  Created by biid on 25/4/15.
//  Copyright (c) 2015 shibboleth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface ContainersMapViewController : UIViewController
<MKMapViewDelegate>

@property (strong, nonatomic) IBOutlet MKMapView *mapView;

@property (nonatomic, strong) NSArray * containers;

@end
