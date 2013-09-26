//
//  ViewController.m
//  DevAPTableController
//
//  Created by Andrei Puni on 9/25/13.
//  Copyright (c) 2013 Andrei Puni. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableController reloadWithData:@[@"a cell", @"another cell", @"last cell"]];    
}

@end
