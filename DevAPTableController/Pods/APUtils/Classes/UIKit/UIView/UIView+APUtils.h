//
//  UIView+APUtils.h
//  DevAPUtils
//
//  Created by Andrei Puni on 9/25/13.
//  Copyright (c) 2013 Andrei Puni. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (APUtils)

// shortcuts for frame properties
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGSize size;

// shortcuts for the coords
@property (nonatomic, assign) CGFloat left;
@property (nonatomic, assign) CGFloat top;
@property (nonatomic, assign) CGFloat right;
@property (nonatomic, assign) CGFloat bottom;

// shortcuts for positions
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;

// shortcuts for dimensions
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, readonly) CGFloat orientationWidth;
@property (nonatomic, readonly) CGFloat orientationHeight;

/**
 *  Loads and returns the 1st view for the specified nib
 *
 *  @param nibName
 *
 *  @return a UIView instance
 */
+ (instancetype)viewWithNibName:(NSString *)nibName;

// shortcuts for subviews
- (UIView *)descendantOrSelfWithClass:(Class)cls;
- (UIView *)ancestorOrSelfWithClass:(Class)cls;
- (void)removeAllSubviews;


/**
 *  Rounded corners using performant Bezier Path
 *
 *  @param inRadius radius of the corners
 */
- (void)addBezierPathRoundedCornersWithRadius:(CGFloat)inRadius;

- (void)setRoundedCorners:(UIRectCorner)corners radius:(CGFloat)radius;
- (void)setRoundedCornersWithRadius:(CGFloat)radius;

@end
