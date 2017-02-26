//
// Created by Stefan Kramreither on 2017-02-24.
// Copyright (c) 2017 Stefan Kramreither. All rights reserved.
//

#import "CompanyModel.h"
#import "Json.h"

@implementation CompanyModel

- (instancetype) initWithCompanyId:(NSNumber *) companyId
                         addressId:(NSNumber *) addressId
                         billingId:(NSNumber *) billingId
                          cratedAt:(NSDate *) createdAt
                       description:(NSString *) desc
                           logoPic:(NSString *) logoPic
                             phone:(NSString *) phone
                            userId:(NSNumber *) userId
{
    if (self = [super init])
    {
        self.companyId = companyId;
        self.addressId = addressId;
        self.billingId = billingId;
        self.createdAt = createdAt;
        self.desc = desc;
        self.logoPic = logoPic;
        self.phone = phone;
        self.userId = userId;
    }

    return self;
}

- (instancetype) initWithAddressId:(NSNumber *) addressId
                         billingId:(NSNumber *) billingId
                       description:(NSString *) desc
                           logoPic:(NSString *) logoPic
                             phone:(NSString *) phone
                            userId:(NSNumber *) userId
{
    return [self initWithCompanyId:nil
                         addressId:addressId
                         billingId:billingId
                          cratedAt:nil
                       description:desc
                           logoPic:logoPic
                             phone:phone
                            userId:userId];
}

- (instancetype) initWithJson:(NSData *) data
{
    NSDictionary *json = [Json parseJsonObject:data];

    if (json)
    {
        return [self initWithCompanyId:json[@"id"]
                             addressId:json[@"address_id"]
                             billingId:json[@"billing_id"]
                              cratedAt:json[@"created_at"]
                           description:json[@"description"]
                               logoPic:json[@"logo_pic"]
                                 phone:json[@"phone"]
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
                                            self.companyId,
                                            self.addressId,
                                            self.billingId,
                                            self.createdAt,
                                            self.desc,
                                            self.logoPic,
                                            self.phone,
                                            self.userId];
}

@end