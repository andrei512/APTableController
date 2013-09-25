//
//  APTableViewCellModel.m
//  APFramework
//
//  Created by Andrei on 8/25/13.
//  Copyright (c) 2013 Andrei. All rights reserved.
//

#import "APTableCellViewModel.h"

@implementation APTableCellViewModel

- (id)init {
    if (self = [super init]) {
        self.cellIdentifier = [[self className] stringByRemovingSuffix:@"ViewModel"];
        self.nibName = self.cellIdentifier;
    }
    return self;
}

+ (instancetype)cellModel {
    return [self new];
}

- (void)loadHash:(NSDictionary *)hash {
    if (hash[kOnLoad]) {
        self.onLoad = hash[kOnLoad];
    }
    if (hash[kOnSelect]) {
        self.onSelect = hash[kOnSelect];
    }
    if (hash[kObject]) {
        self.object = hash[kObject];
    }
    if (hash[kCellIdentifier]) {
        self.cellIdentifier = hash[kCellIdentifier];
    }
}

@end
