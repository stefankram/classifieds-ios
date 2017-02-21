//
// Created by Stefan Kramreither on 2017-02-20.
// Copyright (c) 2017 Stefan Kramreither. All rights reserved.
//

#import "Json.h"

@implementation Json

+ (NSDictionary *) parseJsonObject:(NSData *) data
{
    NSError *error = nil;

    id parsed = [NSJSONSerialization JSONObjectWithData:data
                                                options:0
                                                  error:&error];

    if (error) return nil;

    if ([parsed isKindOfClass:[NSDictionary class]])
    {
        return parsed;
    }
    else
    {
        return nil;
    }
}

@end