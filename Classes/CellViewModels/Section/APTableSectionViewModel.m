//
//  APTableSectionViewModel.m
//  APFramework
//
//  Created by Andrei on 8/25/13.
//  Copyright (c) 2013 Andrei. All rights reserved.
//

#import "APTableSectionViewModel.h"
#import "APTableController.h"
#import <NSArray+APUtils.h>
#import <NSObject+APUtils.h>

@implementation APTableSectionViewModel

- (id)init {
    if (self = [super init]) {
        self.cells = [NSMutableArray array];
    }
    return self;
}

+ (instancetype)sectionWithCells:(NSArray *)cells {
    APTableSectionViewModel *section = [self new];
    section.cells = [cells isKindOfClass:[NSMutableArray class]] ? cells : [cells mutableCopy];
    return section;
}

- (int)numberOfCells {
    return self.cells.count;
}

- (NSString *)description {
    NSString *cellDescription = [NSString stringWithFormat:@"%@", self.cells];
    return [NSString stringWithFormat:@"%@ - |%@|", self.className, cellDescription];
}

#pragma mark - Insert, Remove, Move

- (void)insertCell:(APTableCellViewModel *)cell atIndex:(int)index {
    [self.cells insertObject:cell atIndex:index];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:self.sectionIndex];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)insertCell:(APTableCellViewModel *)cell {
    [self insertCell:cell atIndex:self.cells.count];
}

- (void)insertCells:(NSArray *)cells atIndexes:(NSArray *)indexPaths {
    if (cells.count != indexPaths.count) {
        return;
    }
    
    for (int i = 0; i < cells.count && i < indexPaths.count; ++i) {
        APTableCellViewModel *cellViewModel = cells[i];
        NSIndexPath *indexPath = indexPaths[i];
        [self.cells insertObject:cellViewModel atIndex:indexPath.row];
    }
    
    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)deleteCellAtIndex:(int)index {
    [self.cells removeObjectAtIndex:index];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:self.sectionIndex];
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)deleteCellsAtIndexPaths:(NSArray *)indexes {
    // sort the indexes to remove in order to not generate exceptions from removal
    // ex [1, 2, 3]  - indexes = [2, 3]
    // after removing item at index 2 [1, 3]
    // exception when trying to remove form index 3
    NSArray *sortedIndexes =
        [indexes sortedArrayWithOptions:0
         usingComparator:^NSComparisonResult(NSIndexPath *obj1, NSIndexPath *obj2) {
             return [@(obj2.row) compare:@(obj1.row)];
         }];
    
    for (NSIndexPath *indexPath in sortedIndexes) {
        [self.cells removeObjectAtIndex:indexPath.row];
    }
    
    [self.tableView deleteRowsAtIndexPaths:indexes withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)deleteCell:(APTableCellViewModel *)cell {
    [self deleteCells:@[cell]];
}

- (void)deleteCells:(NSArray *)cells {
    [self deleteCells:[cells mapWithBlock:^id(APTableCellViewModel *cell) {
        return @([self.cells indexOfObject:cell]);
    }]];
}

@end
