//
// Created by Stefan Kramreither on 2017-02-24.
// Copyright (c) 2017 Stefan Kramreither. All rights reserved.
//

#import "MessageModel.h"
#import "Json.h"


@implementation MessageModel

- (instancetype) initWithMessageId:(NSNumber *) messageId
                           buyerId:(NSNumber *) buyerId
                         createdAt:(NSDate *) createdAt
                           message:(NSString *) message
                         recipient:(NSString *) recipient
                          sellerId:(NSNumber *) sellerId
{
    if (self = [super init])
    {
        self.messageId = messageId;
        self.buyerId = buyerId;
        self.createdAt = createdAt;
        self.message = message;
        self.recipient = recipient;
        self.sellerId = sellerId;
    }

    return self;
}

- (instancetype) initWithBuyerId:(NSNumber *) buyerId
                         message:(NSString *) message
                       recipient:(NSString *) recipient
                        sellerId:(NSNumber *) sellerId
{
    return [self initWithMessageId:nil
                           buyerId:buyerId
                         createdAt:nil
                           message:message
                         recipient:recipient
                          sellerId:sellerId];
}

- (instancetype) initWithJson:(NSData *) data
{
    NSDictionary *json = [Json parseJsonObject:data];

    if (json)
    {
        return [self initWithMessageId:json[@"id"]
                               buyerId:json[@"buyer_id"]
                             createdAt:json[@"created_at"]
                               message:json[@"message"]
                             recipient:json[@"recipient"]
                              sellerId:json[@"seller_id"]];
    }
    else
    {
        return nil;
    }
}

- (NSString *) description
{
    return [[NSString alloc] initWithFormat:@"%@, %@, %@, %@, %@, %@",
                                            self.messageId,
                                            self.buyerId,
                                            self.createdAt,
                                            self.message,
                                            self.recipient,
                                            self.sellerId];
}

@end