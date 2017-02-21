//
//  SearchStore.h
//  classifieds
//
//  Created by Stefan Kramreither on 2017-02-19.
//  Copyright © 2017 Stefan Kramreither. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SearchModel;

@interface SearchStore : NSObject

+ (NSArray *) searches;

+ (void) createWithItemName:(NSString *) itemName
                description:(NSString *) description;

@end
