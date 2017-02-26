//
// Associated Files
// ----------------
// AppDelegate.h
//

#import "AppDelegate.h"
#import "SearchViewController.h"
#import "OrderViewController.h"
#import "AccountViewController.h"
#import "LoginViewController.h"
#import "Token.h"

@implementation AppDelegate

- (BOOL)          application:(UIApplication *) application
didFinishLaunchingWithOptions:(NSDictionary *) launchOptions
{
    NSString *token = [[NSUserDefaults standardUserDefaults] stringForKey:@"token"];

    if (token)
    {
        [Token refreshWithToken:token
                      onSuccess:^(NSString *newToken)
                      {
                          [self refreshTokenSuccess:newToken];
                      }
                         onFail:^(NSString *error)
                         {
                             [self refreshTokenFail:error];
                         }];
    }
    else
    {
        [self noToken];
    }

    return YES;
}

- (void) refreshTokenFail:(NSString *) error
{
    NSLog(@"Refresh token fail: %@", error);
}

- (void) refreshTokenSuccess:(NSString *) newToken
{
    [[NSUserDefaults standardUserDefaults] setObject:newToken
                                              forKey:@"token"];

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

        // Set the window root view controller and properties
        self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        self.window.rootViewController = tabBar;
        self.window.backgroundColor = [UIColor whiteColor];
        [self.window makeKeyAndVisible];
    });
}

- (void) noToken
{
    // Setup the login controller
    UINavigationController *loginNav = [[UINavigationController alloc] init];
    LoginViewController *loginView = [[LoginViewController alloc] init];
    loginNav.viewControllers = @[loginView];

    // Set the window root view controller and properties
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = loginNav;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
}

- (void) applicationWillResignActive:(UIApplication *) application
{}

- (void) applicationDidEnterBackground:(UIApplication *) application
{}

- (void) applicationWillEnterForeground:(UIApplication *) application
{}

- (void) applicationDidBecomeActive:(UIApplication *) application
{}

- (void) applicationWillTerminate:(UIApplication *) application
{}

@end
