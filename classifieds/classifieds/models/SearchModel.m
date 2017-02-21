//
//  SearchModel.m
//  classifieds
//
//  Created by Stefan Kramreither on 2017-02-19.
//  Copyright © 2017 Stefan Kramreither. All rights reserved.
//

#import "SearchModel.h"

@implementation SearchModel

- (instancetype) initWithSearchId:(int) searchId
                            buyer:(int) buyerId
                        createdAt:(NSDate *) createdAt
                      description:(NSString *) description
                             item:(int) itemId
{
    if (self = [super init])
    {
        self.searchId = searchId;
        self.buyerId = buyerId;
        self.createdAt = createdAt;
        self.desc = description;
        self.itemId = itemId;
    }

    return self;
}

- (NSString *) description
{
    return [[NSString alloc] initWithFormat:@"%d, %d, %@, %@, %d",
                                            self.searchId,
                                            self.buyerId,
                                            self.createdAt,
                                            self.desc,
                                            self.itemId];
}

@end
