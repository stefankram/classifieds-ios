//
// Created by Stefan Kramreither on 2017-02-24.
// Copyright (c) 2017 Stefan Kramreither. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SellerItemModel : NSObject

@property (nonatomic, copy) NSNumber *sellerItemId;
@property (nonatomic, copy) NSNumber *itemId;
@property (nonatomic, copy) NSNumber *sellerId;

- (instancetype) initWithSellerItemId:(NSNumber *) sellerItemId
                               itemId:(NSNumber *) itemId
                             sellerId:(NSNumber *) sellerId;

- (instancetype) initWithItemId:(NSNumber *) itemId
                       sellerId:(NSNumber *) sellerId;

- (instancetype) initWithJson:(NSData *) data;

@end