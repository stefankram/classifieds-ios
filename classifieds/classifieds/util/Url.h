//
// Created by Stefan Kramreither on 2017-02-24.
// Copyright (c) 2017 Stefan Kramreither. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Url : NSObject

+ (NSURL *) createUser;

+ (NSURL *) obtainToken;

+ (NSURL *) refreshToken;

+ (NSURL *) createAddress;

+ (NSURL *) createBilling;

+ (NSURL *) createBuyer;

+ (NSURL *) findUserWithUsername:(NSString *) username;

+ (NSURL *) findBuyerWithUserId:(NSNumber *) userId;

+ (NSURL *) findItemWithName:(NSString *) name;

+ (NSURL *) createSearch;

+ (NSURL *) findAllSearchWithBuyerId:(NSNumber *) buyerId;

@end