//
//  UIView+APTableController.h
//  DevAPTableController
//
//  Created by Andrei Puni on 9/27/13.
//  Copyright (c) 2013 Andrei Puni. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef BOOL(^APViewIterationBlock)(UIView *view);

@interface UIView (APTableController)

- (void)iterateSubviews:(APViewIterationBlock)block;

@end
