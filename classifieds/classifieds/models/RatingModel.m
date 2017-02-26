//
// Created by Stefan Kramreither on 2017-02-24.
// Copyright (c) 2017 Stefan Kramreither. All rights reserved.
//

#import "RatingModel.h"
#import "Json.h"

@implementation RatingModel

- (instancetype) initWithRatingId:(NSNumber *) ratingId
                          buyerId:(NSNumber *) buyerId
                        createdAt:(NSDate *) createdAt
                           review:(NSString *) review
                        recipient:(NSString *) recipient
                            score:(NSNumber *) score
                         sellerId:(NSNumber *) sellerId
{
    if (self = [super init])
    {
        self.ratingId = ratingId;
        self.buyerId = buyerId;
        self.createdAt = createdAt;
        self.review = review;
        self.recipient = recipient;
        self.score = score;
        self.sellerId = sellerId;
    }

    return self;
}

- (instancetype) initWithBuyerId:(NSNumber *) buyerId
                          review:(NSString *) review
                       recipient:(NSString *) recipient
                           score:(NSNumber *) score
                        sellerId:(NSNumber *) sellerId
{
    return [self initWithRatingId:nil
                          buyerId:buyerId
                        createdAt:nil
                           review:review
                        recipient:recipient
                            score:score
                         sellerId:sellerId];
}

- (instancetype) initWithJson:(NSData *) data
{
    NSDictionary *json = [Json parseJsonObject:data];

    if (json)
    {
        return [self initWithRatingId:json[@"id"]
                              buyerId:json[@"buyer_id"]
                            createdAt:json[@"created_at"]
                               review:json[@"review"]
                            recipient:json[@"recipient"]
                                score:json[@"score"]
                             sellerId:json[@"seller_id"]];
    }
    else
    {
        return nil;
    }
}

- (NSString *) description
{
    return [[NSString alloc] initWithFormat:@"%@, %@, %@, %@, %@, %@, %@",
                                            self.ratingId,
                                            self.buyerId,
                                            self.createdAt,
                                            self.review,
                                            self.recipient,
                                            self.score,
                                            self.sellerId];
}

@end