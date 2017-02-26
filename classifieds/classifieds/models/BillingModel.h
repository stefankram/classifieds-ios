//
// Created by Stefan Kramreither on 2017-02-23.
// Copyright (c) 2017 Stefan Kramreither. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BillingModel : NSObject

@property (nonatomic, copy) NSNumber *billingId;
@property (nonatomic, copy) NSString *cardNetwork;
@property (nonatomic, copy) NSString *cardNumber;
@property (nonatomic, copy) NSString *cardSecurityCode;
@property (nonatomic, copy) NSDate *cardExpiry;

- (instancetype) initWithBillingId:(NSNumber *) billingId
                       cardNetwork:(NSString *) cardNetwork
                        cardNumber:(NSString *) cardNumber
                  cardSecurityCode:(NSString *) cardSecurityCode
                        cardExpiry:(NSDate *) cardExpiry;

- (instancetype) initWithCardNetwork:(NSString *) cardNetwork
                        cardNumber:(NSString *) cardNumber
                  cardSecurityCode:(NSString *) cardSecurityCode
                        cardExpiry:(NSDate *) cardExpiry;

- (instancetype) initWithJson:(NSData *) data;

@end