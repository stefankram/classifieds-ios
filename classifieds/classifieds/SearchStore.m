//
//  SearchStore.m
//  classifieds
//
//  Created by Stefan Kramreither on 2017-02-19.
//  Copyright © 2017 Stefan Kramreither. All rights reserved.
//

#import "SearchStore.h"
#import "SearchModel.h"
#import "ItemModel.h"
#import "ItemStore.h"

@interface SearchStore ()

@property (nonatomic, strong) NSMutableArray *searches;

@end

@implementation SearchStore

static SearchStore *store;

- (instancetype) init
{
    if (self = [super init])
    {
        self.searches = [[NSMutableArray alloc] init];
    }

    return self;
}

+ (NSArray *) searches
{
    @synchronized (self)
    {
        if (!store) store = [[SearchStore alloc] init];

        return store.searches;
    }
}

+ (void) createWithItemName:(NSString *) itemName
                description:(NSString *) description
{
    @synchronized (self)
    {
        if (!store) store = [[SearchStore alloc] init];

        ItemModel *item = [ItemStore findByName:itemName];

        // HTTP POST to create the search, return full object


    }
}

@end
