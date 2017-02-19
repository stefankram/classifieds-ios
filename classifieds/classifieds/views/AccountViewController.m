//
// Associated Files
// ----------------
// AccountViewController.h
// AccountViewController.xib
//

#import "AccountViewController.h"

@interface AccountViewController ()

@end

@implementation AccountViewController

- (instancetype) initWithNibName:(NSString *) nibNameOrNil bundle:(NSBundle *) nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])
    {
        self.navigationItem.title = @"Account Settings";

        self.tabBarItem.title = @"Account";
        self.tabBarItem.image = [UIImage imageNamed:@"Account.png"];
    }

    return self;
}

@end
