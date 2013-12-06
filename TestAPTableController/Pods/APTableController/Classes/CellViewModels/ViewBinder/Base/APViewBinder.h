//
//  APViewBinder.h
//  DevAPTableController
//
//  Created by Andrei Puni on 9/27/13.
//  Copyright (c) 2013 Andrei Puni. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APViewBinder : NSObject

+ (instancetype)binder;
+ (NSArray *)binders;

- (void)bind:(id)model onKey:(NSString *)key with:(UIView *)view;

@end
