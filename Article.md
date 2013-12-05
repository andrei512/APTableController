# Table views made easy

Most iOS app use table views in a way or another to display lists of data. Objective-C and iOS has changed a lot recently. Table views on the other hand got only a few improvements. Let's discuss the problems UITableView has and a solution to them.

One of the things I disliked about table views is all the [boilerplate](http://en.wikipedia.org/wiki/Boilerplate_code) that comes along:
* register a nib for each of the cells respective unique identifier
* return the numbers of sections and cells in every section (witch is ussually the count of an array..)
* implement _tableView:cellForRowAtIndexPath:_ 

All of that so you could add a table view to a controller, and a lot more if you what to enable other features.
The worst part is that you have to do the same work all over again the next time you use a table view.

Another thing that bothered me was that the API felt a bit backwards sometimes, like asking for the cell height and after for the cell instead of asking just for the cell.

Lets say you have a list of items(like blog posts) in your app and you want to show them in a table view.
This is a common way to implement that:
``` objective-c
- (void)viewDidLoad {
    ...
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ItemCell" bundle:nil]
         forCellReuseIdentifier:@"itemCellReuseIdentifier"];

    ...
}

...

- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(int)sectionIndex {
  return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"itemCellReuseIdentifier"];
  
    Item *item = self.items[indexPath.row];
    [cell loadItem:item];
  
    return cell;
}
```

Now let's suppose you want to add a ad banner after the second item in the table view.
You have to change the code a little in order to do that: 
* increase the number of cells that the table view contains by one.
* check if the current index is a item or an ad. 
* if it's an ad return the ad cell.
* otherwise get the correct index of the item, load the item into a ItemCell and then return it.

All of this in order to add a different type of cell to the table view.

``` objective-c
- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(int)sectionIndex {
  return self.items.count + 1;
}

...

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.row == 2) {
    AdCell *cell = [tableView dequeueReusableCellWithIdentifier:@"adCellReuseIdentifier"];
    
    [cell loadAd];
    
    return cell;
  } else {
    ItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"itemCellReuseIdentifier"];
  
    Item *item = nil;
    if (indexPath.row < 2) {
      item = self.items[indexPath.row];
    } else {
      item = self.items[indexPath.row - 1];
    }
    [cell loadItem:item];

    return cell;
  }
}
```

If the cells have different height you have to implement the same "_if else if else ..._" structure. This affects almost all delegate methods. 

If you have multiple types of cells in a table view your code it usually looks like 

```
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (something) {
        // load first cell type
    } else if (something else) {
        // load second cell type
    } else if else if else if .... :(
    
    ...    

    } else {
        // load last cell type
    }
}
```
## Stop writing [spaghetti code](http://en.wikipedia.org/wiki/Spaghetti_code)

With a few abstractions we can create tables with less code and more flexibility.

What should be fixed:
* no more "_if else if else ..._" structures
* the code related to a section or cell should not change if we add or remove other types in a table view
* reduce the amount of boilerplate that is required to power up a table view
* make it as easy as posible to show any kind of list (by default just show the description of an object in the _textLabel_ of the table view cell)
* code should not change if the order of cells changes
* it should not be required to create subclasses in order to customize cells

## Cell and Section View Models

We can get rid of the "_if else if else ..._" structures by using [polymorphism](http://en.wikipedia.org/wiki/Polymorphism_(computer_science)

A Cell View Model is an object who contains information about creating and using a cell. 

The cell model will be resposable for creating a new cell either by registering a nib file or programmatically.
The behaviour of the cell can be customized with a few block properties for events like onLoad, onSelect, beforeReuse, that will be called by the controller.

The section view model is similar to the cell view model but it is used to customize the behaviour of a section and its cells.
This includes setting the onLoad, onSelect.. callbacks automatically for all the cells in the section.

```objc
@interface APTableCellViewModel : NSObject

@property (nonatomic, strong) NSString *cellIdentifier;
@property (nonatomic, strong) NSString *nibName;
@property (nonatomic, strong) NSObject *object;

// blocks and magic
@property (nonatomic, copy) APTableViewCellActionBlock onLoad;
@property (nonatomic, copy) APTableViewCellActionBlock beforeReuse;
@property (nonatomic, copy) APTableViewActionBlock onSelect;

// references
@property (nonatomic, weak) UIViewController *viewController;
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSIndexPath *indexPath;

...

@end

```

## Table Controller

The Controller implements both UITableViewDataSource and UITableViewDelegate protocols and uses section/cell view models to populate the table view.
A controller is responsible for creating, reusing and loading the table cell views.
The controller also has an interface for applying changes to the current models.

```objc

```

## Data normalization

Data normalization is a hack I use when writing components that use a complex data source. It's a convention based on the expected input of a method.
For example the table controller method - (void)reloadWithData:(id)data expects to receive a list of section view models to be shown in a table view. 
Every section has a list of cell view models.

The trick is that by providing partial inputs we can reproduce a "complete" input:

* If only one section view model is given we can create a list with that one
* For a list of cell view models we can create a section view model and use the previous logic to complete
* If a single cell view model is given then we could create a list with that one
* One could also create a section or cell view model with the information stored in a hash using 
```objc
+ (instancetype)cellModelWithHash:(NSDictionary *)hash;
```

* Every object can be converted into a cell view model using the 
```objc
+ (instancetype)cellModelWithObject:(id)object;
``` 

This is implemented in the following way.

You create a category on NSObject named _ConsumerClass_ that implements - (_ExpectedInputClass_)_asExpectedInput_

NSObject+_ConsumerClass_.h :

```objc
@interface NSObject (ConsumerClass)

- (ExpectedInputClass *)asExpectedInput;

@end
```

NSObject+_ConsumerClass_.m :

```objc
@implementation NSObject (ConsumerClass)

- (ExpectedInputClass *)asExpectedInput {
    return [ExpectedInputClass createWithObject:self];
}

@end
```

Now if you add a category on _NSArray you could handle different kind of list inputs.

For example this is how **_APTableController_** handles list inputs:

```objc
@implementation NSArray (APTableController)

- (NSMutableArray *)asTableSectionViewModels {
    BOOL foundArray = NO;
    for (NSObject *object in self) {
        if ([object isKindOfClass:[NSArray class]] == YES) {
            foundArray = YES;
            break;
        }
    }
    
    if (foundArray == YES) {
        return [self mapWithSelector:@selector(asTableSectionViewModel)];
    } else {
        return @[[self asTableSectionViewModel]].mutableCopy;
    }
}

- (APTableSectionViewModel *)asTableSectionViewModel {
    NSArray *cells = [self mapWithSelector:@selector(asCellViewModel)];
    return [APTableSectionViewModel sectionWithCells:cells];
}

@end
```

This pattern can be combined for multiple data types like cells and section.




