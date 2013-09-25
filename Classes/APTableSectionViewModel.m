//
//  APTableSectionViewModel.m
//  APFramework
//
//  Created by Andrei on 8/25/13.
//  Copyright (c) 2013 Andrei. All rights reserved.
//

#import "APTableSectionViewModel.h"

@implementation APTableSectionViewModel

+ (instancetype)sectionWithCells:(NSArray *)cells {
    APTableSectionViewModel *section = [self new];
    
    section.cells = cells;
    
    return section;
}

- (int)numberOfCells {
    return self.cells.count;
}

- (void)normalizeData {
    // TO DO : figure out how to optimize this code
    self.cells = [self.cells map:^id(id cell) {
        if ([cell isKindOfClass:[APTableCellViewModel class]] == YES) {
            return cell;
        } else if ([cell isKindOfClass:[NSDictionary class]] == YES) {
            APTableCellViewModel *hashCell = [APTableCellViewModel cellModel];
            
            [hashCell loadHash:(NSDictionary *)cell];
            hashCell.cellIdentifier = [NSString stringWithFormat:@"%d", (int)cell];
            
            return hashCell;
        } else {
            APTableCellViewModel *objectCellModel = [APTableCellViewModel cellModel];
            
            NSObject *object = cell;
            
            objectCellModel.onLoad = ^(APTableCell *cell) {
                cell.textLabel.text = [NSString stringWithFormat:@"%@", object];
            };
            objectCellModel.cellIdentifier = [NSString stringWithFormat:@"%d", (int)object];
            
            return objectCellModel;
        }
    }];
}

@end
