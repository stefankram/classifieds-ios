//
//  SearchResultViewController.h
//  classifieds
//
//  Created by Stefan Kramreither on 2017-02-19.
//  Copyright © 2017 Stefan Kramreither. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SearchModel;

@interface SearchResultViewController : UITableViewController

- (instancetype) initWithSearchModel:(SearchModel *) search;

@end
