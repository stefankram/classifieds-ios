//
// Associated Files
// ----------------
// AppDelegate.h
//

#import "AppDelegate.h"
#import "SearchViewController.h"
#import "OrderViewController.h"
#import "AccountViewController.h"

@interface AppDelegate ()

@property (strong, nonatomic) UINavigationController *searchNav;
@property (strong, nonatomic) UINavigationController *orderNav;
@property (strong, nonatomic) UINavigationController *accountNav;

@property (strong, nonatomic) SearchViewController *searchView;
@property (strong, nonatomic) OrderViewController *orderView;
@property (strong, nonatomic) AccountViewController *accountView;

@property (strong, nonatomic) UITabBarController *tabBar;

@end

@implementation AppDelegate

- (BOOL) application:(UIApplication *) application didFinishLaunchingWithOptions:(NSDictionary *) launchOptions
{
    // Initialize the window
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    // Setup search controller
    self.searchNav = [[UINavigationController alloc] init];
    self.searchView = [[SearchViewController alloc] init];\
    self.searchNav.viewControllers = @[self.searchView];

    // Setup order controller
    self.orderNav = [[UINavigationController alloc] init];
    self.orderView = [[OrderViewController alloc] init];\
    self.orderNav.viewControllers = @[self.orderView];

    // Setup account controller
    self.accountNav = [[UINavigationController alloc] init];
    self.accountView = [[AccountViewController alloc] init];\
    self.accountNav.viewControllers = @[self.accountView];

    // Setup the tab bar
    self.tabBar = [[UITabBarController alloc] init];
    self.tabBar.viewControllers = @[self.searchNav, self.orderNav, self.accountNav];

    // Set the window root view controller and properties
    self.window.rootViewController = self.tabBar;
    self.window.backgroundColor = [UIColor whiteColor];

    // Make the window visible
    [self.window makeKeyAndVisible];

    return YES;
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
