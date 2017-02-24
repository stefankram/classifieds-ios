//
// Created by Stefan Kramreither on 2017-02-23.
// Copyright (c) 2017 Stefan Kramreither. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AddressModel;

@interface AddressStore : NSObject

+ (void) createWithAddress:(AddressModel *) address
                 onSuccess:(void (^)(AddressModel *model)) success
                    onFail:(void (^)(NSString *error)) fail;

+ (void) findById:(unsigned long) addressId
        onSuccess:(void (^)(AddressModel *model)) success
           onFail:(void (^)(NSString *error)) fail;

@end