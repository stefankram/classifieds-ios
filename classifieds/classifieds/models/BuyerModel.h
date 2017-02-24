//
// Created by Stefan Kramreither on 2017-02-23.
// Copyright (c) 2017 Stefan Kramreither. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BuyerModel : NSObject

@property (nonatomic) unsigned long buyerId;
@property (nonatomic) unsigned long addressId;
@property (nonatomic) unsigned long billingId;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *profilePic;
@property (nonatomic) unsigned long userId;

- (instancetype) initWithBuyerId:(unsigned long) buyerId
                       addressId:(unsigned long) addressId
                       billingId:(unsigned long) billingId
                           phone:(NSString *) phone
                      profilePic:(NSString *) profilePic
                          userId:(unsigned long) userId;

- (instancetype) initWithJson:(NSData *) data;

@end