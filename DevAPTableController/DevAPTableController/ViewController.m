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
                cell.frame = CGRectMake(0, 0, 320, 80);
            }
        },
        @[
            @"ana",
            @"are",
            @"mere"
        ]
    ];
    PO([self.tableController sectionsFromData:nestedArray])
    
    NSMutableArray *longArray = [NSMutableArray array];
    
    for (int i = 0; i < 100; ++i) {
        NSString *cellTitle = [NSString stringWithFormat:@"cell #%d", i];
        if (i % 2 == 0) {
            [longArray addObject:@{
                kObject : cellTitle
            }];
        } else {
            [longArray addObject:@{
                kObject : cellTitle,
                kOnLoad : ^(APTableCell *cell) {
                    cell.backgroundColor = [UIColor redColor];
                }
             }];
        }
    }
    
    [self.tableController reloadWithData:nestedArray];
}

@end
