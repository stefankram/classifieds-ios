//
// Associated Files
// ----------------
// SearchViewController.h
// SearchViewController.xib
//

#import "SearchViewController.h"
#import "SearchHistoryViewController.h"
#import "SearchResultViewController.h"
#import "ItemModel.h"
#import "ItemStore.h"
#import "SearchStore.h"
#import "SearchModel.h"

@interface SearchViewController ()

@property (weak, nonatomic) IBOutlet UITextField *searchField;
@property (weak, nonatomic) IBOutlet UITextView *descField;

@property (strong, nonatomic) SearchHistoryViewController *historyView;

@end

@implementation SearchViewController

/* INIT method */
- (instancetype) initWithNibName:(NSString *) nibNameOrNil
                          bundle:(NSBundle *) nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil
                               bundle:nibBundleOrNil])
    {
        self.navigationItem.title = @"Search Classifieds";
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]
                initWithTitle:@"History"
                        style:UIBarButtonItemStylePlain
                       target:self
                       action:@selector(history:)];

        self.tabBarItem.title = @"Search";
        self.tabBarItem.image = [UIImage imageNamed:@"Search.png"];

        self.historyView = [[SearchHistoryViewController alloc] init];
    }

    return self;
}

/* VIEW overrides */
- (void) viewDidLoad
{
    [super viewDidLoad];

    self.descField.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.descField.layer.borderWidth = 1.0f;
    self.descField.layer.cornerRadius = 8;
}

/* SEARCH click */
- (IBAction) search:(id) sender
{
    NSString *name = self.searchField.text;
    NSString *desc = self.descField.text;

    // Validate input

    [ItemStore findByName:name
                onSuccess:^(ItemModel *model)
                {
                    [self findItemSuccess:model
                              description:desc];
                }
                   onFail:^(NSString *error)
                   {
                       [self findItemFail:error];
                   }];
}

- (void) findItemFail:(NSString *) error
{
    NSLog(@"Find item fail: %@", error);
}

- (void) findItemSuccess:(ItemModel *) item
             description:(NSString *) desc
{
    NSNumber *buyerId = [[NSUserDefaults standardUserDefaults] objectForKey:@"buyer_id"];

    SearchModel *search = [[SearchModel alloc] initWithBuyerId:buyerId
                                                   description:desc
                                                        itemId:item.itemId];

    [SearchStore createSearch:search
                    onSuccess:^(SearchModel *model)
                    {
                        [self createSearchSuccess:model];
                    }
                       onFail:^(NSString *error)
                       {
                           [self createSearchFail:error];
                       }];
}

- (void) createSearchFail:(NSString *) error
{
    NSLog(@"Create search fail: %@", error);
}

- (void) createSearchSuccess:(SearchModel *) searchModel
{
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]
            initWithTitle:@"Home"
                    style:UIBarButtonItemStylePlain
                   target:nil
                   action:nil];

    dispatch_async(dispatch_get_main_queue(), ^
    {
        [self.navigationController
                pushViewController:[[SearchResultViewController alloc] initWithSearchModel:searchModel]
                          animated:YES];
    });
}

/* HISTORY click */
- (IBAction) history:(id) sender
{
    NSNumber *buyerId = [[NSUserDefaults standardUserDefaults]
            objectForKey:@"buyer_id"];

    [SearchStore findAllWithBuyerId:buyerId
                          onSuccess:^()
                          {
                              [self findAllSearchesSuccess];
                          }
                             onFail:^(NSString *error)
                             {
                                 [self findAllSearchesFail:error];
                             }];
}

- (void) findAllSearchesFail:(NSString *) error
{
    NSLog(@"Find all searches fail: %@", error);
}

- (void) findAllSearchesSuccess
{
    dispatch_async(dispatch_get_main_queue(), ^
    {
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]
                initWithTitle:@""
                        style:UIBarButtonItemStylePlain
                       target:nil
                       action:nil];

        [self.navigationController pushViewController:self.historyView
                                             animated:YES];
    });
}

@end
