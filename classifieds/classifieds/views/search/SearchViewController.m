//
// Associated Files
// ----------------
// SearchViewController.h
// SearchViewController.xib
//

#import "SearchViewController.h"
#import "SearchPastViewController.h"
#import "SearchResultViewController.h"
#import "SearchModel.h"
#import "ItemModel.h"
#import "ItemStore.h"

@interface SearchViewController ()

@property (weak, nonatomic) IBOutlet UITextField *searchField;
@property (weak, nonatomic) IBOutlet UITextView *descField;

@property (strong, nonatomic) SearchPastViewController *historyView;
@property (strong, nonatomic) SearchResultViewController *resultView;

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

        self.historyView = [[SearchPastViewController alloc] init];
        self.resultView = [[SearchResultViewController alloc] init];
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

/* HISTORY click */
- (IBAction) history:(id) sender
{
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]
            initWithTitle:@""
                    style:UIBarButtonItemStylePlain
                   target:nil
                   action:nil];

    [self.navigationController pushViewController:self.historyView
                                         animated:YES];
}

/* SEARCH click */
- (IBAction) search:(id) sender
{
    NSString *name = self.searchField.text;
    NSString *desc = self.descField.text;

    [ItemStore findByName:name
                onSuccess:^(ItemModel *model)
                {
                    [self itemSuccess:model];
                }
                   onFail:^(NSString *error)
                   {
                       NSLog(@"%@", error);
                   }];
}

- (void) itemSuccess:(ItemModel *) item
{


    /*self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]
            initWithTitle:@""
                    style:UIBarButtonItemStylePlain
                   target:nil
                   action:nil];

    [self.navigationController pushViewController:self.resultView
                                         animated:YES];*/
}

@end
