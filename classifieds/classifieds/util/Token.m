//
// Created by Stefan Kramreither on 2017-02-20.
// Copyright (c) 2017 Stefan Kramreither. All rights reserved.
//

#import "Token.h"
#import "UserModel.h"
#import "Url.h"
#import "Json.h"

@implementation Token

+ (void) obtainWithUsername:(NSString *) username
                   password:(NSString *) password
                  onSuccess:(void (^)(NSString *token)) success
                     onFail:(void (^)(NSString *error)) fail
{
    NSData *body = [[NSString stringWithFormat:
            @"{"
                    "\"username\": \"%@\","
                    "\"password\": \"%@\""
                    "}",
            username,
            password]
            dataUsingEncoding:NSUTF8StringEncoding
         allowLossyConversion:YES];

    NSString *bodyLength = [NSString stringWithFormat:@"%d", [body length]];

    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[Url obtainToken]];
    [request setHTTPMethod:@"POST"];
    [request setValue:bodyLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:body];

    [[[NSURLSession sharedSession]
            dataTaskWithRequest:request
              completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
              {
                  if (!error)
                  {
                      NSInteger statusCode = ((NSHTTPURLResponse *) response).statusCode;
                      if (statusCode == 200)
                      {
                          NSDictionary *json = [Json parseJsonObject:data];
                          if (json)
                          {
                              success(json[@"token"]);
                          }
                          else
                          {
                              fail(@"Malformed JSON");
                          }
                      }
                      else
                      {
                          fail([[NSString alloc] initWithData:data
                                                     encoding:NSUTF8StringEncoding]);
                      }
                  }
                  else
                  {
                      fail([error localizedDescription]);
                  }
              }] resume];
}

+ (void) refreshWithToken:(NSString *) token
                onSuccess:(void (^)(NSString *newToken)) success
                   onFail:(void (^)(NSString *error)) fail
{
    NSData *body = [[NSString stringWithFormat:
            @"{"
                    "\"token\": \"%@\""
                    "}",
            token]
            dataUsingEncoding:NSUTF8StringEncoding
         allowLossyConversion:YES];

    NSString *bodyLength = [NSString stringWithFormat:@"%d", [body length]];

    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[Url refreshToken]];
    [request setHTTPMethod:@"POST"];
    [request setValue:bodyLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:body];

    [[[NSURLSession sharedSession]
            dataTaskWithRequest:request
              completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
              {
                  if (!error)
                  {
                      NSInteger statusCode = ((NSHTTPURLResponse *) response).statusCode;
                      if (statusCode == 200)
                      {
                          NSDictionary *json = [Json parseJsonObject:data];
                          if (json)
                          {
                              success(json[@"token"]);
                          }
                          else
                          {
                              fail(@"Malformed JSON");
                          }
                      }
                      else
                      {
                          fail([[NSString alloc] initWithData:data
                                                     encoding:NSUTF8StringEncoding]);
                      }
                  }
                  else
                  {
                      fail([error localizedDescription]);
                  }
              }] resume];
}

+ (NSString *) authHeader
{
    return [[NSString alloc] initWithFormat:@"JWT %@",
                    [[NSUserDefaults standardUserDefaults] stringForKey:@"token"]];
}

@end