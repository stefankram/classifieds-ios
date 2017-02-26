//
// Created by Stefan Kramreither on 2017-02-24.
// Copyright (c) 2017 Stefan Kramreither. All rights reserved.
//

#import "Url.h"

@implementation Url

+ (NSURL *) createUser
{
    return [NSURL URLWithString:@"http://localhost:8000/api/user/create/"];
}

+ (NSURL *) obtainToken
{
    return [NSURL URLWithString:@"http://localhost:8000/api/token/obtain/"];
}

+ (NSURL *) refreshToken
{
    return [NSURL URLWithString:@"http://localhost:8000/api/token/refresh/"];
}

+ (NSURL *) createAddress
{
    return [NSURL URLWithString:@"http://localhost:8000/api/address/create/"];
}

+ (NSURL *) createBilling
{
    return [NSURL URLWithString:@"http://localhost:8000/api/billing/create/"];
}

+ (NSURL *) createBuyer
{
    return [NSURL URLWithString:@"http://localhost:8000/api/buyer/create/"];
}

+ (NSURL *) findUserWithUsername:(NSString *) username
{
    return [NSURL URLWithString:[NSString
            stringWithFormat:@"http://localhost:8000/api/user/find/%@/", username]];
}

+ (NSURL *) findBuyerWithUserId:(NSNumber *) userId
{
    return [NSURL URLWithString:[NSString
            stringWithFormat:@"http://localhost:8000/api/buyer/find/%@/", userId]];
}

+ (NSURL *) findItemWithName:(NSString *) name
{
    return [NSURL URLWithString:[NSString
            stringWithFormat:@"http://localhost:8000/api/item/find/%@/", name]];
}

+ (NSURL *) createSearch
{
    return [NSURL URLWithString:@"http://localhost:8000/api/search/create/"];
}

+ (NSURL *) findAllSearchWithBuyerId:(NSNumber *) buyerId
{
    return [NSURL URLWithString:[NSString
            stringWithFormat:@"http://localhost:8000/api/search/find/all/%@/", buyerId]];
}

@end