//
//  ItemModel.m
//  classifieds
//
//  Created by Stefan Kramreither on 2017-02-19.
//  Copyright © 2017 Stefan Kramreither. All rights reserved.
//

#import "ItemModel.h"

@implementation ItemModel

- (instancetype) initWithItemId:(int) itemId
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

- (instancetype) initWithJson:(NSData *) json
{
    if (self = [super init])
    {
        NSError *jsonError = nil;

        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:json
                                                                 options:0
                                                                   error:&jsonError];

        if (!jsonError)
        {
            NSLog(@"%@", jsonDict);
        }
        else
        {
            return nil;
        }
    }

    return self;
}

- (NSString *) description
{
    return [[NSString alloc] initWithFormat:@"%d, %d, %@, %@, %@",
                                            self.itemId,
                                            self.available,
                                            self.createdAt,
                                            self.name,
                                            self.itemType];
}

@end
