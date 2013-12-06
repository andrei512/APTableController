//
//  APViewBinder.m
//  DevAPTableController
//
//  Created by Andrei Puni on 9/27/13.
//  Copyright (c) 2013 Andrei Puni. All rights reserved.
//

#import "APViewBinder.h"
#import <objc/runtime.h>

@implementation APViewBinder

+ (void)load {
    [super load];
    
    Class *buffer = NULL;
    
    int count, size;
    do {
        count = objc_getClassList(NULL, 0);
        buffer = (Class *)realloc(buffer, count * sizeof(*buffer));
        size = objc_getClassList(buffer, count);
    } while(size != count);
    
    NSMutableArray *array = [NSMutableArray array];
    for(int i = 0; i < count; i++)
    {
        Class candidate = buffer[i];
        Class superclass = candidate;
        while(superclass)
        {
            if(superclass == self)
            {
                [array addObject: candidate];
                break;
            }
            superclass = class_getSuperclass(superclass);
        }
    }
    free(buffer);

    NSMutableArray *_binders = [self _binders];
    
    for (Class subclass in array) {
        APViewBinder *binder = [subclass binder];
        [_binders addObject:binder];
    }
}

+ (NSMutableArray *)_binders {
    static NSMutableArray *binders = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        binders = [NSMutableArray array];
    });
    return binders;
}

+ (NSArray *)binders {
    return [self _binders];
}

+ (instancetype)binder {
    return [self new];
}

- (void)bind:(id)model onKey:(NSString *)key with:(UIView *)view {
//    LOG_LINE
//    PO(model)
//    PO(key)
//    PO(view)
}

@end
