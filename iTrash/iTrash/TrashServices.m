//
//  TrashServices.m
//  iTrash
//
//  Created by biid on 25/4/15.
//  Copyright (c) 2015 shibboleth. All rights reserved.
//

#import "TrashServices.h"
#import "AFNetworking.h"
#import "Container.h"

// default values
const NSString* kTrashDefault_BaseURL = @"http://www.swlab.es";

const NSString* URL_CONTAINERS = @"/cs/containers.php";
const NSString* URL_CONTAINER = @"/cs/container.php";

const NSString* CONTAINER_ID = @"id";
const NSString* LATITUDE = @"latitud";
const NSString* LONGITUDE = @"longitud";
const NSString* CONTAINER_LATITUDE = @"cont_lat";
const NSString* CONTAINER_LONGITUDE = @"cont_lon";
const NSString* CONTAINER_TIME = @"container_hora";
const NSString* VEHICLE_LATITUDE = @"camion_lat";
const NSString* VEHICLE_LONGITUDE = @"camion_lon";
const NSString* VEHICLE_TIME = @"camion_hora";

@interface TrashServices ()

@property (nonatomic, strong) AFHTTPSessionManager * sessionManager;

@end

@implementation TrashServices

@synthesize sessionManager;

static TrashServices* sharedInstance = nil;

+ (TrashServices*) getInstance
{
    if (sharedInstance == nil){
        sharedInstance = [[super allocWithZone:NULL] init];
        [sharedInstance setBaseUrl:(NSString*)kTrashDefault_BaseURL];
    }
    return sharedInstance;
}

- (AFHTTPSessionManager *)sessionManager{
    if (sessionManager == nil)
    {
        NSURL *url = [NSURL URLWithString:self.baseUrl];
        NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:url sessionConfiguration:sessionConfiguration];
        sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
    }
    return sessionManager;
}

- (void) getContainersWithLatitude:(NSString*)latitude longitude:(NSString*)longitude distance:(NSString*)distance categories:(NSArray*)categories onSuccess:(ContainersSuccessBlock)onSuccess onError:(ErrorBlock)onError{
    
    NSMutableString* url = [NSMutableString stringWithFormat:@"%@?latitud=%@&longitud=%@&radio=%@",URL_CONTAINERS, latitude, longitude, distance];
    /*if (categories != nil && [categories count] > 0){
        for (NSString* category in categories){
            [url appendFormat:@"?cat[]=%@", category];
        }
    }*/
    NSURLSessionDataTask *dataTask = [self.sessionManager GET:url parameters:nil
    success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"Response: %@", responseObject);
        NSArray * jsonArray = (NSArray*) responseObject;
        NSMutableArray * resultArray = [NSMutableArray array];
        for (NSDictionary* jsonContainer in jsonArray){
            Container* container = [[Container alloc] init];
            container.containerId = [jsonContainer objectForKey:CONTAINER_ID];
            container.containerLocation =  CLLocationCoordinate2DMake([[jsonContainer objectForKey:LATITUDE] doubleValue], [[jsonContainer objectForKey:LONGITUDE] doubleValue]);
            [resultArray addObject:container];
        }
        onSuccess(resultArray);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Error: %@", error);
        onError(error);
    }];
    [dataTask resume];
}

- (void) getContainerDetails:(NSString*)containerId onSuccess:(ContainerSuccessBlock)onSuccess onError:(ErrorBlock)onError{
    NSMutableString* url = [NSMutableString stringWithFormat:@"%@?id=%@",URL_CONTAINER, containerId];
    NSURLSessionDataTask *dataTask = [self.sessionManager GET:url parameters:nil
    success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"Response: %@", responseObject);
        NSDictionary * jsonDictionary = (NSDictionary*) responseObject;
        if (jsonDictionary != nil && [jsonDictionary count] > 0){
            Container* container = [[Container alloc] init];
            container.containerId = containerId;
            container.containerLocation =  CLLocationCoordinate2DMake([[jsonDictionary objectForKey:CONTAINER_LATITUDE] doubleValue], [[jsonDictionary objectForKey:CONTAINER_LONGITUDE] doubleValue]);
            container.lastVehicleLocation = CLLocationCoordinate2DMake([[jsonDictionary objectForKey:VEHICLE_LATITUDE] doubleValue], [[jsonDictionary objectForKey:VEHICLE_LONGITUDE] doubleValue]);
            container.vehicleLastLocationTime = [jsonDictionary objectForKey:VEHICLE_TIME];
            container.containerPickupTime = [jsonDictionary objectForKey:CONTAINER_TIME];
            container.estimatedTimeRemaining = [self calculateTimeRemaining:container];
            onSuccess(container);
        }else{
            onSuccess(nil);
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Error: %@", error);
        onError(error);
    }];
    [dataTask resume];
}

- (double)calculateTimeRemaining:(Container*)container
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss Z"];
    NSDate *dateContenedor = [dateFormat dateFromString:container.containerPickupTime];
    NSDate *dateCamion = [dateFormat dateFromString:container.vehicleLastLocationTime];
    
    NSTimeInterval diff = [dateContenedor timeIntervalSinceDate:dateCamion];
    double res = (double)diff;
    double factor = 1814400000;
    if(res<0){
        res +=factor;
    }
    
    
    return res;
}

@end
