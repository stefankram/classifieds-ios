//
// Created by Stefan Kramreither on 2017-02-23.
// Copyright (c) 2017 Stefan Kramreither. All rights reserved.
//

#import "AddressStore.h"
#import "AddressModel.h"
#import "Url.h"

@interface AddressStore ()

@property (nonatomic, strong) NSMutableArray *addresses;

@end

@implementation AddressStore

static AddressStore *store;

/* INIT method */
- (instancetype) init
{
    if (self = [super init])
    {
        self.addresses = [[NSMutableArray alloc] init];
    }

    return self;
}

/* CREATE method */
+ (void) createAddress:(AddressModel *) address
             onSuccess:(void (^)(AddressModel *model)) success
                onFail:(void (^)(NSString *error)) fail
{
    @synchronized (self)
    {
        if (!store) store = [[AddressStore alloc] init];

        NSData *body = [[NSString stringWithFormat:
                @"{"
                        "\"city\": \"%@\","
                        "\"country\": \"%@\","
                        "\"postal_code\": \"%@\","
                        "\"province\": \"%@\","
                        "\"street\": \"%@\""
                        "}",
                address.city,
                address.country,
                address.postalCode,
                address.province,
                address.street]
                dataUsingEncoding:NSUTF8StringEncoding
             allowLossyConversion:YES];

        NSString *bodyLength = [NSString stringWithFormat:@"%d", [body length]];

        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:[Url createAddress]];
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
                              AddressModel *model = [[AddressModel alloc] initWithJson:data];
                              if (model)
                              {
                                  [store.addresses addObject:model];
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