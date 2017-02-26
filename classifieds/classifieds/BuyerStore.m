//
// Created by Stefan Kramreither on 2017-02-23.
// Copyright (c) 2017 Stefan Kramreither. All rights reserved.
//

#import "BuyerStore.h"
#import "BuyerModel.h"
#import "Url.h"
#import "Token.h"

@interface BuyerStore ()

@property (nonatomic, strong) NSMutableArray *buyers;

@end

@implementation BuyerStore

static BuyerStore *store;

/* INIT method */
- (instancetype) init
{
    if (self = [super init])
    {
        self.buyers = [[NSMutableArray alloc] init];
    }

    return self;
}

/* CREATE method */
+ (void) createBuyer:(BuyerModel *) buyer
           onSuccess:(void (^)(BuyerModel *model)) success
              onFail:(void (^)(NSString *error)) fail
{
    @synchronized (self)
    {
        if (!store) store = [[BuyerStore alloc] init];

        NSData *body = [[NSString stringWithFormat:
                @"{"
                        "\"address_id\": \"%@\","
                        "\"billing_id\": \"%@\","
                        "\"phone\": \"%@\","
                        "\"profile_pic\": \"%@\","
                        "\"user_id\": \"%@\""
                        "}",
                buyer.addressId,
                buyer.billingId,
                buyer.phone,
                buyer.profilePic,
                buyer.userId]
                dataUsingEncoding:NSUTF8StringEncoding
             allowLossyConversion:YES];

        NSString *bodyLength = [NSString stringWithFormat:@"%d", [body length]];

        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:[Url createBuyer]];
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
                              BuyerModel *model = [[BuyerModel alloc] initWithJson:data];
                              if (model)
                              {
                                  [store.buyers addObject:model];
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
+ (void) findByUserId:(NSNumber *) userId
            onSuccess:(void (^)(BuyerModel *model)) success
               onFail:(void (^)(NSString *error)) fail
{
    @synchronized (self)
    {
        if (!store) store = [[BuyerStore alloc] init];

        for (BuyerModel *buyer in store.buyers)
        {
            if ([buyer.userId isEqualToNumber:userId])
            {
                success(buyer);
                return;
            }
        }

        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:[Url findBuyerWithUserId:userId]];
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
                              BuyerModel *model = [[BuyerModel alloc] initWithJson:data];
                              if (model)
                              {
                                  [store.buyers addObject:model];
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