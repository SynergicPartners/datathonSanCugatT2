//
//  Container.h
//  iTrash
//
//  Created by biid on 25/4/15.
//  Copyright (c) 2015 shibboleth. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface Container : NSObject

@property (nonatomic, strong) NSString* containerId;

@property (nonatomic) CLLocationCoordinate2D containerLocation;

@property (nonatomic, strong) NSString* containerPickupTime;

@property (nonatomic) CLLocationCoordinate2D lastVehicleLocation;

@property (nonatomic, strong) NSString* vehicleLastLocationTime;

@property (nonatomic) double estimatedTimeRemaining;

@end
