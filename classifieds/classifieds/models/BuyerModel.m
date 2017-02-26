//
// Created by Stefan Kramreither on 2017-02-23.
// Copyright (c) 2017 Stefan Kramreither. All rights reserved.
//

#import "BuyerModel.h"
#import "Json.h"

@implementation BuyerModel

- (instancetype) initWithBuyerId:(NSNumber *) buyerId
                       addressId:(NSNumber *) addressId
                       billingId:(NSNumber *) billingId
                           phone:(NSString *) phone
                      profilePic:(NSString *) profilePic
                          userId:(NSNumber *) userId
{
    if (self = [super init])
    {
        self.buyerId = buyerId;
        self.addressId = addressId;
        self.billingId = billingId;
        self.phone = phone;
        self.profilePic = profilePic;
        self.userId = userId;
    }

    return self;
}

- (instancetype) initWithAddressId:(NSNumber *) addressId
                         billingId:(NSNumber *) billingId
                             phone:(NSString *) phone
                        profilePic:(NSString *) profilePic
                            userId:(NSNumber *) userId
{
    return [self initWithBuyerId:nil
                       addressId:addressId
                       billingId:billingId
                           phone:phone
                      profilePic:profilePic
                          userId:userId];
}

- (instancetype) initWithJson:(NSData *) data
{
    NSDictionary *json = [Json parseJsonObject:data];

    if (json)
    {
        return [self initWithBuyerId:json[@"id"]
                           addressId:json[@"address_id"]
                           billingId:json[@"billing_id"]
                               phone:json[@"phone"]
                          profilePic:json[@"profile_pic"]
                              userId:json[@"user_id"]];
    }
    else
    {
        return nil;
    }
}

- (NSString *) description
{
    return [[NSString alloc] initWithFormat:@"%@, %@, %@, %@, %@, %@",
                                            self.buyerId,
                                            self.addressId,
                                            self.billingId,
                                            self.phone,
                                            self.profilePic,
                                            self.userId];
}

@end