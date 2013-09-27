//
//  APTableViewCellModel.m
//  APFramework
//
//  Created by Andrei on 8/25/13.
//  Copyright (c) 2013 Andrei. All rights reserved.
//

#import "APTableCellViewModel.h"

#import <NSObject+APUtils.h>
#import <NSString+APUtils.h>
#import "APViewBinder.h"

NSString * const kOnLoad = @"onLoad";
NSString * const kOnSelect = @"onSelect";
NSString * const kObject = @"object";
NSString * const kCellIdentifier = @"cellIdentifier";
NSString * const kNibName = @"nibName";

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

+ (instancetype)cellModelWithObject:(id)object {
    APTableCellViewModel *cellViewModel = [self cellModel];
    cellViewModel.object = object;
    return cellViewModel;
}

+ (instancetype)cellModelWithHash:(NSDictionary *)hash {
    APTableCellViewModel *cellViewModel = [self cellModel];
    [cellViewModel loadHash:hash];
    return cellViewModel;
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
    if (hash[kNibName]) {
        self.nibName = hash[kNibName];
    }
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@ - %@", self.className, self.object];
}

- (void)bindWithContext:(NSDictionary *)context {
    for (NSString *key in context) {
        UIView *view = context[key];
        for (APViewBinder *binder in [APViewBinder binders]) {
            [binder bind:self.object onKey:key with:view];
        }
    }

}

@end
