//
//  SearchModel.m
//  classifieds
//
//  Created by Stefan Kramreither on 2017-02-19.
//  Copyright © 2017 Stefan Kramreither. All rights reserved.
//

#import "SearchModel.h"
#import "Json.h"

@implementation SearchModel

- (instancetype) initWithSearchId:(NSNumber *) searchId
                          buyerId:(NSNumber *) buyerId
                        createdAt:(NSDate *) createdAt
                      description:(NSString *) desc
                           itemId:(NSNumber *) itemId
{
    if (self = [super init])
    {
        self.searchId = searchId;
        self.buyerId = buyerId;
        self.createdAt = createdAt;
        self.desc = desc;
        self.itemId = itemId;
    }

    return self;
}

- (instancetype) initWithBuyerId:(NSNumber *) buyerId
                     description:(NSString *) desc
                          itemId:(NSNumber *) itemId
{
    return [self initWithSearchId:nil
                          buyerId:buyerId
                        createdAt:nil
                      description:desc
                           itemId:itemId];
}

- (instancetype) initWithJson:(NSData *) data
{
    NSDictionary *json = [Json parseJsonObject:data];

    if (json)
    {
        return [self initWithSearchId:json[@"id"]
                              buyerId:json[@"buyer_id"]
                            createdAt:json[@"created_at"]
                          description:json[@"description"]
                               itemId:json[@"item_id"]];
    }
    else
    {
        return nil;
    }
}

- (instancetype) initWithDictionary:(NSDictionary *) dict
{
    return [self initWithSearchId:dict[@"id"]
                          buyerId:dict[@"buyer_id"]
                        createdAt:dict[@"created_at"]
                      description:dict[@"description"]
                           itemId:dict[@"item_id"]];
}

- (BOOL) isEqual:(id) object
{
    return ((SearchModel *) object).searchId == self.searchId;
}

- (NSString *) description
{
    return [[NSString alloc] initWithFormat:@"%@, %@, %@, %@, %@",
                                            self.searchId,
                                            self.buyerId,
                                            self.createdAt,
                                            self.desc,
                                            self.itemId];
}

@end
