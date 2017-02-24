//
// Created by Stefan Kramreither on 2017-02-23.
// Copyright (c) 2017 Stefan Kramreither. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddressModel : NSObject

@property (nonatomic) unsigned long addressId;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *country;
@property (nonatomic, copy) NSString *postalCode;
@property (nonatomic, copy) NSString *province;
@property (nonatomic, copy) NSString *street;

- (instancetype) initWithAddressId:(unsigned long) addressId
                              city:(NSString *) city
                           country:(NSString *) country
                        postalCode:(NSString *) postalCode
                          province:(NSString *) province
                            street:(NSString *) street;

- (instancetype) initWithCity:(NSString *) city
                      country:(NSString *) country
                   postalCode:(NSString *) postalCode
                     province:(NSString *) province
                       street:(NSString *) street;

- (instancetype) initWithJson:(NSData *) data;

@end