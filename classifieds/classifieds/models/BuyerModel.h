//
// Created by Stefan Kramreither on 2017-02-23.
// Copyright (c) 2017 Stefan Kramreither. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BuyerModel : NSObject

@property (nonatomic, copy) NSNumber *buyerId;
@property (nonatomic, copy) NSNumber *addressId;
@property (nonatomic, copy) NSNumber *billingId;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *profilePic;
@property (nonatomic, copy) NSNumber *userId;

- (instancetype) initWithBuyerId:(NSNumber *) buyerId
                       addressId:(NSNumber *) addressId
                       billingId:(NSNumber *) billingId
                           phone:(NSString *) phone
                      profilePic:(NSString *) profilePic
                          userId:(NSNumber *) userId;

- (instancetype) initWithAddressId:(NSNumber *) addressId
                         billingId:(NSNumber *) billingId
                             phone:(NSString *) phone
                        profilePic:(NSString *) profilePic
                            userId:(NSNumber *) userId;

- (instancetype) initWithJson:(NSData *) data;

@end