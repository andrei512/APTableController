APTableController
=================

I started working on a [tutorial](HowToUse.md) and this [article](Article.md) that gets into more depth. 

## Quick Examples

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

## What APTableController does for you

### conventions
### cellIdentifier
### cell height - just change the cell frame
### etc.

[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/andrei512/aptablecontroller/trend.png)](https://bitdeli.com/free "Bitdeli Badge")
