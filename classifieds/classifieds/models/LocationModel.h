//
// Created by Stefan Kramreither on 2017-02-24.
// Copyright (c) 2017 Stefan Kramreither. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocationModel : NSObject

@property (nonatomic, copy) NSNumber *locationId;
@property (nonatomic, copy) NSNumber *latitude;
@property (nonatomic, copy) NSNumber *longitude;
@property (nonatomic, copy) NSNumber *sellerId;

- (instancetype) initWithLocationId:(NSNumber *) locationId
                           latitude:(NSNumber *) latitude
                          longitude:(NSNumber *) longitude
                           sellerId:(NSNumber *) sellerId;

- (instancetype) initWithLatitude:(NSNumber *) latitude
                        longitude:(NSNumber *) longitude
                         sellerId:(NSNumber *) sellerId;

- (instancetype) initWithJson:(NSData *) data;

@end