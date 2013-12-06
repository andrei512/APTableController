## How to use

### Instalation

#### Cocoapods

You can install APTableController into your project using [cocoapods](http://cocoapods.org)

```ruby
pod 'APTableController', :git => "https://github.com/andrei512/APTableController.git"
```

#### Manual 

Just copy the files from the Classes directory into your project.

### Creating a table controller

#### Using nibs/story boards

1. add a custom object and switch the class to APTableController:
    * ![add custom object](http://i.imgur.com/XWj9agy.png)
    * ![rename class](http://i.imgur.com/HPSXJJ1.png)
2. connect the tableView IBOutlet from APTableController with the table view:
    * ![connect tableView](http://i.imgur.com/oI1wkfD.png)
3. connect the viewController IBOutlet from APTableController with the table view (this is optional, the only thing that happens is that the table controller does not know in which view controller is presented:
    * ![connect viewController](http://i.imgur.com/SPBKzdP.png)
4. get a referecing ooutlet for the tableController so you can use it:
    * ![keep outlet](http://i.imgur.com/qjOb5Mq.png)
5. In your view controller add:

ViewController.m
```Objective-C
#import "ViewController.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // avoid the status bar
    self.tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);

    [self.tableController reloadWithData:@[@"Testing", @"APTableController"]];
}

@end
```

If you run the project it should look like this:

![simple table](http://i.imgur.com/JYprejN.png)


#### Programmatically

1. add properties for the table view and the table controller
2. create and add the table view to the view
3. create the controller and set the viewController and tableView properties
4. load any data into the table :)

ViewController.h:

```Objective-C
#import <UIKit/UIKit.h>
#import <APTableController/APTableController.h>

@interface ViewController : UIViewController


@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) APTableController *tableController;

@end
```

ViewController.m
```Objective-C
#import "ViewController.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self addTableController];
    
    [self loadCells];
}

- (void)addTableController {
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds
                                                  style:UITableViewStylePlain];
    // avoid the status bar
    self.tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
    [self.view addSubview:self.tableView];
    
    self.tableController = [APTableController new];
    self.tableController.viewController = self;
    self.tableController.tableView = self.tableView;
}

- (void)loadCells {
    [self.tableController reloadWithData:@[@"Testing", @"APTableController"]];
}

@end
```

### Creating Custom Cells and CellModels

Let's make a app that displayes the posts from [r/iosprogramming](http://reddit.com/r/iosprogramming) using custom cells.

For the api request we are goin to use the [AFNetworking](https://github.com/AFNetworking/AFNetworking) [cocoapod](http://cocoapods.org).

```Objective-c
- (void)getPosts {
    NSString *postsPath = @"http://www.reddit.com/r/iosprogramming.json";
    
    AFHTTPRequestOperationManager *manager =
        [AFHTTPRequestOperationManager manager];
    [manager GET:postsPath
      parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *rawPosts = responseObject[@"data"][@"children"];
        self.posts = [rawPosts mapWithBlock:^id(NSDictionary *postInfo) {
            return postInfo[@"data"];
        }];
             
        [self reloadCells];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}
```

First we will create the table with the default cells in order to understand the structure that the table controller expects.

```Objective-C
- (void)reloadCells {
    NSMutableArray *cells = [NSMutableArray array];

    // For each post create a cell view model
    for (NSDictionary *post in self.posts) {
        APTableCellViewModel *cellModel =
            [APTableCellViewModel cellModelWithObject:post[@"title"]];
        [cells addObject:cellModel];
    }
    
    // Group all the cells into a section view model
    APTableSectionViewModel *sectionModel =
        [APTableSectionViewModel sectionWithCells:cells];

    // Create a list containing the section    
    NSMutableArray *sections = [NSMutableArray arrayWithObject:sectionModel];

    // Set the sections property of the controller
    self.tableController.sections = sections;
    
    // reload the table
    [self.tableController reloadTableView];
}
```

The project should look like this now:

![default cell](http://i.imgur.com/g8wB3tl.png)























