//
//  APLabelBinder.m
//  DevAPTableController
//
//  Created by Andrei Puni on 9/27/13.
//  Copyright (c) 2013 Andrei Puni. All rights reserved.
//

#import "APLabelBinder.h"

@implementation APLabelBinder

- (void)bind:(id)model onKey:(NSString *)key with:(UIView *)view {
    @try {
        UILabel *label = (UILabel *)view;
        label.text = [[model valueForKey:key] description];
    }
    @catch (NSException *exception) {
        NSLog(@"FML: %@", exception);
    }
}

@end
