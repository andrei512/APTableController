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
        self.sections = @[];
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
    
    for (APTableSectionViewModel *section in self.sections) {
        section.tableController = self;
        
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
            if (cell.viewController == nil) {
                cell.viewController = self.viewController;
            }
            if (cell.tableView == nil) {
                cell.tableView = self.tableView;
            }
        }
    }

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView reloadData];
}

- (int)numberOfSections {
    return self.sections.count;
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

- (NSArray *)sectionsFromData:(NSObject *)data {
    if ([data respondsToSelector:@selector(asTableSectionViewModels)]) {
        return [data asTableSectionViewModels];
    }
    return nil;
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


