//
// Created by Stefan Kramreither on 2017-02-23.
// Copyright (c) 2017 Stefan Kramreither. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BuyerModel;

@interface BuyerStore : NSObject

+ (void) createWithAddressId:(unsigned long) addressId
                   billingId:(unsigned long) billingId
                       phone:(NSString *) phone
                  profilePic:(NSString *) profilePic
                      userId:(unsigned long) userId
                   onSuccess:(void (^)(unsigned long buyerId)) success
                      onFail:(void (^)(NSString *error)) fail;

+ (void) findByUserId:(unsigned long) userId
            onSuccess:(void (^)(BuyerModel *buyer)) success
               onFail:(void (^)(NSString *error)) fail;

@end