//
//  ViewController.h
//  TestAPTableController
//
//  Created by Andrei Puni on 12/6/13.
//  Copyright (c) 2013 Andrei Puni. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <APTableController/APTableController.h>
#import <AFNetworking.h>
#import <APUtils.h>

@interface ViewController : UIViewController

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) IBOutlet APTableController *tableController;

@property (nonatomic, strong) NSArray *posts;

@end
