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

    [self manyCellsWithColors];
}

- (void)customNib {
    [self.tableController reloadWithData:@{
        kObject  : @{
                @"name" : @"Andrei Puni",
                @"age" : @22,
                @"avatar" : @"https://0.gravatar.com/avatar/e9ef1bf7868e60724b8f9411eb781c73?d=https%3A%2F%2Fidenticons.github.com%2F9e7253bec9857715d9e81b22dbf2084e.png&s=420",
                @"bio" : @"hacker, entrepreneur"
        },
        kNibName : @"UserCell"
    }];
}

- (void)oneCell {
    [self.tableController reloadWithData:@"A simple cell"];
}

- (void)manyCells {
    [self.tableController reloadWithData:@[@"cell #1", @"cell #2", @"cell #3"]];
}

- (void)manyCellsWithColors {
    [self.tableController reloadWithData:@[
        @{
            kObject : @"cell #1",
            kOnLoad : ^(APTableCell *cell) {
                cell.textLabel.textColor = [UIColor redColor];
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }
        },
        @"cell #2",
        @"cell #3"
    ]];
}

- (void)manyCellsWithActions {
    [self.tableController reloadWithData:@[
        @{
            kObject : @"cell #1",
            kOnSelect : ^{
                [[[UIAlertView alloc] initWithTitle:@"Hello World!"
                                           message:nil
                                          delegate:nil
                                 cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil] show];
            }
        },
        @"cell #2",
        @"cell #3"
    ]];
}

- (void)manySections {
    [self.tableController reloadWithData:@[
        @[@"cell #1.1", @"cell #1.2", @"cell #1.3"],
        @[@"cell #2.1", @"cell #2.2", @"cell #2.3"],
        @[@"cell #3.1", @"cell #3.2", @"cell #3.3"],
    ]];
}

- (void)longArray {
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
    
    [self.tableController reloadWithData:longArray];
}


@end
