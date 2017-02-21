//
// Created by Stefan Kramreither on 2017-02-20.
// Copyright (c) 2017 Stefan Kramreither. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Token : NSObject

+ (NSURLRequest *) obtainWithUsername:(NSString *) username
                             password:(NSString *) password;

+ (NSURLRequest *) refreshToken:(NSString *) token;

@end