//
// Created by Stefan Kramreither on 2017-02-20.
// Copyright (c) 2017 Stefan Kramreither. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Json : NSObject

+ (NSDictionary *) parseJsonObject:(NSData *) data;

+ (NSArray *) parseJsonArray:(NSData *) data;

@end
