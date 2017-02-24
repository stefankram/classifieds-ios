//
//  ItemModel.h
//  classifieds
//
//  Created by Stefan Kramreither on 2017-02-19.
//  Copyright © 2017 Stefan Kramreither. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ItemModel : NSObject

@property (nonatomic) unsigned long itemId;
@property (nonatomic) BOOL available;
@property (nonatomic, copy) NSDate *createdAt;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *itemType;

- (instancetype) initWithItemId:(unsigned long) itemId
                      available:(BOOL) available
                      createdAt:(NSDate *) createdAt
                           name:(NSString *) name
                       itemType:(NSString *) itemType;

- (instancetype) initWithJson:(NSData *) json;

@end
