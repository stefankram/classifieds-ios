//
//  SearchStore.m
//  classifieds
//
//  Created by Stefan Kramreither on 2017-02-19.
//  Copyright © 2017 Stefan Kramreither. All rights reserved.
//

#import "SearchStore.h"
#import "SearchModel.h"
#import "Url.h"
#import "Token.h"
#import "Json.h"

@interface SearchStore ()

@property (nonatomic, strong) NSMutableArray *searches;

@end

@implementation SearchStore

static SearchStore *store;

/* INIT method */
- (instancetype) init
{
    if (self = [super init])
    {
        self.searches = [[NSMutableArray alloc] init];
    }

    return self;
}

+ (NSArray *) searches
{
    @synchronized (self)
    {
        if (!store) store = [[SearchStore alloc] init];

        return [NSArray arrayWithArray:store.searches];
    }
}

/* CREATE method */
+ (void) createSearch:(SearchModel *) search
            onSuccess:(void (^)(SearchModel *model)) success
               onFail:(void (^)(NSString *error)) fail
{
    @synchronized (self)
    {
        if (!store) store = [[SearchStore alloc] init];

        NSData *body = [[NSString stringWithFormat:
                @"{"
                        "\"buyer_id\": %@,"
                        "\"description\": \"%@\","
                        "\"item_id\": %@"
                        "}",
                search.buyerId,
                search.desc,
                search.itemId]
                dataUsingEncoding:NSUTF8StringEncoding
             allowLossyConversion:YES];

        NSString *bodyLength = [NSString stringWithFormat:@"%d", [body length]];

        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:[Url createSearch]];
        [request setHTTPMethod:@"POST"];
        [request setValue:bodyLength forHTTPHeaderField:@"Content-Length"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setValue:[Token authHeader] forHTTPHeaderField:@"Authorization"];
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
                              SearchModel *model = [[SearchModel alloc] initWithJson:data];
                              if (model)
                              {
                                  [store.searches addObject:model];
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

/* FIND ALL method */
+ (void) findAllWithBuyerId:(NSNumber *) buyerId
                  onSuccess:(void (^)(void)) success
                     onFail:(void (^)(NSString *error)) fail
{
    @synchronized (self)
    {
        if (!store) store = [[SearchStore alloc] init];

        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:[Url findAllSearchWithBuyerId:buyerId]];
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
                              NSArray *json = [Json parseJsonArray:data];
                              if (json)
                              {
                                  [store.searches removeAllObjects];
                                  for (NSDictionary *obj in json)
                                  {
                                      [store.searches addObject:[[SearchModel alloc] initWithDictionary:obj]];
                                  }
                                  success();
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
