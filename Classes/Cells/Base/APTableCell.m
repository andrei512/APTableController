//
//  TableViewCell.m
//  APFramework
//
//  Created by Andrei on 8/24/13.
//  Copyright (c) 2013 Andrei. All rights reserved.
//

#import "APTableCell.h"
#import "APTableCellViewModel.h"

@interface APTableCell ()

@property (nonatomic, strong) NSMutableArray *defaults;

@end

@implementation APTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)loadViewModel:(APTableCellViewModel *)viewModel {
    self.viewModel = viewModel;
    
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

- (void)prepareForReuse {
    [super prepareForReuse];
    
    if (self.viewModel.beforeReuse != nil) {
        self.viewModel.beforeReuse(self);
    }
}



@end
