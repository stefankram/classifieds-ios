//
//  CreateAddressViewController.m
//  classifieds
//
//  Created by Stefan Kramreither on 2017-02-24.
//  Copyright © 2017 Stefan Kramreither. All rights reserved.
//

#import "CreateAddressViewController.h"
#import "AddressModel.h"
#import "AddressStore.h"
#import "CreateBillingViewController.h"

@interface CreateAddressViewController ()

@property (weak, nonatomic) IBOutlet UITextField *streetField;
@property (weak, nonatomic) IBOutlet UITextField *cityField;
@property (weak, nonatomic) IBOutlet UITextField *provinceField;
@property (weak, nonatomic) IBOutlet UITextField *countryField;
@property (weak, nonatomic) IBOutlet UITextField *postalCodeField;

@end

@implementation CreateAddressViewController

/* INIT method */
- (instancetype) initWithNibName:(NSString *) nibNameOrNil
                          bundle:(NSBundle *) nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil
                               bundle:nibBundleOrNil])
    {
        self.navigationItem.title = @"Add Address";

        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]
                initWithTitle:@"Cancel"
                        style:UIBarButtonItemStylePlain
                       target:self
                       action:@selector(cancel:)];

        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
                initWithTitle:@"Next"
                        style:UIBarButtonItemStylePlain
                       target:self
                       action:@selector(next:)];
    }

    return self;
}

/* NEXT click */
- (IBAction) next:(id) sender
{
    NSString *city = self.cityField.text;
    NSString *country = self.countryField.text;
    NSString *postalCode = self.postalCodeField.text;
    NSString *province = self.provinceField.text;
    NSString *street = self.streetField.text;

    // Validate fields

    AddressModel *address = [[AddressModel alloc] initWithCity:city
                                                       country:country
                                                    postalCode:postalCode
                                                      province:province
                                                        street:street];

    [AddressStore createAddress:address
                          onSuccess:^(AddressModel *model)
                          {
                              [self addressCreateSuccess:model];
                          }
                             onFail:^(NSString *error)
                             {
                                 [self addressCreateFail:error];
                             }];
}

- (void) addressCreateFail:(NSString *) error
{
    NSLog(@"Address create fail: %@", error);
}

- (void) addressCreateSuccess:(AddressModel *) addressModel
{
    [[NSUserDefaults standardUserDefaults] setValue:addressModel.addressId
                                             forKey:@"address_id"];

    dispatch_async(dispatch_get_main_queue(), ^
    {
        [self.navigationController
                pushViewController:[[CreateBillingViewController alloc] init]
                          animated:YES];
    });
}

/* CANCEL click */
- (IBAction) cancel:(id) sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
