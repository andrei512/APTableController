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
5. In your view controller add:
