//
//  CreateBillingViewController.m
//  classifieds
//
//  Created by Stefan Kramreither on 2017-02-24.
//  Copyright © 2017 Stefan Kramreither. All rights reserved.
//

#import "CreateBillingViewController.h"
#import "BillingModel.h"
#import "BillingStore.h"
#import "BuyerModel.h"
#import "BuyerStore.h"
#import "LoginViewController.h"

@interface CreateBillingViewController ()

@property (weak, nonatomic) IBOutlet UISegmentedControl *cardNetworkControl;
@property (weak, nonatomic) IBOutlet UITextField *cardNumberField;
@property (weak, nonatomic) IBOutlet UITextField *cardSecurityCodeField;
@property (weak, nonatomic) IBOutlet UITextField *cardExpiryMonthField;
@property (weak, nonatomic) IBOutlet UITextField *cardExpiryYearField;

@end

@implementation CreateBillingViewController

/* INIT method */
- (instancetype) initWithNibName:(NSString *) nibNameOrNil
                          bundle:(NSBundle *) nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil
                               bundle:nibBundleOrNil])
    {
        self.navigationItem.title = @"Add Billing";

        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]
                initWithTitle:@"Cancel"
                        style:UIBarButtonItemStylePlain
                       target:self
                       action:@selector(cancel:)];

        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
                initWithTitle:@"Done"
                        style:UIBarButtonItemStylePlain
                       target:self
                       action:@selector(done:)];
    }

    return self;
}

/* DONE click */
- (IBAction) done:(id) sender
{
    NSString *cardNumber = self.cardNumberField.text;
    NSString *cardSecurityCode = self.cardSecurityCodeField.text;
    NSString *cardExpiryMonth = self.cardExpiryMonthField.text;
    NSString *cardExpiryYear = self.cardExpiryYearField.text;

    // Validate input

    NSString *cardNetwork;
    switch (self.cardNetworkControl.selectedSegmentIndex)
    {
        case 0:
            cardNetwork = @"VI";
            break;
        case 1:
            cardNetwork = @"MA";
            break;
        case 2:
            cardNetwork = @"AM";
            break;
        default:
            cardNetwork = nil;
    }

    NSDateComponents *createExpiry = [[NSDateComponents alloc] init];
    [createExpiry setMonth:[cardExpiryMonth integerValue]];
    [createExpiry setYear:[cardExpiryYear integerValue]];
    NSDate *cardExpiry = [[NSCalendar currentCalendar] dateFromComponents:createExpiry];

    NSLog(@"%@", cardExpiry);

    BillingModel *billing = [[BillingModel alloc] initWithCardNetwork:cardNetwork
                                                           cardNumber:cardNumber
                                                     cardSecurityCode:cardSecurityCode
                                                           cardExpiry:cardExpiry];

    [BillingStore createBilling:billing
                      onSuccess:^(BillingModel *model)
                      {
                          [self billingCreateSuccess:model];
                      }
                         onFail:^(NSString *error)
                         {
                             [self billingCreateFail:error];
                         }];
}

- (void) billingCreateFail:(NSString *) error
{
    NSLog(@"Billing create fail: %@", error);
}

- (void) billingCreateSuccess:(BillingModel *) billingModel
{
    NSNumber *addressId = [[NSUserDefaults standardUserDefaults]
            objectForKey:@"address_id"];
    NSNumber *userId = [[NSUserDefaults standardUserDefaults]
            objectForKey:@"user_id"];

    BuyerModel *buyer = [[BuyerModel alloc] initWithAddressId:addressId
                                                    billingId:billingModel.billingId
                                                        phone:@"4161231234"
                                                   profilePic:@"http://stefankram.com/"
                                                       userId:userId];

    [BuyerStore createBuyer:buyer
                  onSuccess:^(BuyerModel *model)
                  {
                      [self buyerCreateSuccess:model];
                  }
                     onFail:^(NSString *error)
                     {
                         [self buyerCreateFail:error];
                     }];
}

- (void) buyerCreateFail:(NSString *) error
{
    NSLog(@"Buyer create fail: %@", error);
}

- (void) buyerCreateSuccess:(BuyerModel *) buyerModel
{
    [[NSUserDefaults standardUserDefaults] setObject:buyerModel.buyerId
                                              forKey:@"buyer_id"];

    dispatch_async(dispatch_get_main_queue(), ^
    {
        [self.navigationController popToRootViewControllerAnimated:YES];
    });
}

/* CANCEL click */
- (IBAction) cancel:(id) sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
