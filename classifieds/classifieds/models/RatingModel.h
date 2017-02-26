//
// Created by Stefan Kramreither on 2017-02-24.
// Copyright (c) 2017 Stefan Kramreither. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RatingModel : NSObject

@property (nonatomic, copy) NSNumber *ratingId;
@property (nonatomic, copy) NSNumber *buyerId;
@property (nonatomic, copy) NSDate *createdAt;
@property (nonatomic, copy) NSString *review;
@property (nonatomic, copy) NSString *recipient;
@property (nonatomic, copy) NSNumber *score;
@property (nonatomic, copy) NSNumber *sellerId;

- (instancetype) initWithRatingId:(NSNumber *) ratingId
                          buyerId:(NSNumber *) buyerId
                        createdAt:(NSDate *) createdAt
                           review:(NSString *) review
                        recipient:(NSString *) recipient
                            score:(NSNumber *) score
                         sellerId:(NSNumber *) sellerId;

- (instancetype) initWithBuyerId:(NSNumber *) buyerId
                          review:(NSString *) review
                       recipient:(NSString *) recipient
                           score:(NSNumber *) score
                        sellerId:(NSNumber *) sellerId;

- (instancetype) initWithJson:(NSData *) data;

@end