//
//  TableViewController.h
//  APFramework
//
//  Created by Andrei on 8/24/13.
//  Copyright (c) 2013 Andrei. All rights reserved.
//

#import "APTableSectionViewModel.h"
#import "APTableCellViewModel.h"
#import "APTableCell.h"

#import "NSArray+APTableController.h"
#import "NSDictionary+APTableController.h"
#import "NSObject+APTableController.h"


@interface APTableController : NSObject <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) IBOutlet UIViewController *viewController;
@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *sections;

@property (nonatomic, readonly) APTableSectionViewModel *firstSection;

- (void)reloadWithData:(id)data;
- (void)reloadTableView:(UITableView *)tableView withData:(NSObject *)data;

- (int)numberOfSections;
- (int)numberOfRowsInSection:(int)sectionIndex;

- (void)realoadTableView;

- (APTableCellViewModel *)cellViewModelAtIndexPath:(NSIndexPath *)indexPath;

- (NSMutableArray *)sectionsFromData:(NSObject *)data;

// Inserting, Deleting, and Moving Rows and Sections

- (void)insertCell:(APTableCellViewModel *)cellViewModel;// in the first section at the end
- (void)insertCell:(APTableCellViewModel *)cellViewModel atIndex:(int)index;//in the first section
- (void)deleteCellAtIndex:(int)index; // in the first section

- (void)insertCell:(APTableCellViewModel *)cellViewModel atIndexPath:(NSIndexPath *)indexPath;
- (void)deleteCellAtIndexPath:(NSIndexPath *)indexPath;

- (void)insertCells:(NSArray *)cells atIndexPaths:(NSArray *)indexPaths;// the cells have to be in the same section
- (void)deleteCellsAtIndexPaths:(NSArray *)indexPaths;

- (void)moveCellAtIndex:(int)index toIndex:(int)toIndex; // first section
- (void)moveCellAtIndexPath:(NSIndexPath *)indexPath toIndexPath:(NSIndexPath *)toIndexPath;

// Sections
- (void)insertSection:(APTableSectionViewModel *)section;
- (void)insertSections:(NSArray *)sections;

- (void)insertSection:(APTableSectionViewModel *)section atIndex:(int)index;
- (void)insertSections:(NSArray *)sections atIndex:(int)index;

- (void)deleteSectionAtIndex:(int)index;
- (void)deleteSectionAtIndexes:(NSArray *)indexes;

- (void)deleteSection:(APTableSectionViewModel *)section;
- (void)deleteSections:(NSArray *)sections;

@end

