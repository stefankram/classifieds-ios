//
// Created by Stefan Kramreither on 2017-02-20.
// Copyright (c) 2017 Stefan Kramreither. All rights reserved.
//

#import "Token.h"

@implementation Token

+ (NSURLRequest *) obtainWithUsername:(NSString *) username
                             password:(NSString *) password
{
    NSString *post = [NSString stringWithFormat:@"{"
                                                        "\"username\": \"%@\","
                                                        "\"password\": \"%@\""
                                                        "}",
                                                username,
                                                password];

    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];

    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"http://localhost:8000/api/token/obtain/"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];

    return request;
}

+ (NSURLRequest *) refreshToken:(NSString *) token
{
    NSString *post = [NSString stringWithFormat:@"{"
                                                        "\"token\": \"%@\""
                                                        "}",
                                                token];

    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];

    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"http://localhost:8000/api/token/refresh/"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];

    return request;
}

@end