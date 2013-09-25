APTableController
=================

! Work in progress

## How to

### With Xibs/Storyboards

In your Xib/Storyboard connect the tableView IBOutlet from APTableController with the table view

``` objective-c
[tableController reloadWithData:@[@"this is a cell", @"and this is also a cell"]];
```

...  that's it

<include screenshot>

<example with action>

<example with customization>

<example with custom class>

### Just code

``` objective-c
[tableController reloadTableView:self.tableView withData:@[@"this is a cell", @"and this is also a cell"]];
```

## Data normalization

- [ ] examples
- [ ] under the hood
- [ ] how to implement your own 

## What APTableController does for you

### conventions
### cellIdentifier
### cell height - just change the cell frame
### etc.
