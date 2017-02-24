//
// Created by Stefan Kramreither on 2017-02-23.
// Copyright (c) 2017 Stefan Kramreither. All rights reserved.
//

#import "BuyerModel.h"
#import "Json.h"

@implementation BuyerModel

- (instancetype) initWithBuyerId:(unsigned long) buyerId
                       addressId:(unsigned long) addressId
                       billingId:(unsigned long) billingId
                           phone:(NSString *) phone
                      profilePic:(NSString *) profilePic
                          userId:(unsigned long) userId
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

- (instancetype) initWithJson:(NSData *) data
{
    NSDictionary *json = [Json parseJsonObject:data];

    if (json)
    {
        return [self initWithBuyerId:[json[@"id"] unsignedLongValue]
                           addressId:[json[@"address_id"] unsignedLongValue]
                           billingId:[json[@"billing_id"] unsignedLongValue]
                               phone:json[@"phone"]
                          profilePic:json[@"profile_pic"]
                              userId:[json[@"user_id"] unsignedLongValue]];
    }
    else
    {
        return nil;
    }
}

- (NSString *) description
{
    return [[NSString alloc] initWithFormat:@"%lu, %lu, %lu, %@, %@, %lu",
                                            self.buyerId,
                                            self.addressId,
                                            self.billingId,
                                            self.phone,
                                            self.profilePic,
                                            self.userId];
}

@end