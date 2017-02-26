//
// Created by Stefan Kramreither on 2017-02-24.
// Copyright (c) 2017 Stefan Kramreither. All rights reserved.
//

#import "UserModel.h"
#import "Json.h"

@implementation UserModel

- (instancetype) initWithUserId:(NSNumber *) userId
                     dateJoined:(NSDate *) dateJoined
                          email:(NSString *) email
                      firstName:(NSString *) firstName
                       isActive:(BOOL) isActive
                       lastName:(NSString *) lastName
                       password:(NSString *) password
                       username:(NSString *) username
{
    if (self = [super init])
    {
        self.userId = userId;
        self.dateJoined = dateJoined;
        self.email = email;
        self.firstName = firstName;
        self.isActive = isActive;
        self.lastName = lastName;
        self.password = password;
        self.username = username;
    }

    return self;
}

- (instancetype) initWithEmail:(NSString *) email
                     firstName:(NSString *) firstName
                      lastName:(NSString *) lastName
                      password:(NSString *) password
                      username:(NSString *) username
{
    return [self initWithUserId:nil
                     dateJoined:nil
                          email:email
                      firstName:firstName
                       isActive:YES
                       lastName:lastName
                       password:password
                       username:username];
}

- (instancetype) initWithJson:(NSData *) data
{
    NSDictionary *json = [Json parseJsonObject:data];

    if (json)
    {
        return [self initWithUserId:json[@"id"]
                         dateJoined:json[@"date_joined"]
                              email:json[@"email"]
                          firstName:json[@"first_name"]
                           isActive:[json[@"is_active"] boolValue]
                           lastName:json[@"last_name"]
                           password:json[@"password"]
                           username:json[@"username"]];
    }
    else
    {
        return nil;
    }
}

- (NSString *) description
{
    return [[NSString alloc] initWithFormat:@"%@, %@, %@, %@, %@, %@, %@, %@",
                                            self.userId,
                                            self.dateJoined,
                                            self.email,
                                            self.firstName,
                                            self.isActive ? @"YES" : @"NO",
                                            self.lastName,
                                            self.password,
                                            self.username];
}

@end