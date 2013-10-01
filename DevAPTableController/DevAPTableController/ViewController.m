//
//  ViewController.m
//  DevAPTableController
//
//  Created by Andrei Puni on 9/25/13.
//  Copyright (c) 2013 Andrei Puni. All rights reserved.
//

#import "ViewController.h"

void after(NSTimeInterval timeInterval, void(^block)(void)) {
    double delayInSeconds = timeInterval;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), block);
}

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self insertSections];
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


- (void)addCell {
    [self manySections];
    
    after(2, ^{
        [self.tableController insertCell:@"added a cell".asCellViewModel];
        after(2, ^{
            [self.tableController insertCell:@"and another one".asCellViewModel];
            after(2, ^{
                [self.tableController insertCell:@{
                                                   kObject : @"and a red one :)",
                                                   kOnLoad : ^(APTableCell *cell) {
                    cell.textLabel.textColor = [UIColor redColor];
                }
                }.asCellViewModel];
            });
        });
    });
}

- (void)addCells {
    [self manySections];
    
    after(2, ^{
    });
}

- (void)insertSection {
    [self manyCells];
    
    [self.tableController insertSection:@"ana are mere".asTableSectionViewModel];
}

- (void)insertSections {
    [self manyCells];
    
    after(2, ^{
        [self.tableController insertSections:
         @[@"I love table views".asTableSectionViewModel,
           @"Blocks!!".asTableSectionViewModel]];
    });
}

- (void)editCell {
    
}

- (void)deleteCell {
    [self manyCells];
    
    after(2, ^{
        [self.tableController deleteCellAtIndex:0];
        after(2, ^{
            [self.tableController insertCell:@"first cell".asCellViewModel atIndex:0];
            after(2, ^{
                [self.tableController deleteCellAtIndex:0];
            });
        });
    });
}

- (void)deleteCells {
    [self manySections];
    
    after(2, ^{
        [self.tableController deleteCellsAtIndexPaths:@[
            [NSIndexPath indexPathForRow:1 inSection:1],
            [NSIndexPath indexPathForRow:2 inSection:1]
        ]];
    });
}

- (void)removeSection {
    [self manySections];
    
    after(2, ^{
        [self.tableController deleteSectionAtIndex:0];
    });
}

- (void)removeSections {
    
}

- (void)pullToReferesh {
    
}

- (void)infiniteScroll {
    
}

- (void)sectionCallbacks {
    
}

- (void)globalCallbacks {
    
}

- (void)sectionLoading {
    
}

- (void)globalLoading {
    
}

- (void)handleOneSectionTables {
    
}



@end
