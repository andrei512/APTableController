//
//  TableViewCell.m
//  APFramework
//
//  Created by Andrei on 8/24/13.
//  Copyright (c) 2013 Andrei. All rights reserved.
//

#import "APTableCell.h"
#import "APTableCellViewModel.h"

#import "UIView+APTableController.h"
#import "NSObject+APKeys.h"

@interface APTableCell ()

@property (nonatomic, strong) NSMutableDictionary *context;

@end

@implementation APTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.context = [NSMutableDictionary dictionary];
    
    [self iterateSubviews:^BOOL(UIView *view) {
        if (view.apKey != nil) {
            self.context[view.apKey] = view;
        }
        if ([view isKindOfClass:[UILabel class]]) {
            UILabel *label = (UILabel *)view;
            if (label.text != nil) {
                self.context[label.text] = label;
            }
        }
        return YES;
    }];
}

- (void)loadViewModel:(APTableCellViewModel *)viewModel {
    self.viewModel = viewModel;

    [viewModel bindWithContext:self.context];
    
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
