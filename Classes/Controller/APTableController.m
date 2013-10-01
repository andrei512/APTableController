//
//  TableViewController.m
//  APFramework
//
//  Created by Andrei on 8/24/13.
//  Copyright (c) 2013 Andrei. All rights reserved.
//

#import "APTableController.h"
#import <NSArray+APUtils.h>

@interface APTableController()

@property (nonatomic, strong) NSMutableDictionary *nibStash;
@property (nonatomic, strong) NSMutableDictionary *cellStash;

@end

@implementation APTableController

#pragma mark - init/create

- (id)init {
    if (self = [super init]) {
        self.nibStash = [NSMutableDictionary dictionary];
        self.cellStash = [NSMutableDictionary dictionary];
        self.sections = [NSMutableArray array];
    }
    return self;
}

#pragma mark - Reloading

- (void)reloadWithData:(id)data {
    [self reloadTableView:self.tableView withData:data];
}

- (void)reloadTableView:(UITableView *)tableView withData:(id)data {
    self.tableView = tableView;
    self.sections = [self sectionsFromData:data];
    
    [self realoadTableView];
}

- (void)realoadTableView {
    NSMutableSet *registeredIdentifiers = [NSMutableSet set];
    int sectionIndex = 0;
    for (APTableSectionViewModel *section in self.sections) {
        section.sectionIndex = sectionIndex++;
        section.tableController = self;
        section.viewController = self.viewController;
        section.tableView = self.tableView;
        
        int cellIndex = 0;
        for (APTableCellViewModel *cell in section.cells) {
            // create nib if it does not exist
            if (self.nibStash[cell.nibName] == nil) {
                self.nibStash[cell.nibName] = [UINib nibWithNibName:cell.nibName bundle:nil];
            }
            
            // register the nib by the cell identifier
            if ([registeredIdentifiers containsObject:cell.cellIdentifier] == NO) {
                [self.tableView registerNib:self.nibStash[cell.nibName]
                     forCellReuseIdentifier:cell.cellIdentifier];
            }
            
            // set view controller and table view references on table view
            cell.viewController = self.viewController;
            cell.tableView = self.tableView;
            cell.indexPath = [NSIndexPath indexPathForRow:cellIndex++ inSection:sectionIndex];
        }
    }

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView reloadData];
}

- (int)numberOfSections {
    return self.sections.count;
}

- (APTableSectionViewModel *)firstSection {
    if (self.sections.count > 0) {
        return self.sections[0];
    }
    return nil;
}

- (int)numberOfRowsInSection:(int)sectionIndex {
    APTableSectionViewModel *section = self.sections[sectionIndex];
    return section.numberOfCells;
}

- (APTableCellViewModel *)cellViewModelAtIndexPath:(NSIndexPath *)indexPath {
    APTableSectionViewModel *section = self.sections[indexPath.section];
    return section.cells[indexPath.row];
}

#pragma mark - Magic

- (NSMutableArray *)sectionsFromData:(NSObject *)data {
    if ([data respondsToSelector:@selector(asTableSectionViewModels)]) {
        return [data asTableSectionViewModels];
    }
    return nil;
}

#pragma mark - Inserting, Deleting, and Moving Rows and Sections

- (void)insertCell:(APTableCellViewModel *)cellViewModel {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.firstSection.numberOfCells inSection:0];
    [self insertCell:cellViewModel atIndexPath:indexPath];
}

- (void)insertCell:(APTableCellViewModel *)cellViewModel atIndex:(int)index {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    [self insertCell:cellViewModel atIndexPath:indexPath];
}

- (void)insertCell:(APTableCellViewModel *)cellViewModel atIndexPath:(NSIndexPath *)indexPath {
    APTableSectionViewModel *section = self.sections[indexPath.section];
    [section insertCell:cellViewModel atIndex:indexPath.row];
}

- (int)sectionIndexFromIndexPaths:(NSArray *)indexPaths {
    int sectionIndex = -1;
    for (NSIndexPath *indexPath in indexPaths) {
        if (indexPath.section != sectionIndex &&
            sectionIndex == -1) {
            sectionIndex = indexPath.section;
        } else if (indexPath.section != sectionIndex &&
                   sectionIndex != -1) {
            NSLog(@"Error: attempted to insert multiple cells in multiple sections");
            return -2;
        }
    }
    return sectionIndex;
}

- (void)insertCells:(NSArray *)cells atIndexPaths:(NSArray *)indexPaths {
    int sectionIndex = [self sectionIndexFromIndexPaths:indexPaths];
    if (sectionIndex >= 0) {
        APTableSectionViewModel *section = self.sections[sectionIndex];
        [section insertCells:cells atIndexes:indexPaths];
    }
}

- (void)deleteCellsAtIndexPaths:(NSArray *)indexPaths {
    int sectionIndex = [self sectionIndexFromIndexPaths:indexPaths];
    if (sectionIndex >= 0) {
        APTableSectionViewModel *section = self.sections[sectionIndex];
        [section deleteCellsAtIndexPaths:indexPaths];
    }
}

- (void)deleteCellAtIndex:(int)index {
    [self.firstSection deleteCellAtIndex:index];
}

- (void)deleteCellAtIndexPath:(NSIndexPath *)indexPath {
    APTableSectionViewModel *section = self.sections[indexPath.section];
    [section deleteCellAtIndex:indexPath.row];
}

- (void)moveCellAtIndex:(int)index toIndex:(int)toIndex {
    LOG_LINE
}

- (void)moveCellAtIndexPath:(NSIndexPath *)indexPath toIndexPath:(NSIndexPath *)toIndexPath {
    LOG_LINE    
}

//Sections

- (void)insertSection:(APTableSectionViewModel *)section {
    [self insertSections:@[section]];
}

- (void)insertSections:(NSArray *)sections {
    int begin = self.sections.count;
    int count = sections.count;
    
    [self.sections addObjectsFromArray:sections];
    
    NSRange range = NSMakeRange(begin, count);
    [self.tableView insertSections:[NSIndexSet indexSetWithIndexesInRange:range]
                  withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)insertSection:(APTableSectionViewModel *)section atIndex:(int)index {
    
}

- (void)insertSections:(NSArray *)sections atIndex:(int)index {
    
}

- (void)deleteSectionAtIndex:(int)index {
    [self.sections removeObjectAtIndex:index];
    [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:index]
                  withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)deleteSectionAtIndexes:(NSArray *)indexes {
    
}

- (void)deleteSection:(APTableSectionViewModel *)section {
    [self deleteSections:@[section]];
}

- (void)deleteSections:(NSArray *)sections {
    
}

#pragma mark - UITableViewDataSource

- (int)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.numberOfSections;
}

- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex {
    return [self numberOfRowsInSection:sectionIndex];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    APTableCellViewModel *cellViewModel = [self cellViewModelAtIndexPath:indexPath];
    
    APTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellViewModel.cellIdentifier];
    
    [cell loadViewModel:cellViewModel];
    
    return cell;
}

//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
//
//}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"style = %d indexPath = %@", editingStyle, indexPath);
}



#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    APTableCellViewModel *cellViewModel = [self cellViewModelAtIndexPath:indexPath];
    if (cellViewModel.onSelect != nil) {
        cellViewModel.onSelect();
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    APTableCellViewModel *cellViewModel = [self cellViewModelAtIndexPath:indexPath];
    
    // keep another cell of the same type in a stash
    if (self.cellStash[cellViewModel.cellIdentifier] == nil) {
        self.cellStash[cellViewModel.cellIdentifier] = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    }
    
    APTableCell *cell = (APTableCell *)self.cellStash[cellViewModel.cellIdentifier];
    
    // load that cell in order to get the height
    [cell prepareForReuse];
    [cell loadViewModel:cellViewModel];

    return cell.frame.size.height;
}

@end


