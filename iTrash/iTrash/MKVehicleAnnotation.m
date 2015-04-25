//
//  MKVehicleAnnotation.m
//  iTrash
//
//  Created by biid on 25/4/15.
//  Copyright (c) 2015 shibboleth. All rights reserved.
//

#import "MKVehicleAnnotation.h"

@implementation MKVehicleAnnotation

- (id)initWithLocation:(CLLocationCoordinate2D)location{
    self = [super init];
    
    if (self){
        _coordinate = location;
    }
    return self;
}

- (MKAnnotationView *)annotationView
{
    MKAnnotationView *annotationView = [[MKAnnotationView alloc] initWithAnnotation:self reuseIdentifier:@"VehicleAnnotation"];
    annotationView.enabled = YES;
    annotationView.image = [UIImage imageNamed:@"Vehicle"];
    
    return annotationView;
}

@end
