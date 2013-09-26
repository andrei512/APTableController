APTableController
=================

! Work in progress

## How to use

In your Xib/Storyboard connect the tableView IBOutlet from APTableController with the table view

``` objective-c
[tableController reloadWithData:@[@"this is a cell", @"and this is also a cell"]];
```

``` objective-c
[self.tableController reloadWithData:@"A simple cell"];
```
![One cell](http://i.imgur.com/SdXQe2Z.png)

``` objective-c
[self.tableController reloadWithData:@[@"cell #1", @"cell #2", @"cell #3"]];
```
![Many cells](http://i.imgur.com/jXPYCUi.png)

``` objective-c
[self.tableController reloadWithData:@[
    @{
        kObject : @"cell #1",
        kOnLoad : ^(APTableCell *cell) {
            cell.textLabel.textColor = [UIColor redColor];
        }
    },
    @"cell #2",
    @"cell #3"
]];
```
![Many cells with color](http://i.imgur.com/fHJc1RQ.png)

``` objective-c
[self.tableController reloadWithData:@[
    @{
        kObject : @"cell #1",
        kOnSelect : ^{
            [[[UIAlertView alloc] initWithTitle:@"Hello World!"
                                       message:nil
                                      delegate:nil
                             cancelButtonTitle:@"OK"
                              otherButtonTitles:nil] show];
        }
    },
    @"cell #2",
    @"cell #3"
]];
```
![Many cells with action](http://i.imgur.com/bZXSe3h.png)

``` objective-c
[self.tableController reloadWithData:@[
    @[@"cell #1.1", @"cell #1.2", @"cell #1.3"],
    @[@"cell #2.1", @"cell #2.2", @"cell #2.3"],
    @[@"cell #3.1", @"cell #3.2", @"cell #3.3"],
]];
```
![Many sections](http://i.imgur.com/FPXaEJJ.png)

## Data normalization

- [ ] examples
- [ ] under the hood
- [ ] how to implement your own 

## What APTableController does for you

### conventions
### cellIdentifier
### cell height - just change the cell frame
### etc.
