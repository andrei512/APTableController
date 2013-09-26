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
    
    PO([self.tableController sectionsFromData:@"ana"])
    NSArray *simpleList = @[@"ana", @"are", @"mere"];
    PO([self.tableController sectionsFromData:simpleList])
    NSArray *nestedArray = @[
        @{
            kObject : @"hash cell",
            kOnLoad : ^(APTableCell *cell) {
                NSLog(@"yey");
            }
        },
        @[
            @"ana",
            @"are",
            @"mere"
        ]
    ];
    PO([self.tableController sectionsFromData:nestedArray])
    
    [self.tableController reloadWithData:nestedArray];
}

@end
