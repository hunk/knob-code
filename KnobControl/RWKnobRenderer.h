//
//  RWKnobRenderer.h
//  KnobControl
//
//  Created by hunk on 1/16/14.
//  Copyright (c) 2014 RayWenderlich. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RWKnobRenderer : NSObject

#pragma mark - Properties associated with all parts of the render
@property (nonatomic, strong) UIColor *color;
@property (nonatomic, assign) CGFloat lineWidth;

#pragma mark - Porperties associated with the background track
@property (nonatomic, readonly, strong) CAShapeLayer *trackLayer;
@property (nonatomic, assign) CGFloat startAngle;
@property (nonatomic, assign) CGFloat endAngle;

#pragma mark - Properties associated with the pointer element
@property (nonatomic, readonly, strong) CAShapeLayer *pointerLayer;
@property (nonatomic, assign) CGFloat pointerAngle;
@property (nonatomic, assign) CGFloat pointerLength;

- (void)updateWithBounds:(CGRect)bounds;

- (void)setPointerAngle:(CGFloat)pointerAngle animated:(BOOL)animated;

@end
