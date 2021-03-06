//
//  ItemStore.m
//  classifieds
//
//  Created by Stefan Kramreither on 2017-02-19.
//  Copyright © 2017 Stefan Kramreither. All rights reserved.
//

#import "ItemStore.h"
#import "ItemModel.h"
#import "Token.h"
#import "Url.h"

@interface ItemStore ()

@property (nonatomic, strong) NSMutableArray *items;

@end

@implementation ItemStore

static ItemStore *store;

- (instancetype) init
{
    if (self = [super init])
    {
        self.items = [[NSMutableArray alloc] init];
    }

    return self;
}

+ (void) findByName:(NSString *) name
          onSuccess:(void (^)(ItemModel *)) success
             onFail:(void (^)(NSString *error)) fail
{
    @synchronized (self)
    {
        if (!store) store = [[ItemStore alloc] init];

        for (ItemModel *item in store.items)
        {
            if ([item.name isEqualToString:name])
            {
                success(item);
                return;
            }
        }

        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:[Url findItemWithName:name]];
        [request setHTTPMethod:@"GET"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setValue:[Token authHeader] forHTTPHeaderField:@"Authorization"];

        [[[NSURLSession sharedSession]
                dataTaskWithRequest:request
                  completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                  {
                      if (!error)
                      {
                          int statusCode = ((NSHTTPURLResponse *) response).statusCode;
                          if (statusCode == 200)
                          {
                              ItemModel *item = [[ItemModel alloc] initWithJson:data];
                              if (item)
                              {
                                  [store.items addObject:item];
                                  success(item);
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
