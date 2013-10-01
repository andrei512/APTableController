//
//  NSObject+APTableController.h
//  DevAPTableController
//
//  Created by Andrei Puni on 9/26/13.
//  Copyright (c) 2013 Andrei Puni. All rights reserved.
//

#import "APTableSectionViewModel.h"
#import "APTableCellViewModel.h"

@interface NSObject (APTableController)

- (NSMutableArray *)asTableSectionViewModels;
- (APTableSectionViewModel *)asTableSectionViewModel;
- (APTableCellViewModel *)asCellViewModel;


@end
