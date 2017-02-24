//
// Created by Stefan Kramreither on 2017-02-23.
// Copyright (c) 2017 Stefan Kramreither. All rights reserved.
//

#import "AddressStore.h"
#import "AddressModel.h"
#import "Token.h"

@interface AddressStore ()

@property (nonatomic, strong) NSMutableArray *addresses;

@end

@implementation AddressStore

static AddressStore *store;

- (instancetype) init
{
    if (self = [super init])
    {
        self.addresses = [[NSMutableArray alloc] init];
    }

    return self;
}

+ (void) createWithAddress:(AddressModel *) address
                 onSuccess:(void (^)(AddressModel *model)) success
                    onFail:(void (^)(NSString *error)) fail
{
    NSString *post = [NSString stringWithFormat:@"{"
                                                        "\"city\": \"%@\","
                                                        "\"country\": \"%@\","
                                                        "\"postal_code\": \"%@\","
                                                        "\"province\": \"%@\","
                                                        "\"street\": \"%@\","
                                                        "}",
                                                address.city,
                                                address.country,
                                                address.postalCode,
                                                address.province,
                                                address.street];

    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding
                          allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];

    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"http://localhost:8000/api/address/create/"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];

    [[[NSURLSession sharedSession]
            dataTaskWithRequest:request
              completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
              {
                  if (!error)
                  {
                      int statusCode = ((NSHTTPURLResponse *) response).statusCode;
                      if (statusCode == 200)
                      {
                          AddressModel *model = [[AddressModel alloc] initWithJson:data];
                          if (model)
                          {
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

+ (void) findById:(unsigned long) addressId
        onSuccess:(void (^)(AddressModel *model)) success
           onFail:(void (^)(NSString *error)) fail
{
    @synchronized (self)
    {
        if (!store) store = [[AddressStore alloc] init];

        for (AddressModel *address in store.addresses)
        {
            if (address.addressId == addressId)
            {
                success(address);
                return;
            }
        }

        NSString *url = [[NSString alloc]
                initWithFormat:@"http://localhost:8000/api/address/%lu/", addressId];

        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:[NSURL URLWithString:url]];
        [request setHTTPMethod:@"GET"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setValue:[Token getAuthHeader] forHTTPHeaderField:@"Authorization"];

        [[[NSURLSession sharedSession]
                dataTaskWithRequest:request
                  completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                  {
                      if (!error)
                      {
                          int statusCode = ((NSHTTPURLResponse *) response).statusCode;
                          if (statusCode == 200)
                          {
                              AddressModel *address = [[AddressModel alloc] initWithJson:data];
                              if (address)
                              {
                                  [store.addresses addObject:address];
                                  success(address);
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