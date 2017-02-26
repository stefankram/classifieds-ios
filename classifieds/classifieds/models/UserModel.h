//
// Created by Stefan Kramreither on 2017-02-24.
// Copyright (c) 2017 Stefan Kramreither. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject

@property (nonatomic, copy) NSNumber *userId;
@property (nonatomic, copy) NSDate *dateJoined;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *firstName;
@property (nonatomic) BOOL isActive;
@property (nonatomic, copy) NSString *lastName;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *username;

- (instancetype) initWithUserId:(NSNumber *) userId
                     dateJoined:(NSDate *) dateJoined
                          email:(NSString *) email
                      firstName:(NSString *) firstName
                       isActive:(BOOL) isActive
                       lastName:(NSString *) lastName
                       password:(NSString *) password
                       username:(NSString *) username;

- (instancetype) initWithEmail:(NSString *) email
                     firstName:(NSString *) firstName
                      lastName:(NSString *) lastName
                      password:(NSString *) password
                      username:(NSString *) username;

- (instancetype) initWithJson:(NSData *) data;

@end