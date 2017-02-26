//
// Created by Stefan Kramreither on 2017-02-23.
// Copyright (c) 2017 Stefan Kramreither. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BillingModel;

@interface BillingStore : NSObject

+ (void) createBilling:(BillingModel *) billing
             onSuccess:(void (^)(BillingModel *model)) success
                onFail:(void (^)(NSString *error)) fail;

@end