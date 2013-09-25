//
//  APTableSectionViewModel.h
//  APFramework
//
//  Created by Andrei on 8/25/13.
//  Copyright (c) 2013 Andrei. All rights reserved.
//

#import "APViewModel.h"
#import "APTableCellViewModel.h"

@interface APTableSectionViewModel : APViewModel

@property (nonatomic, strong) NSArray *cells;

+ (instancetype)sectionWithCells:(NSArray *)cells;

- (int)numberOfCells;

- (void)normalizeData;

@end
