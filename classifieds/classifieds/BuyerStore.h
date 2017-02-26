//
// Created by Stefan Kramreither on 2017-02-23.
// Copyright (c) 2017 Stefan Kramreither. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BuyerModel;

@interface BuyerStore : NSObject

+ (void) createBuyer:(BuyerModel *) buyer
           onSuccess:(void (^)(BuyerModel *model)) success
              onFail:(void (^)(NSString *error)) fail;

+ (void) findByUserId:(NSNumber *) userId
            onSuccess:(void (^)(BuyerModel *model)) success
               onFail:(void (^)(NSString *error)) fail;

@end