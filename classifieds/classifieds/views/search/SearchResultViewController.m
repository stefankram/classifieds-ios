//
//  SearchResultViewController.m
//  classifieds
//
//  Created by Stefan Kramreither on 2017-02-19.
//  Copyright © 2017 Stefan Kramreither. All rights reserved.
//

#import "SearchResultViewController.h"
#import "SearchModel.h"

@interface SearchResultViewController ()

@end

@implementation SearchResultViewController

- (instancetype) initWithSearchModel:(SearchModel *) search
{
    if (self = [super initWithStyle:UITableViewStylePlain])
    {
        self.navigationItem.title = @"Searching...";
    }

    return self;
}

@end
