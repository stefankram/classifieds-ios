//
//  SearchModel.h
//  classifieds
//
//  Created by Stefan Kramreither on 2017-02-19.
//  Copyright © 2017 Stefan Kramreither. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchModel : NSObject

@property (nonatomic) int searchId;
@property (nonatomic) int buyerId;
@property (nonatomic, copy) NSDate *createdAt;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic) int itemId;

- (instancetype) initWithSearchId:(int) searchId
                            buyer:(int) buyerId
                        createdAt:(NSDate *) createdAt
                      description:(NSString *) description
                             item:(int) itemId;

@end
