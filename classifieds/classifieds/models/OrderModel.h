//
// Created by Stefan Kramreither on 2017-02-24.
// Copyright (c) 2017 Stefan Kramreither. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderModel : NSObject

@property (nonatomic, copy) NSNumber *orderId;
@property (nonatomic, copy) NSNumber *buyerId;
@property (nonatomic) BOOL completed;
@property (nonatomic, copy) NSDate *createdAt;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic) BOOL prepaid;
@property (nonatomic, copy) NSNumber *price;
@property (nonatomic, copy) NSDate *purchaseDate;
@property (nonatomic, copy) NSNumber *sellerId;

- (instancetype) initWithOrderId:(NSNumber *) orderId
                         buyerId:(NSNumber *) buyerId
                       completed:(BOOL) completed
                       createdAt:(NSDate *) createdAt
                     descripiton:(NSString *) desc
                         prepaid:(BOOL) prepaid
                           price:(NSNumber *) price
                    purchaseDate:(NSDate *) purchaseDate
                        sellerId:(NSNumber *) sellerId;

- (instancetype) initWithBuyerId:(NSNumber *) buyerId
                     descripiton:(NSString *) desc
                         prepaid:(BOOL) prepaid
                           price:(NSNumber *) price
                    purchaseDate:(NSDate *) purchaseDate
                        sellerId:(NSNumber *) sellerId;

- (instancetype) initWithJson:(NSData *) data;

@end