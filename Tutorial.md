# APTableViewController - Table views made easy

Table views are one of the most used components from UIKit.
One of the thigs I disliked about table views is all the boilerplate that comes along.
Register the cells, return the numbers of sections and cells in every section, implement tablView:cellForRowAtIndexPath: ...
All of that everythime so you could add a table view to a controller.

Another thing that bothered me was that the API felt a bit backwords. 
Let me give you an example. Lets say you have a list of items in a store in your app.
This is a common way to implement that:
``` objective-c
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  ItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"itemCellReuseIdentifier"];
  
  Item *item = self.items[indexPath.row];
  [cell loadItem:item];
  

  return cell;
}
```

Now let's supose you want to add a ad banner after the second item in the table.
You have to change the code a little. 
Increase the number of cells that the section contains by one.
Check if the current index is a item or an ad. 
If it's an ad return the ad cell.
Otherwise get the correct index of the item, load the item into a ItemCell and then return it.
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


