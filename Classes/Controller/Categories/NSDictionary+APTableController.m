//
//  NSDictionary+APTableController.m
//  DevAPTableController
//
//  Created by Andrei Puni on 9/26/13.
//  Copyright (c) 2013 Andrei Puni. All rights reserved.
//

#import "NSDictionary+APTableController.h"

@implementation NSDictionary (APTableController)

- (APTableCellViewModel *)asCellViewModel {
    APTableCellViewModel *cellModel = [APTableCellViewModel cellModelWithHash:self];
    return cellModel;
}

@end
