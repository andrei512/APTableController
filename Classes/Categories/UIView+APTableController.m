//
//  UIView+APTableController.m
//  DevAPTableController
//
//  Created by Andrei Puni on 9/27/13.
//  Copyright (c) 2013 Andrei Puni. All rights reserved.
//

#import "UIView+APTableController.h"

@implementation UIView (APTableController)

- (void)iterateSubviews:(APViewIterationBlock)block {
    if (block(self)) {
        [self.subviews makeObjectsPerformSelector:@selector(iterateSubviews:) withObject:block];
    }
}

@end
