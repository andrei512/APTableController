## How to use

### Instalation

#### Cocoapods

You can install APTableController into your project using [cocoapods](http://cocoapods.org)

```
pod 'APTableController', :git => "https://github.com/andrei512/APTableController.git"
```

#### Manual

Just drag and drop the files from the Classes directory.

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

#### Programmatically

ViewController.h:

```Objective-C
#import <UIKit/UIKit.h>
#import <APTableController/APTableController.h>

@interface ViewController : UIViewController


@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) APTableController *tableController;

@end
```

If you run the project it should look like this:

![simple table](http://i.imgur.com/JYprejN.png)

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
