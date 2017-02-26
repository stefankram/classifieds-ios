//
// Created by Stefan Kramreither on 2017-02-24.
// Copyright (c) 2017 Stefan Kramreither. All rights reserved.
//

#import "UserStore.h"
#import "UserModel.h"
#import "Url.h"
#import "Token.h"

@interface UserStore ()

@property (nonatomic, strong) NSMutableArray *users;

@end

@implementation UserStore

static UserStore *store;

/* INIT Method */
- (instancetype) init
{
    if (self = [super init])
    {
        self.users = [[NSMutableArray alloc] init];
    }

    return self;
}

/* CREATE Method */
+ (void) createUser:(UserModel *) user
          onSuccess:(void (^)(UserModel *model)) success
             onFail:(void (^)(NSString *error)) fail
{
    @synchronized (self)
    {
        if (!store) store = [[UserStore alloc] init];

        NSData *body = [[NSString stringWithFormat:
                @"{"
                        "\"email\": \"%@\","
                        "\"first_name\": \"%@\","
                        "\"last_name\": \"%@\","
                        "\"password\": \"%@\","
                        "\"username\": \"%@\""
                        "}",
                user.email,
                user.firstName,
                user.lastName,
                user.password,
                user.username]
                dataUsingEncoding:NSUTF8StringEncoding
             allowLossyConversion:YES];

        NSString *bodyLength = [NSString stringWithFormat:@"%d", [body length]];

        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:[Url createUser]];
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
                          if (statusCode == 201)
                          {
                              UserModel *model = [[UserModel alloc] initWithJson:data];
                              if (model)
                              {
                                  [store.users addObject:model];
                                  success(model);
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
}

/* FIND method */
+ (void) findByUsername:(NSString *) username
              onSuccess:(void (^)(UserModel *model)) success
                 onFail:(void (^)(NSString *error)) fail
{
    @synchronized (self)
    {
        if (!store) store = [[UserStore alloc] init];

        for (UserModel *user in store.users)
        {
            if ([user.username isEqualToString:username])
            {
                success(user);
                return;
            }
        }

        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:[Url findUserWithUsername:username]];
        [request setHTTPMethod:@"GET"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setValue:[Token authHeader] forHTTPHeaderField:@"Authorization"];

        [[[NSURLSession sharedSession]
                dataTaskWithRequest:request
                  completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                  {
                      if (!error)
                      {
                          NSInteger statusCode = ((NSHTTPURLResponse *) response).statusCode;
                          if (statusCode == 200)
                          {
                              UserModel *model = [[UserModel alloc] initWithJson:data];
                              if (model)
                              {
                                  [store.users addObject:model];
                                  success(model);
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
}

@end