//
//  RWRotationGestureRecognizer.m
//  KnobControl
//
//  Created by hunk on 1/29/14.
//  Copyright (c) 2014 RayWenderlich. All rights reserved.
//

#import "RWRotationGestureRecognizer.h"
#import <UIKit/UIGestureRecognizerSubclass.h>

@implementation RWRotationGestureRecognizer

- (id)initWithTarget:(id)target action:(SEL)action{

	self = [super initWithTarget:target action:action];
	if (self) {
		self.maximumNumberOfTouches = 1;
		self.minimumNumberOfTouches = 1;
	}
	
	return self;
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{

	[super touchesBegan:touches withEvent:event];
	[self updateTouchAngleWithTouches:touches];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
	[super touchesMoved:touches withEvent:event];
	[self updateTouchAngleWithTouches:touches];
}

- (void)updateTouchAngleWithTouches:(NSSet *)touches{
	UITouch *touch = [touches anyObject];
	CGPoint touchPoint = [touch locationInView:self.view];
	
	self.touchAngle = [self calculateAngleToPoint:touchPoint];
}

- (CGFloat)calculateAngleToPoint:(CGPoint)point{

	CGPoint centerOffset = CGPointMake(point.x - CGRectGetMidX(self.view.bounds),
									   point.y - CGRectGetMidY(self.view.bounds));
	
	return atan2(centerOffset.y, centerOffset.x);
}

@end
