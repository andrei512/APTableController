APTableController
=================

Check out the [tutorial](Tutorial.md) ! Work in progress

### A simple cell

``` objective-c
[self.tableController reloadWithData:@"A simple cell"];
```
![One cell](http://i.imgur.com/f3MCU5i.png)

### Many cells
``` objective-c
[self.tableController reloadWithData:@[@"cell #1", @"cell #2", @"cell #3"]];
```
![Many cells](http://i.imgur.com/Ii1AOOO.png)

### Custom loading
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
![Many cells with color](http://i.imgur.com/9kNudXi.png)

### Handling didSelect
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
![Many cells with action](http://i.imgur.com/TLkR816.png)

### Many sections
``` objective-c
[self.tableController reloadWithData:@[
    @[@"cell #1.1", @"cell #1.2", @"cell #1.3"],
    @[@"cell #2.1", @"cell #2.2", @"cell #2.3"],
    @[@"cell #3.1", @"cell #3.2", @"cell #3.3"],
]];
```
![Many sections](http://i.imgur.com/w1UTGYN.png)

## How to use

1. add a custom object and switch the class to APTableController:
    * ![add custom object](http://i.imgur.com/XWj9agy.png)
    * ![rename class](http://i.imgur.com/HPSXJJ1.png)
2. connect the tableView IBOutlet from APTableController with the table view:
    * ![connect tableView](http://i.imgur.com/oI1wkfD.png)
3. connect the viewController IBOutlet from APTableController with the table view (this is optional, the only thing that happens is that the table controller does not know in which view controller is presented:
    * ![connect viewController](http://i.imgur.com/SPBKzdP.png)
4. get a referecing ooutlet for the tableController so you can use it:
    * ![keep outlet](http://i.imgur.com/qjOb5Mq.png)



## Data normalization

- [ ] examples
- [ ] under the hood
- [ ] how to implement your own 

## What APTableController does for you

### conventions
### cellIdentifier
### cell height - just change the cell frame
### etc.
