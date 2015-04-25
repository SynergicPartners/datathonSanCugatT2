//
//  MKContainerAnnotation.m
//  iTrash
//
//  Created by biid on 25/4/15.
//  Copyright (c) 2015 shibboleth. All rights reserved.
//

#import "MKContainerAnnotation.h"


@implementation MKContainerAnnotation

- (id)initWithId:(NSString*)containerId andLocation:(CLLocationCoordinate2D)location{
    self = [super init];
    
    if (self){
        _containerId = containerId;
        _coordinate = location;
    }
    return self;
}

- (MKAnnotationView *)annotationView
{
    MKAnnotationView *annotationView = [[MKAnnotationView alloc] initWithAnnotation:self reuseIdentifier:@"ContainerAnnotation"];
    annotationView.enabled = YES;
    annotationView.image = [UIImage imageNamed:@"Container"];
    
    return annotationView;
}

@end
