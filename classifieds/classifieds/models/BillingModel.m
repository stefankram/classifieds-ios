//
// Created by Stefan Kramreither on 2017-02-23.
// Copyright (c) 2017 Stefan Kramreither. All rights reserved.
//

#import "BillingModel.h"
#import "Json.h"

@implementation BillingModel

- (instancetype) initWithBillingId:(NSNumber *) billingId
                       cardNetwork:(NSString *) cardNetwork
                        cardNumber:(NSString *) cardNumber
                  cardSecurityCode:(NSString *) cardSecurityCode
                        cardExpiry:(NSDate *) cardExpiry
{
    if (self = [super init])
    {
        self.billingId = billingId;
        self.cardNetwork = cardNetwork;
        self.cardNumber = cardNumber;
        self.cardSecurityCode = cardSecurityCode;
        self.cardExpiry = cardExpiry;
    }

    return self;
}

- (instancetype) initWithCardNetwork:(NSString *) cardNetwork
                          cardNumber:(NSString *) cardNumber
                    cardSecurityCode:(NSString *) cardSecurityCode
                          cardExpiry:(NSDate *) cardExpiry
{
    return [self initWithBillingId:nil
                       cardNetwork:cardNetwork
                        cardNumber:cardNumber
                  cardSecurityCode:cardSecurityCode
                        cardExpiry:cardExpiry];
}

- (instancetype) initWithJson:(NSData *) data
{
    NSDictionary *json = [Json parseJsonObject:data];

    if (json)
    {
        return [self initWithBillingId:json[@"id"]
                           cardNetwork:json[@"card_network"]
                            cardNumber:json[@"card_number"]
                      cardSecurityCode:json[@"card_security_code"]
                            cardExpiry:json[@"card_expiry"]];
    }
    else
    {
        return nil;
    }
}

- (NSString *) description
{
    return [[NSString alloc] initWithFormat:@"%@, %@, %@, %@, %@",
                                            self.billingId,
                                            self.cardNetwork,
                                            self.cardNumber,
                                            self.cardSecurityCode,
                                            self.cardExpiry];
}

@end