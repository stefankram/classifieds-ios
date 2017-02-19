//
// Associated Files
// ----------------
// SearchViewController.h
// SearchViewController.xib
//

#import "SearchViewController.h"

@interface SearchViewController ()

@end

@implementation SearchViewController

- (instancetype) initWithNibName:(NSString *) nibNameOrNil bundle:(NSBundle *) nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])
    {
        self.navigationItem.title = @"Search Classifieds";

        self.tabBarItem.title = @"Search";
        self.tabBarItem.image = [UIImage imageNamed:@"Search.png"];
    }

    return self;
}

@end
