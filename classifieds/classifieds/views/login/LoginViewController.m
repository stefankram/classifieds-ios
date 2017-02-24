//
// Associated Files
// ----------------
// LoginViewController.h
// LoginViewController.xib
//

#import "LoginViewController.h"
#import "LoginCreateViewController.h"
#import "Json.h"
#import "Token.h"

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *userField;
@property (weak, nonatomic) IBOutlet UITextField *passField;

@property (strong, nonatomic) LoginCreateViewController *createView;

@end

@implementation LoginViewController

- (instancetype) initWithNibName:(NSString *) nibNameOrNil
                          bundle:(NSBundle *) nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil
                               bundle:nibBundleOrNil])
    {
        self.navigationItem.title = @"Login to Classifieds";
        self.createView = [[LoginCreateViewController alloc] init];
    }

    return self;
}

- (IBAction) login:(id) sender
{
    NSURLRequest *request = [Token obtainWithUsername:self.userField.text
                                             password:self.passField.text];

    [[[NSURLSession sharedSession]
            dataTaskWithRequest:request
              completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
              {
                  [self handleLoginWithData:data
                                     response:(NSHTTPURLResponse *) response
                                        error:error];
              }] resume];
}

- (void) handleLoginWithData:(NSData *) data
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
                [[NSUserDefaults standardUserDefaults] setValue:json[@"token"]
                                                         forKey:@"token"];


            }
            else
            {
                // malformed json
            }
        }
        else if ([response statusCode] == 400)
        {
            // no account
        }
        else
        {
            // server error
        }
    }
    else
    {
        // error such as not connected to internet
    }
}

- (IBAction) create:(id) sender
{
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@""
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:nil
                                                                            action:nil];

    [self.navigationController pushViewController:self.createView animated:YES];
}

@end
