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

@interface APTableController : NSObject <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *sections;

- (void)reloadWithData:(id)data;

- (void)reloadTableView:(UITableView *)tableView withData:(id)data;

- (int)numberOfSections;

- (void)realoadTableView;

- (APTableCellViewModel *)cellViewModelAtIndexPath:(NSIndexPath *)indexPath;

@end
