//
// Associated Files
// ----------------
// SearchPastViewController.h
// SearchPastViewController.xib
//

#import "SearchPastViewController.h"

@interface SearchPastViewController ()

@end

@implementation SearchPastViewController

- (instancetype) initWithStyle:(UITableViewStyle) style
{
    if (self = [super initWithStyle:UITableViewStylePlain])
    {
        self.navigationItem.title = @"Search History";

    }

    return self;
}

- (void) viewDidLoad
{
}

@end
