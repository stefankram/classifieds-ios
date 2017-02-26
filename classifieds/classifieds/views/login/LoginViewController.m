//
// Associated Files
// ----------------
// LoginViewController.h
// LoginViewController.xib
//

#import "LoginViewController.h"
#import "Token.h"
#import "CreateUserViewController.h"
#import "SearchViewController.h"
#import "OrderViewController.h"
#import "AccountViewController.h"
#import "UserStore.h"
#import "BuyerStore.h"
#import "UserModel.h"
#import "BuyerModel.h"

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *userField;
@property (weak, nonatomic) IBOutlet UITextField *passField;

@end

@implementation LoginViewController

/* INIT method */
- (instancetype) initWithNibName:(NSString *) nibNameOrNil
                          bundle:(NSBundle *) nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil
                               bundle:nibBundleOrNil])
    {
        self.navigationItem.title = @"Login to Classifieds";
    }

    return self;
}

/* LOGIN click */
- (IBAction) login:(id) sender
{
    NSString *username = self.userField.text;
    NSString *password = self.passField.text;

    // Validate input

    [Token obtainWithUsername:username
                     password:password
                    onSuccess:^(NSString *token)
                    {
                        [self obtainTokenSuccess:token
                                        username:username];
                    }
                       onFail:^(NSString *error)
                       {
                           [self obtainTokenFail:error];
                       }];
}

- (void) obtainTokenFail:(NSString *) error
{
    NSLog(@"Obtain token fail: %@", error);
}

- (void) obtainTokenSuccess:(NSString *) token
                   username:(NSString *) username
{
    [[NSUserDefaults standardUserDefaults] setObject:token
                                              forKey:@"token"];

    [UserStore findByUsername:username
                    onSuccess:^(UserModel *model)
                    {
                        [self findByUsernameSuccess:model];
                    }
                       onFail:^(NSString *error)
                       {
                           [self findByUsernameFail:error];
                       }];
}

- (void) findByUsernameFail:(NSString *) error
{
    NSLog(@"Find by username fail: %@", error);
}

- (void) findByUsernameSuccess:(UserModel *) userModel
{
    [BuyerStore findByUserId:userModel.userId
                   onSuccess:^(BuyerModel *model)
                   {
                       [self findByUserIdSuccess:model];
                   }
                      onFail:^(NSString *error)
                      {
                          [self findByUserIdFail:error];
                      }];
}

- (void) findByUserIdFail:(NSString *) error
{
    NSLog(@"Find by user id fail: %@", error);
}

- (void) findByUserIdSuccess:(BuyerModel *) buyerModel
{
    [[NSUserDefaults standardUserDefaults] setObject:buyerModel.buyerId
                                              forKey:@"buyer_id"];

    dispatch_async(dispatch_get_main_queue(), ^
    {
        // Setup search controller
        UINavigationController *searchNav = [[UINavigationController alloc] init];
        SearchViewController *searchView = [[SearchViewController alloc] init];
        searchNav.viewControllers = @[searchView];

        // Setup order controller
        UINavigationController *orderNav = [[UINavigationController alloc] init];
        OrderViewController *orderView = [[OrderViewController alloc] init];
        orderNav.viewControllers = @[orderView];

        // Setup account controller
        UINavigationController *accountNav = [[UINavigationController alloc] init];
        AccountViewController *accountView = [[AccountViewController alloc] init];
        accountNav.viewControllers = @[accountView];

        // Setup the tab bar
        UITabBarController *tabBar = [[UITabBarController alloc] init];
        tabBar.viewControllers = @[searchNav, orderNav, accountNav];

        [self presentViewController:tabBar animated:YES completion:nil];
    });
}

/* CREATE click */
- (IBAction) create:(id) sender
{
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]
            initWithTitle:@"Cancel"
                    style:UIBarButtonItemStylePlain
                   target:nil
                   action:nil];

    [self.navigationController
            pushViewController:[[CreateUserViewController alloc] init]
                      animated:YES];
}

@end
