//
//  NSArray+APTableController.m
//  DevAPTableController
//
//  Created by Andrei Puni on 9/26/13.
//  Copyright (c) 2013 Andrei Puni. All rights reserved.
//

#import "NSArray+APTableController.h"
#import <NSArray+APUtils.h>
#import "NSObject+APTableController.h"

@implementation NSArray (APTableController)

- (NSMutableArray *)asTableSectionViewModels {
    BOOL foundArray = NO;
    for (NSObject *object in self) {
        if ([object isKindOfClass:[NSArray class]] == YES) {
            foundArray = YES;
            break;
        }
    }
    
    if (foundArray == YES) {
        return [self mapWithSelector:@selector(asTableSectionViewModel)];
    } else {
        return @[[self asTableSectionViewModel]].mutableCopy;
    }
}

- (APTableSectionViewModel *)asTableSectionViewModel {
    NSArray *cells = [self mapWithSelector:@selector(asCellViewModel)];
    return [APTableSectionViewModel sectionWithCells:cells];
}

@end
