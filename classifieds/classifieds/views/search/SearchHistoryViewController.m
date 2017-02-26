//
// Associated Files
// ----------------
// SearchHistoryViewController.h
// SearchHistoryViewController.xib
//

#import "SearchHistoryViewController.h"
#import "SearchStore.h"
#import "SearchModel.h"

@interface SearchHistoryViewController ()

@end

@implementation SearchHistoryViewController

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
    [super viewDidLoad];

    [self.tableView registerClass:[UITableViewCell class]
           forCellReuseIdentifier:@"UITableViewCell"];
}

- (void) viewWillAppear:(BOOL) animated
{
    [super viewWillAppear:animated];

    [self.tableView reloadData];
}

- (NSInteger) tableView:(UITableView *) tableView
  numberOfRowsInSection:(NSInteger) section
{
    return [SearchStore searches].count;
}

- (UITableViewCell *) tableView:(UITableView *) tableView
          cellForRowAtIndexPath:(NSIndexPath *) indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"
                                                            forIndexPath:indexPath];

    cell.textLabel.text = ((SearchModel *) [SearchStore searches][(NSUInteger) indexPath.row]).desc;

    return cell;
}

- (void)      tableView:(UITableView *) tableView
didSelectRowAtIndexPath:(NSIndexPath *) indexPath
{
    // Clicked a row
}

@end
