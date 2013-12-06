//
//  ViewController.m
//  TestAPTableController
//
//  Created by Andrei Puni on 12/6/13.
//  Copyright (c) 2013 Andrei Puni. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);

    [self getPosts];
}

- (void)reloadCells {
    NSMutableArray *cells = [NSMutableArray array];
    
    for (NSDictionary *post in self.posts) {
        APTableCellViewModel *cellModel =
            [APTableCellViewModel cellModelWithObject:post[@"title"]];
        [cells addObject:cellModel];
    }
    
    APTableSectionViewModel *sectionModel =
        [APTableSectionViewModel sectionWithCells:cells];
    
    NSMutableArray *sections = [NSMutableArray arrayWithObject:sectionModel];
    
    self.tableController.sections = sections;
    
    [self.tableController reloadTableView];
}

- (void)getPosts {
    NSString *postsPath = @"http://www.reddit.com/r/iosprogramming.json";
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:postsPath
      parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *rawPosts = responseObject[@"data"][@"children"];
        self.posts = [rawPosts mapWithBlock:^id(NSDictionary *postInfo) {
            NSLog(@"postInfo = %@", postInfo);
            return postInfo[@"data"];
        }];
             
        [self reloadCells];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

@end
