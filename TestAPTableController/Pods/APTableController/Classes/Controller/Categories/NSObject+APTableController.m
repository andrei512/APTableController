//
//  NSObject+APTableController.m
//  DevAPTableController
//
//  Created by Andrei Puni on 9/26/13.
//  Copyright (c) 2013 Andrei Puni. All rights reserved.
//

#import "NSObject+APTableController.h"

@implementation NSObject (APTableController)

- (NSMutableArray *)asTableSectionViewModels {
    return @[[self asTableSectionViewModel]].mutableCopy;
}

- (APTableSectionViewModel *)asTableSectionViewModel {
    return [APTableSectionViewModel sectionWithCells:@[[self asCellViewModel]]];
}

- (APTableCellViewModel *)asCellViewModel {
    return [APTableCellViewModel cellModelWithObject:self];
}

@end
