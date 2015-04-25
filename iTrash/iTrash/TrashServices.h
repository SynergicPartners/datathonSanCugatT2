//
//  TrashServices.h
//  iTrash
//
//  Created by biid on 25/4/15.
//  Copyright (c) 2015 shibboleth. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Container.h"

/**
 *  Block invoked on success of containers operation.
 *
 *  @param containers An NSArray of Container objects, with the details of the available containers..
 */
typedef void (^ContainersSuccessBlock)(NSArray *containers);

typedef void (^ContainerSuccessBlock)(Container *container);

typedef void (^ErrorBlock)(NSError *error);

@interface TrashServices : NSObject

@property (nonatomic, strong) NSString* baseUrl;

+ (TrashServices*) getInstance;

- (void) getContainersWithLatitude:(NSString*)latitude longitude:(NSString*)longitude distance:(NSString*)distance categories:(NSArray*)categories onSuccess:(ContainersSuccessBlock)onSuccess onError:(ErrorBlock)onError;

- (void) getContainerDetails:(NSString*)containerId onSuccess:(ContainerSuccessBlock)onSuccess onError:(ErrorBlock)onError;

@end
