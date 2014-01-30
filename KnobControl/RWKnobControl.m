//
//  RWKnobControl.m
//  KnobControl
//
//  Created by hunk on 1/16/14.
//  Copyright (c) 2014 RayWenderlich. All rights reserved.
//

#import "RWKnobControl.h"
#import "RWKnobRenderer.h"

#import "RWRotationGestureRecognizer.h"

@implementation RWKnobControl{
	RWKnobRenderer *_knobRender;
	RWRotationGestureRecognizer *_gestureRecognizer;
}

@dynamic lineWidth;
@dynamic startAngle;
@dynamic endAngle;
@dynamic pointerLength;

#pragma mark . API Methods
- (void)setValue:(CGFloat)value animated:(BOOL)animated{
	if (value != _value) {
		[self willChangeValueForKey:@"value"];
		_value =  MIN(self.maximumValue, MAX(self.minimumValue, value));
		
		CGFloat angleRange = self.endAngle - self.startAngle;
		CGFloat valueRange = self.maximumValue - self.minimumValue;
		CGFloat angleForValue = (_value - self.minimumValue) / valueRange * angleRange + self.startAngle;
//		_knobRender.pointerAngle = angleForValue;
		[_knobRender setPointerAngle:angleForValue animated:animated];
		[self didChangeValueForKey:@"value"];
	}
}

#pragma mark - Property overrides
- (void)setValue:(CGFloat)value{
	[self setValue:value animated:NO];
}


- (id)initWithFrame:(CGRect)frame
{
	
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
//		self.backgroundColor = [UIColor blueColor];
		
		_minimumValue = 0.0;
		_maximumValue = 1.0;
		_value = 0.0;
		_continuous = YES;
		
		_gestureRecognizer = [[RWRotationGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
		[self addGestureRecognizer:_gestureRecognizer];
		[self createKnobUI];
    }
    return self;
}

- (void)createKnobUI{

	_knobRender = [[RWKnobRenderer alloc] init];
	[_knobRender updateWithBounds:self.bounds];
	_knobRender.color =  self.tintColor;
	// set some Defaults
	_knobRender.startAngle = -M_PI * 11 / 8.0;
	_knobRender.endAngle = M_PI * 3 / 8.0;
	_knobRender.pointerAngle = _knobRender.startAngle;
	_knobRender.lineWidth = 4.0;
	_knobRender.pointerLength = 8.0;
	// add layers
	[self.layer addSublayer:_knobRender.trackLayer];
	[self.layer addSublayer:_knobRender.pointerLayer];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

#pragma mark - dynamic methods

- (CGFloat)lineWidth{
	return _knobRender.lineWidth;
}

- (void)setLineWidth:(CGFloat)lineWidth{
	_knobRender.lineWidth = lineWidth;
}


- (CGFloat)startAngle{
	return _knobRender.startAngle;
}

-(void)setStartAngle:(CGFloat)startAngle{
	_knobRender.startAngle = startAngle;
}


- (CGFloat)endAngle{
	return _knobRender.endAngle;
}

- (void)setEndAngle:(CGFloat)endAngle{
	_knobRender.endAngle = endAngle;
}


- (CGFloat)pointerLength{
	return  _knobRender.pointerLength;
}

- (void)setPointerLength:(CGFloat)pointerLength{
	_knobRender.pointerLength = pointerLength;
}


#pragma mark - change color
- (void)tintColorDidChange{
	_knobRender.color =  self.tintColor;
}


+ (BOOL)automaticallyNotifiesObserversForKey:(NSString *)key{

	if ([key isEqualToString:@"value"]) {
		return NO;
	}else{
		return [super automaticallyNotifiesObserversForKey:key];
	}

}

#pragma mark - gesture functions
- (void)handleGesture:(RWRotationGestureRecognizer*)gesture{
	CGFloat midPointAngle = (2 * M_PI + self.startAngle - self.endAngle) / 2 + self.endAngle;
	
	CGFloat boundedAngle = gesture.touchAngle;
	if (boundedAngle > midPointAngle) {
		boundedAngle -= 2 * M_PI;
	}else if (boundedAngle < (midPointAngle - 2 * M_PI)) {
        boundedAngle += 2 * M_PI;
    }
	
	boundedAngle = MIN(self.endAngle, MAX(self.startAngle, boundedAngle));
	
	CGFloat angleRange = self.endAngle - self.startAngle;
	CGFloat valueRange = self.maximumValue - self.minimumValue;
	CGFloat valueForAngle = (boundedAngle - self.startAngle) / angleRange * valueRange + self.minimumValue;
	
	self.value = valueForAngle;
	
	if (self.continuous) {
		[self sendActionsForControlEvents:UIControlEventValueChanged];
	}else{
		if (_gestureRecognizer.state == UIGestureRecognizerStateEnded ||
			_gestureRecognizer.state == UIGestureRecognizerStateCancelled) {
			[self sendActionsForControlEvents:UIControlEventValueChanged	];
		}
	}
	
}


@end
