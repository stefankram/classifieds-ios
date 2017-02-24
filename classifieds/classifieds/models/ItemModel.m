//
//  ItemModel.m
//  classifieds
//
//  Created by Stefan Kramreither on 2017-02-19.
//  Copyright © 2017 Stefan Kramreither. All rights reserved.
//

#import "ItemModel.h"
#import "Json.h"

@implementation ItemModel

- (instancetype) initWithItemId:(unsigned long) itemId
                      available:(BOOL) available
                      createdAt:(NSDate *) createdAt
                           name:(NSString *) name
                       itemType:(NSString *) itemType
{
    if (self = [super init])
    {
        self.itemId = itemId;
        self.available = available;
        self.createdAt = createdAt;
        self.name = name;
        self.itemType = itemType;
    }

    return self;
}


- (instancetype) initWithJson:(NSData *) data
{
    NSDictionary *json = [Json parseJsonObject:data];

    if (json)
    {
        return [self initWithItemId:[json[@"id"] unsignedLongValue]
                          available:[json[@"available"] boolValue]
                          createdAt:json[@"created_at"]
                               name:json[@"name"]
                           itemType:json[@"item_type"]];
    }
    else
    {
        return nil;
    }
}

- (NSString *) description
{
    return [[NSString alloc] initWithFormat:@"%lu, %@, %@, %@, %@",
                                            self.itemId,
                                            self.available ? @"YES" : @"NO",
                                            self.createdAt,
                                            self.name,
                                            self.itemType];
}

@end
