//
// Created by Stefan Kramreither on 2017-02-24.
// Copyright (c) 2017 Stefan Kramreither. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CompanyModel : NSObject

@property (nonatomic, copy) NSNumber *companyId;
@property (nonatomic, copy) NSNumber *addressId;
@property (nonatomic, copy) NSNumber *billingId;
@property (nonatomic, copy) NSDate *createdAt;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *logoPic;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSNumber *userId;

- (instancetype) initWithCompanyId:(NSNumber *) companyId
                         addressId:(NSNumber *) addressId
                         billingId:(NSNumber *) billingId
                          cratedAt:(NSDate *) createdAt
                       description:(NSString *) desc
                           logoPic:(NSString *) logoPic
                             phone:(NSString *) phone
                            userId:(NSNumber *) userId;

- (instancetype) initWithAddressId:(NSNumber *) addressId
                         billingId:(NSNumber *) billingId
                       description:(NSString *) desc
                           logoPic:(NSString *) logoPic
                             phone:(NSString *) phone
                            userId:(NSNumber *) userId;

- (instancetype) initWithJson:(NSData *) data;

@end