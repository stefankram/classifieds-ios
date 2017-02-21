//
//  ItemStore.m
//  classifieds
//
//  Created by Stefan Kramreither on 2017-02-19.
//  Copyright © 2017 Stefan Kramreither. All rights reserved.
//

#import "ItemStore.h"
#import "ItemModel.h"

@interface ItemStore ()

@property (nonatomic, strong) NSMutableArray *items;

@end

@implementation ItemStore

static ItemStore *store;

- (instancetype) init
{
    if (self = [super init])
    {
        self.items = [[NSMutableArray alloc] init];
    }

    return self;
}

+ (NSArray *) items
{
    @synchronized (self)
    {
        if (!store) store = [[ItemStore alloc] init];

        return store.items;
    }
}

+ (ItemModel *) findByName:(NSString *) name
{
    @synchronized (self)
    {
        if (!store) store = [[ItemStore alloc] init];

        for (ItemModel *item in self.items)
        {
            if ([item.name isEqualToString:name]) return item;
        }

        // Is not in store therefore we must HTTP GET it

        return nil;
    }
}

+ (ItemModel *) findById:(int) itemId
{
    @synchronized (self)
    {
        if (!store) store = [[ItemStore alloc] init];

        for (ItemModel *item in self.items)
        {
            if (item.itemId == itemId) return item;
        }

        // Is not in store therefore we must HTTP GET it

        return nil;
    }
}

@end
