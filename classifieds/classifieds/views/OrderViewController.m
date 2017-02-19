//
// Associated Files
// ----------------
// OrderViewController.h
// OrderViewController.xib
//

#import "OrderViewController.h"

@interface OrderViewController ()

@end

@implementation OrderViewController

- (instancetype) initWithNibName:(NSString *) nibNameOrNil bundle:(NSBundle *) nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])
    {
        self.navigationItem.title = @"Past Orders";

        self.tabBarItem.title = @"Orders";
        self.tabBarItem.image = [UIImage imageNamed:@"Orders.png"];
    }

    return self;
}

@end
