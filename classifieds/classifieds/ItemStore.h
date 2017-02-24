//
//  ItemStore.h
//  classifieds
//
//  Created by Stefan Kramreither on 2017-02-19.
//  Copyright © 2017 Stefan Kramreither. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ItemModel;

@interface ItemStore : NSObject

+ (void) findByName:(NSString *) name
          onSuccess:(void (^)(ItemModel *item)) success
             onFail:(void (^)(NSString *error)) fail;

@end
