//
//  TableViewCell.m
//  APFramework
//
//  Created by Andrei on 8/24/13.
//  Copyright (c) 2013 Andrei. All rights reserved.
//

#import "APTableCell.h"
#import "APTableCellViewModel.h"

@implementation APTableCell

- (void)loadViewModel:(APTableCellViewModel *)viewModel {
    if (viewModel.object != nil) {
        self.textLabel.text = [viewModel.object description];
    }
    // block based customization
    if (viewModel.onLoad != nil) {
        viewModel.onLoad(self);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
