//
//  APTableViewCellModel.h
//  APFramework
//
//  Created by Andrei on 8/25/13.
//  Copyright (c) 2013 Andrei. All rights reserved.
//

#import "APTableCell.h"


typedef void(^APTableViewCellActionBlock)(APTableCell *);
typedef void(^APTableViewActionBlock)(void);

#define kOnLoad @"onLoad"
#define kOnSelect @"onSelect"
#define kObject @"object"
#define kCellIdentifier @"cellIdentifier"
#define kNibName @"nibName"

@interface APTableCellViewModel : NSObject

@property (nonatomic, weak) UIViewController *viewController;
@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, strong) NSString *cellIdentifier;
@property (nonatomic, strong) NSString *nibName;
@property (nonatomic, strong) id object;

// blocks and magic

@property (nonatomic, copy) APTableViewCellActionBlock onLoad;
@property (nonatomic, copy) APTableViewActionBlock onSelect;

+ (instancetype)cellModel;

- (void)loadHash:(NSDictionary *)hash;

@end
