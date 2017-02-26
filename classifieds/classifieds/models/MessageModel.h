//
// Created by Stefan Kramreither on 2017-02-24.
// Copyright (c) 2017 Stefan Kramreither. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageModel : NSObject

@property (nonatomic, copy) NSNumber *messageId;
@property (nonatomic, copy) NSNumber *buyerId;
@property (nonatomic, copy) NSDate *createdAt;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, copy) NSString *recipient;
@property (nonatomic, copy) NSNumber *sellerId;

- (instancetype) initWithMessageId:(NSNumber *) messageId
                           buyerId:(NSNumber *) buyerId
                         createdAt:(NSDate *) createdAt
                           message:(NSString *) message
                         recipient:(NSString *) recipient
                          sellerId:(NSNumber *) sellerId;

- (instancetype) initWithBuyerId:(NSNumber *) buyerId
                         message:(NSString *) message
                       recipient:(NSString *) recipient
                        sellerId:(NSNumber *) sellerId;

- (instancetype) initWithJson:(NSData *) data;

@end