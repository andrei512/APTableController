//
//  APTableSectionViewModel.m
//  APFramework
//
//  Created by Andrei on 8/25/13.
//  Copyright (c) 2013 Andrei. All rights reserved.
//

#import "APTableSectionViewModel.h"
#import "APTableController.h"
#import <NSArray+APUtils.h>
#import <NSObject+APUtils.h>

@implementation APTableSectionViewModel

- (id)init {
    if (self = [super init]) {
        self.cells = @[];
    }
    return self;
}

+ (instancetype)sectionWithCells:(NSArray *)cells {
    APTableSectionViewModel *section = [self new];
    section.cells = cells;
    return section;
}

- (int)numberOfCells {
    return self.cells.count;
}

- (NSString *)description {
    NSString *cellDescription = [NSString stringWithFormat:@"%@", self.cells];
    return [NSString stringWithFormat:@"%@ - |%@|", self.className, cellDescription];
}


@end
