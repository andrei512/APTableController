//
//  TableViewController.m
//  APFramework
//
//  Created by Andrei on 8/24/13.
//  Copyright (c) 2013 Andrei. All rights reserved.
//

#import "APTableController.h"

@implementation APTableController

- (void)reloadWithData:(id)data {
    [self reloadTableView:self.tableView WithData:data];
}

- (void)reloadTableView:(UITableView *)tableView withData:(id)data {
    self.tableView = tableView;
    
    [self realoadTableView];
}

- (void)realoadTableView {
    [self normalizeData];
    
    NSMutableDictionary *nibStash = [self instanceStashWithKey:@"nibStash"];
    
    NSMutableSet *registeredIdentifiers = [NSMutableSet set];
    
    for (APTableSectionViewModel *section in self.sections) {
        for (APTableCellViewModel *cell in section.cells) {
            // create nib if it does not exist
            if (nibStash[cell.nibName] == nil) {
                nibStash[cell.nibName] = [UINib nibWithNibName:cell.nibName bundle:nil];
            }
            
            // register the nib by the cell identifier
            if ([registeredIdentifiers containsObject:cell.cellIdentifier] == NO) {
                [self.tableView registerNib:nibStash[cell.nibName]
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

    
    [self.tableView reloadData];
}

- (int)numberOfSections {
    return self.sections.count;
}

- (APTableCellViewModel *)cellViewModelAtIndexPath:(NSIndexPath *)indexPath {
    APTableSectionViewModel *section = self.sections[indexPath.section];
    return section.cells[indexPath.row];
}

#pragma mark - Magic

- (void)normalizeData {
    // TO DO: figure out how to run this code just once or smth..
    self.sections = [self.sections map:^id(id section) {
        if ([section isKindOfClass:[APTableSectionViewModel class]] == YES) {
            // is real section model
            APTableSectionViewModel *normalSection = section;
            [normalSection normalizeData];
            return normalSection;
        } else if ([section isKindOfClass:[NSArray class]] == YES){
            // is in fact a array of unnormalized data
            APTableSectionViewModel *arraySection = [APTableSectionViewModel sectionWithCells:(NSArray *)section];
            [arraySection normalizeData];
            return arraySection;
        } else if ([section isKindOfClass:[NSDictionary class]] == YES) {
            APTableSectionViewModel *hashCellSection = [APTableSectionViewModel sectionWithCells:@[section]];
            [hashCellSection normalizeData];
            return hashCellSection;
        } else {
            // ignore the fact that you don't have a section model or an array of cellModels
            // and just make a Section with one cell containing the object
            APTableSectionViewModel *wierdSection = [APTableSectionViewModel sectionWithCells:@[section]];
            [wierdSection normalizeData];
            return wierdSection;
        }
    }];
}


#pragma mark - UITableViewDataSource

- (int)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.numberOfSections;
}

- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex {
    APTableSectionViewModel *section = self.sections[sectionIndex];
    return section.numberOfCells;
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
    APTableCell *cell = (APTableCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}

@end
