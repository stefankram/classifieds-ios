//
//  CreateUserViewController.m
//  classifieds
//
//  Created by Stefan Kramreither on 2017-02-24.
//  Copyright © 2017 Stefan Kramreither. All rights reserved.
//

#import "CreateUserViewController.h"
#import "UserModel.h"
#import "UserStore.h"
#import "CreateAddressViewController.h"

@interface CreateUserViewController ()

@property (nonatomic, weak) IBOutlet UITextField *firstNameField;
@property (nonatomic, weak) IBOutlet UITextField *lastNameField;
@property (nonatomic, weak) IBOutlet UITextField *emailField;
@property (nonatomic, weak) IBOutlet UITextField *passwordField;
@property (nonatomic, weak) IBOutlet UITextField *retypePasswordField;

@end

@implementation CreateUserViewController

/* INIT Method */
- (instancetype) initWithNibName:(NSString *) nibNameOrNil
                          bundle:(NSBundle *) nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil
                               bundle:nibBundleOrNil])
    {
        self.navigationItem.title = @"Create Account";

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
    NSString *firstName = self.firstNameField.text;
    NSString *lastName = self.lastNameField.text;
    NSString *email = self.emailField.text;
    NSString *password = self.passwordField.text;
    NSString *retypePassword = self.retypePasswordField.text;

    // Validation checking

    UserModel *user = [[UserModel alloc] initWithEmail:email
                                             firstName:firstName
                                              lastName:lastName
                                              password:password
                                              username:email];

    [UserStore createUser:user
                onSuccess:^(UserModel *model)
                {
                    [self userCreateSuccess:model];
                }
                   onFail:^(NSString *error)
                   {
                       [self userCreateFail:error];
                   }];
}

- (void) userCreateFail:(NSString *) error
{
    NSLog(@"User create fail: %@", error);
}

- (void) userCreateSuccess:(UserModel *) userModel
{
    [[NSUserDefaults standardUserDefaults] setValue:userModel.userId
                                             forKey:@"user_id"];

    dispatch_async(dispatch_get_main_queue(), ^
    {
        [self.navigationController
                pushViewController:[[CreateAddressViewController alloc] init]
                          animated:YES];
    });
}

/* CANCEL click */
- (IBAction) cancel:(id) sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
