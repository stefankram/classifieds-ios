//
// Created by Stefan Kramreither on 2017-02-24.
// Copyright (c) 2017 Stefan Kramreither. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SellerModel : NSObject

@property (nonatomic, copy) NSNumber *sellerId;
@property (nonatomic, copy) NSNumber *addressId;
@property (nonatomic, copy) NSNumber *billingId;
@property (nonatomic, copy) NSNumber *companyId;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *profilePic;
@property (nonatomic, copy) NSNumber *userId;

- (instancetype) initWithSellerId:(NSNumber *) sellerId
                        addressId:(NSNumber *) addressId
                        billingId:(NSNumber *) billingId
                        companyId:(NSNumber *) companyId
                      description:(NSString *) desc
                            phone:(NSString *) phone
                       profilePic:(NSString *) profilePic
                           userId:(NSNumber *) userId;

- (instancetype) initWithAddressId:(NSNumber *) addressId
                         billingId:(NSNumber *) billingId
                         companyId:(NSNumber *) companyId
                       description:(NSString *) desc
                             phone:(NSString *) phone
                        profilePic:(NSString *) profilePic
                            userId:(NSNumber *) userId;

- (instancetype) initWithJson:(NSData *) data;

@end