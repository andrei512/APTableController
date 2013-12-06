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

    [self.tableController reloadWithData:@[@"Testing", @"APTableController"]];
}

@end
