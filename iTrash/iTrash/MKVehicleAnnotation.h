//
//  MKVehicleAnnotation.h
//  iTrash
//
//  Created by biid on 25/4/15.
//  Copyright (c) 2015 shibboleth. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MKVehicleAnnotation : NSObject <MKAnnotation>

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

- (id)initWithLocation:(CLLocationCoordinate2D)location;
- (MKAnnotationView *)annotationView;

@end
