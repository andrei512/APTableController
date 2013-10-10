# APTableViewController - Table views made easy

Table views are one of the most used components from UIKit.. 

One of the things I disliked about table views is all the boilerplate that comes along:
* register the cells
* return the numbers of sections and cells in every section (witch is ussually the count of an array..)
* implement tablView:cellForRowAtIndexPath: 

All of that everythime so you could add a table view to a controller, and a lot more if you what to do things like deleting a cell.

Another thing that bothered me was that the API felt a bit backwards, like asking for the cell height and after for the cell instead of asking just for the cell.

Let me give you another example. Lets say you have a list of items in a store in your app.
This is a common way to implement that:
``` objective-c
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"itemCellReuseIdentifier"];
  
    Item *item = self.items[indexPath.row];
    [cell loadItem:item];
  
    return cell;
}
```

Now let's suppose you want to add a ad banner after the second item in the table.
You have to change the code a little: 
* increase the number of cells that the section contains by one.
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

With a few abstractions we can create tables with much less code and much more flexibility.

## Cell and Section View Models

A Cell View Model is an object who contains information about creating and using a cell. 

A cell view model is responsible for creating, reusing and loading the cell view.
The cell model uses the nib property to create the cell view nib and registeres it to the cell identifiers.
The behaviour of the cell can be customized with a few block properties like onLoad, onSelect, beforeReuse, that will be called by the controller.

The section view model is similar to the cell view model but it properties are used to customize the behaviour of a section.
This incluse setting the onLoad, onSelect.. callbacks automatically for all the cells in the section.




## Table Controller

The Controller implements boath UITableViewDataSource and UITableViewDelegate protocols and uses section/cell view models to implement them.
The controller alse has an interface for applying changes to the current #model.

## Data normalization

Data normalization is a hack i use when writing general components. It's a convention based on the expected input of a method.
For example - (void)reloadWithData:(id)data expects to receive a list of sections to be shown in a table view. 
If I where to give it only one section i could create a list with that section and have a list of sections.
If a single cell view model is given then i could create a section with that cell and use the previous steps to remove the ambiguity in the input.
This also applies to a list of cells.
One could also create a section or cell with the information stored in a hash.

This is implemented in the following way.

You create a category on NSObject named _asExpectedInput_





