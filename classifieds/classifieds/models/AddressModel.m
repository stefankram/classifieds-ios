//
// Created by Stefan Kramreither on 2017-02-23.
// Copyright (c) 2017 Stefan Kramreither. All rights reserved.
//

#import "AddressModel.h"
#import "Json.h"

@implementation AddressModel

- (instancetype) initWithAddressId:(unsigned long) addressId
                              city:(NSString *) city
                           country:(NSString *) country
                        postalCode:(NSString *) postalCode
                          province:(NSString *) province
                            street:(NSString *) street
{
    if (self = [super init])
    {
        self.addressId = addressId;
        self.city = city;
        self.country = country;
        self.postalCode = postalCode;
        self.province = province;
        self.street = street;
    }

    return self;
}

- (instancetype) initWithCity:(NSString *) city
                      country:(NSString *) country
                   postalCode:(NSString *) postalCode
                     province:(NSString *) province
                       street:(NSString *) street
{
    return [self initWithAddressId:nil
                              city:city
                           country:country
                        postalCode:postalCode
                          province:province
                            street:street];
}

- (instancetype) initWithJson:(NSData *) data
{
    NSDictionary *json = [Json parseJsonObject:data];

    if (json)
    {
        return [self initWithAddressId:[json[@"id"] unsignedLongValue]
                                  city:json[@"city"]
                               country:json[@"country"]
                            postalCode:json[@"postal_code"]
                              province:json[@"province"]
                                street:json[@"street"]];
    }
    else
    {
        return nil;
    }
}

@end