//
//  SearchModel.h
//  classifieds
//
//  Created by Stefan Kramreither on 2017-02-19.
//  Copyright © 2017 Stefan Kramreither. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchModel : NSObject

@property (nonatomic, copy) NSNumber *searchId;
@property (nonatomic, copy) NSNumber *buyerId;
@property (nonatomic, copy) NSDate *createdAt;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSNumber *itemId;

- (instancetype) initWithSearchId:(NSNumber *) searchId
                          buyerId:(NSNumber *) buyerId
                        createdAt:(NSDate *) createdAt
                      description:(NSString *) desc
                           itemId:(NSNumber *) itemId;

- (instancetype) initWithBuyerId:(NSNumber *) buyerId
                     description:(NSString *) desc
                          itemId:(NSNumber *) itemId;

- (instancetype) initWithJson:(NSData *) data;

- (instancetype) initWithDictionary:(NSDictionary *) dict;

@end
