//
// Created by Stefan Kramreither on 2017-02-23.
// Copyright (c) 2017 Stefan Kramreither. All rights reserved.
//

#import "BillingStore.h"
#import "BillingModel.h"
#import "Url.h"

@interface BillingStore ()

@property (nonatomic, strong) NSMutableArray *billings;

@end

@implementation BillingStore

static BillingStore *store;

/* INIT method */
- (instancetype) init
{
    if (self = [super init])
    {
        self.billings = [[NSMutableArray alloc] init];
    }

    return self;
}

/* CREATE method */
+ (void) createBilling:(BillingModel *) billing
             onSuccess:(void (^)(BillingModel *model)) success
                onFail:(void (^)(NSString *error)) fail
{
    @synchronized (self)
    {
        if (!store) store = [[BillingStore alloc] init];

        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        NSString *expiry = [formatter stringFromDate:billing.cardExpiry];

        NSData *body = [[NSString stringWithFormat:
                @"{"
                        "\"card_network\": \"%@\","
                        "\"card_number\": \"%@\","
                        "\"card_expiry\": \"%@\","
                        "\"card_security_code\": \"%@\""
                        "}",
                billing.cardNetwork,
                billing.cardNumber,
                expiry,
                billing.cardSecurityCode]
                dataUsingEncoding:NSUTF8StringEncoding
             allowLossyConversion:YES];

        NSString *bodyLength = [NSString stringWithFormat:@"%d", [body length]];

        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:[Url createBilling]];
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
                              BillingModel *model = [[BillingModel alloc] initWithJson:data];
                              if (model)
                              {
                                  [store.billings addObject:model];
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