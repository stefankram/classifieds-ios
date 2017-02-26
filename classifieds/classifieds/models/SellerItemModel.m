//
// Created by Stefan Kramreither on 2017-02-24.
// Copyright (c) 2017 Stefan Kramreither. All rights reserved.
//

#import "SellerItemModel.h"
#import "Json.h"

@implementation SellerItemModel

- (instancetype) initWithSellerItemId:(NSNumber *) sellerItemId
                               itemId:(NSNumber *) itemId
                             sellerId:(NSNumber *) sellerId
{
    if (self = [super init])
    {
        self.sellerItemId = sellerItemId;
        self.itemId = itemId;
        self.sellerId = sellerId;
    }

    return self;
}

- (instancetype) initWithItemId:(NSNumber *) itemId
                       sellerId:(NSNumber *) sellerId
{
    return [self initWithSellerItemId:nil
                               itemId:itemId
                             sellerId:sellerId];
}

- (instancetype) initWithJson:(NSData *) data
{
    NSDictionary *json = [Json parseJsonObject:data];

    if (json)
    {
        return [self initWithSellerItemId:json[@"id"]
                                   itemId:json[@"item_id"]
                                 sellerId:json[@"seller_id"]];
    }
    else
    {
        return nil;
    }
}

- (NSString *) description
{
    return [[NSString alloc] initWithFormat:@"%@, %@, %@",
                                            self.sellerItemId,
                                            self.itemId,
                                            self.sellerId];
}

@end