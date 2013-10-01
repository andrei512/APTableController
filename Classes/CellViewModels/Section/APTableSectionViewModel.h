//
//  APTableSectionViewModel.h
//  APFramework
//
//  Created by Andrei on 8/25/13.
//  Copyright (c) 2013 Andrei. All rights reserved.
//

#import "APTableCellViewModel.h"

@class APTableController;

@interface APTableSectionViewModel : NSObject

@property (nonatomic, strong) NSMutableArray *cells;

@property (nonatomic) int sectionIndex;

// References
@property (nonatomic, weak) APTableController *tableController;
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, weak) UIViewController *viewController;


+ (instancetype)sectionWithCells:(NSArray *)cells;

- (int)numberOfCells;

// all changes will be animated at first - will add the rest later
- (void)insertCell:(APTableCellViewModel *)cell atIndex:(int)index;
- (void)insertCell:(APTableCellViewModel *)cell;

- (void)insertCells:(NSArray *)cells atIndexes:(NSArray *)indexPaths;

- (void)deleteCellAtIndex:(int)index;
- (void)deleteCellsAtIndexPaths:(NSArray *)indexes;





@end
