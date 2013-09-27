//
//  NSObject+APKeys.m
//  DevAPTableController
//
//  Created by Andrei Puni on 9/27/13.
//  Copyright (c) 2013 Andrei Puni. All rights reserved.
//

#import "NSObject+APKeys.h"
#import <objc/runtime.h>

const void *kApKey;

@implementation NSObject (APKeys)

- (NSString *)apKey {
    return objc_getAssociatedObject(self, &kApKey);
}

- (void)setApKey:(NSString *)apKey {
    objc_setAssociatedObject(self, &kApKey, apKey, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
