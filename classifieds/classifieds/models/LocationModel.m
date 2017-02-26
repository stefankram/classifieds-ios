//
// Created by Stefan Kramreither on 2017-02-24.
// Copyright (c) 2017 Stefan Kramreither. All rights reserved.
//

#import "LocationModel.h"
#import "Json.h"

@implementation LocationModel

- (instancetype) initWithLocationId:(NSNumber *) locationId
                           latitude:(NSNumber *) latitude
                          longitude:(NSNumber *) longitude
                           sellerId:(NSNumber *) sellerId
{
    if (self = [super init])
    {
        self.locationId = locationId;
        self.latitude = latitude;
        self.longitude = longitude;
        self.sellerId = sellerId;
    }

    return self;
}

- (instancetype) initWithLatitude:(NSNumber *) latitude
                        longitude:(NSNumber *) longitude
                         sellerId:(NSNumber *) sellerId
{
    return [self initWithLocationId:nil
                           latitude:latitude
                          longitude:longitude
                           sellerId:sellerId];
}

- (instancetype) initWithJson:(NSData *) data
{
    NSDictionary *json = [Json parseJsonObject:data];

    if (json)
    {
        return [self initWithLocationId:json[@"id"]
                               latitude:json[@"latitude"]
                              longitude:json[@"longitude"]
                               sellerId:json[@"seller_id"]];
    }
    else
    {
        return nil;
    }
}

- (NSString *) description
{
    return [[NSString alloc] initWithFormat:@"%@, %@, %@, %@",
                                            self.locationId,
                                            self.latitude,
                                            self.longitude,
                                            self.sellerId];
}

@end