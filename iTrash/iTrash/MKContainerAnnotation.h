//
//  MKContainerAnnotation.h
//  iTrash
//
//  Created by biid on 25/4/15.
//  Copyright (c) 2015 shibboleth. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MKContainerAnnotation : NSObject <MKAnnotation>

@property (nonatomic, strong, readonly) NSString* containerId;
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

- (id)initWithId:(NSString*)containerId andLocation:(CLLocationCoordinate2D)location;
- (MKAnnotationView *)annotationView;

@end
