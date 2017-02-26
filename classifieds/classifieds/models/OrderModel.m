//
// Created by Stefan Kramreither on 2017-02-24.
// Copyright (c) 2017 Stefan Kramreither. All rights reserved.
//

#import "OrderModel.h"
#import "Json.h"

@implementation OrderModel

- (instancetype) initWithOrderId:(NSNumber *) orderId
                         buyerId:(NSNumber *) buyerId
                       completed:(BOOL) completed
                       createdAt:(NSDate *) createdAt
                     descripiton:(NSString *) desc
                         prepaid:(BOOL) prepaid
                           price:(NSNumber *) price
                    purchaseDate:(NSDate *) purchaseDate
                        sellerId:(NSNumber *) sellerId
{
    if (self = [super init])
    {
        self.orderId = orderId;
        self.buyerId = buyerId;
        self.completed = completed;
        self.createdAt = createdAt;
        self.desc = desc;
        self.prepaid = prepaid;
        self.price = price;
        self.purchaseDate = purchaseDate;
        self.sellerId = sellerId;
    }

    return self;
}

- (instancetype) initWithBuyerId:(NSNumber *) buyerId
                     descripiton:(NSString *) desc
                         prepaid:(BOOL) prepaid
                           price:(NSNumber *) price
                    purchaseDate:(NSDate *) purchaseDate
                        sellerId:(NSNumber *) sellerId
{
    return [self initWithOrderId:nil
                         buyerId:buyerId
                       completed:NO
                       createdAt:nil
                     descripiton:desc
                         prepaid:prepaid
                           price:price
                    purchaseDate:purchaseDate
                        sellerId:sellerId];
}

- (instancetype) initWithJson:(NSData *) data
{
    NSDictionary *json = [Json parseJsonObject:data];

    if (json)
    {
        return [self initWithOrderId:json[@"id"]
                             buyerId:json[@"buyer_id"]
                           completed:[json[@"completed"] boolValue]
                           createdAt:json[@"created_at"]
                         descripiton:json[@"description"]
                             prepaid:[json[@"prepaid"] boolValue]
                               price:json[@"price"]
                        purchaseDate:json[@"purchase_date"]
                            sellerId:json[@"seller_id"]];
    }
    else
    {
        return nil;
    }
}

- (NSString *) description
{
    return [[NSString alloc] initWithFormat:@"%@, %@, %@, %@, %@, %@, %@, %@, %@",
                                            self.orderId,
                                            self.buyerId,
                                            self.completed ? @"YES" : @"NO",
                                            self.createdAt,
                                            self.desc,
                                            self.prepaid ? @"YES" : @"NO",
                                            self.price,
                                            self.purchaseDate,
                                            self.sellerId];
}

@end