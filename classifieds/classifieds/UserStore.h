//
// Created by Stefan Kramreither on 2017-02-24.
// Copyright (c) 2017 Stefan Kramreither. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UserModel;

@interface UserStore : NSObject

+ (void) createUser:(UserModel *) user
          onSuccess:(void (^)(UserModel *model)) success
             onFail:(void (^)(NSString *error)) fail;

+ (void) findByUsername:(NSString *) username
              onSuccess:(void (^)(UserModel *model)) success
                 onFail:(void (^)(NSString *error)) fail;

@end