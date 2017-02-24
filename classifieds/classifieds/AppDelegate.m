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
#import "Json.h"

@interface AppDelegate ()

@property (strong, nonatomic) UINavigationController *loginNav;
@property (strong, nonatomic) UINavigationController *searchNav;
@property (strong, nonatomic) UINavigationController *orderNav;
@property (strong, nonatomic) UINavigationController *accountNav;

@property (strong, nonatomic) LoginViewController *loginView;
@property (strong, nonatomic) SearchViewController *searchView;
@property (strong, nonatomic) OrderViewController *orderView;
@property (strong, nonatomic) AccountViewController *accountView;

@property (strong, nonatomic) UITabBarController *tabBar;

@end

@implementation AppDelegate

- (BOOL)          application:(UIApplication *) application
didFinishLaunchingWithOptions:(NSDictionary *) launchOptions
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"token"];
    NSString *token = [Token getToken];

    if (token)
    {
        NSURLRequest *request = [Token refreshToken:token];

        [[[NSURLSession sharedSession]
                dataTaskWithRequest:request
                  completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                  {
                      [self handleRefreshedData:data
                                       response:(NSHTTPURLResponse *) response
                                          error:error];
                  }] resume];
    }
    else
    {
        [self noToken];
    }

    return YES;
}

- (void) handleRefreshedData:(NSData *) data
                    response:(NSHTTPURLResponse *) response
                       error:(NSError *) error
{
    if (!error)
    {
        if ([response statusCode] == 200)
        {
            NSDictionary *json = [Json parseJsonObject:data];
            if (json)
            {
                [Token setToken:json[@"token"]];

                dispatch_async(dispatch_get_main_queue(), ^{
                    // Setup search controller
                    self.searchNav = [[UINavigationController alloc] init];
                    self.searchView = [[SearchViewController alloc] init];
                    self.searchNav.viewControllers = @[self.searchView];

                    // Setup order controller
                    self.orderNav = [[UINavigationController alloc] init];
                    self.orderView = [[OrderViewController alloc] init];
                    self.orderNav.viewControllers = @[self.orderView];

                    // Setup account controller
                    self.accountNav = [[UINavigationController alloc] init];
                    self.accountView = [[AccountViewController alloc] init];
                    self.accountNav.viewControllers = @[self.accountView];

                    // Setup the tab bar
                    self.tabBar = [[UITabBarController alloc] init];
                    self.tabBar.viewControllers = @[self.searchNav, self.orderNav, self.accountNav];

                    // Set the window root view controller and properties
                    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
                    self.window.rootViewController = self.tabBar;
                    self.window.backgroundColor = [UIColor whiteColor];
                    [self.window makeKeyAndVisible];
                });
            }
            else
            {
                // Malformed JSON
            }
        }
        else if ([response statusCode] == 400)
        {
            // Token is expired for a particular user
        }
        else
        {
            // Server error
        }
    }
    else
    {
        // No internet
    }
}

- (void) noToken
{
    // Setup the login controller
    self.loginNav = [[UINavigationController alloc] init];
    self.loginView = [[LoginViewController alloc] init];
    self.loginNav.viewControllers = @[self.loginView];

    // Set the window root view controller and properties
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = self.loginNav;
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
