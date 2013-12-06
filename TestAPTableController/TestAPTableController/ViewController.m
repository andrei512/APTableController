//
//  ViewController.m
//  TestAPTableController
//
//  Created by Andrei Puni on 12/6/13.
//  Copyright (c) 2013 Andrei Puni. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

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
