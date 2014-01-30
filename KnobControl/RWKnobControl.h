//
//  RWKnobControl.h
//  KnobControl
//
//  Created by hunk on 1/16/14.
//  Copyright (c) 2014 RayWenderlich. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RWKnobControl : UIControl

#pragma mark - Knob value

@property (nonatomic, assign) CGFloat value;

- (void)setValue:(CGFloat)value animated:(BOOL)animated;

#pragma mark - Value Limits
@property (nonatomic, assign) CGFloat minimumValue;
@property (nonatomic, assign) CGFloat maximumValue;

#pragma mark - Knob Behavior
@property (nonatomic, assign, getter = isContinuous) BOOL continuous;


@property (nonatomic, assign) CGFloat startAngle;
@property (nonatomic, assign) CGFloat endAngle;
@property (nonatomic, assign) CGFloat lineWidth;
@property (nonatomic, assign) CGFloat pointerLength;


@end
