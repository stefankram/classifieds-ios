//
// Created by Stefan Kramreither on 2017-02-20.
// Copyright (c) 2017 Stefan Kramreither. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UserModel;

@interface Token : NSObject

+ (void) obtainWithUsername:(NSString *) username
                   password:(NSString *) password
                  onSuccess:(void (^)(NSString *token)) success
                     onFail:(void (^)(NSString *error)) fail;

+ (void) refreshWithToken:(NSString *) token
                onSuccess:(void (^)(NSString *newToken)) success
                   onFail:(void (^)(NSString *error)) fail;

+ (NSString *) authHeader;

@end