//
// Created by Stefan Kramreither on 2017-02-24.
// Copyright (c) 2017 Stefan Kramreither. All rights reserved.
//

#import "SellerModel.h"
#import "Json.h"

@implementation SellerModel

- (instancetype) initWithSellerId:(NSNumber *) sellerId
                        addressId:(NSNumber *) addressId
                        billingId:(NSNumber *) billingId
                        companyId:(NSNumber *) companyId
                      description:(NSString *) desc
                            phone:(NSString *) phone
                       profilePic:(NSString *) profilePic
                           userId:(NSNumber *) userId
{
    if (self = [super init])
    {
        self.sellerId = sellerId;
        self.addressId = addressId;
        self.billingId = billingId;
        self.companyId = companyId;
        self.desc = desc;
        self.phone = phone;
        self.profilePic = profilePic;
        self.userId = userId;
    }

    return self;
}

- (instancetype) initWithAddressId:(NSNumber *) addressId
                         billingId:(NSNumber *) billingId
                         companyId:(NSNumber *) companyId
                       description:(NSString *) desc
                             phone:(NSString *) phone
                        profilePic:(NSString *) profilePic
                            userId:(NSNumber *) userId
{
    return [self initWithSellerId:nil
                        addressId:addressId
                        billingId:billingId
                        companyId:companyId
                      description:desc
                            phone:phone
                       profilePic:profilePic
                           userId:userId];
}

- (instancetype) initWithJson:(NSData *) data
{
    NSDictionary *json = [Json parseJsonObject:data];

    if (json)
    {
        return [self initWithSellerId:json[@"id"]
                            addressId:json[@"address_id"]
                            billingId:json[@"billing_id"]
                            companyId:json[@"company_id"]
                          description:json[@"description"]
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
    return [[NSString alloc] initWithFormat:@"%@, %@, %@, %@, %@, %@, %@, %@",
                                            self.sellerId,
                                            self.addressId,
                                            self.billingId,
                                            self.companyId,
                                            self.desc,
                                            self.phone,
                                            self.profilePic,
                                            self.userId];
}

@end