//
//  RWViewController.m
//  KnobControl
//
//  Created by Sam Davies on 14/11/2013.
//  Copyright (c) 2013 RayWenderlich. All rights reserved.
//

#import "RWViewController.h"
#import "RWKnobControl.h"

@interface RWViewController (){
	RWKnobControl *_knobControl;
}

@end

@implementation RWViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	self.view.tintColor = [UIColor redColor];
	
	
	
	_knobControl = [[RWKnobControl alloc] initWithFrame:self.knobPlaceholder.bounds];

	[self.knobPlaceholder addSubview:_knobControl];
	
	[_knobControl addObserver:self forKeyPath:@"value" options:0 context:NULL];
	
	[_knobControl addTarget:self action:@selector(handleValueChanged:) forControlEvents:UIControlEventValueChanged];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)handleValueChanged:(id)sender {
	
	if(sender == self.valueSlider) {
        _knobControl.value = self.valueSlider.value;
    } else if(sender == _knobControl) {
        self.valueSlider.value = _knobControl.value;
    }
}

- (IBAction)handleRandomButtonPressed:(id)sender {
	
	CGFloat randomValue = (arc4random() % 101) / 100.f;
	
	[_knobControl setValue:randomValue animated:self.animateSwitch.on];
	[self.valueSlider setValue:randomValue
					  animated:self.animateSwitch.on];
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{

	if (object ==  _knobControl && [keyPath isEqualToString:@"value"]) {
		
		self.valueLabel.text = [NSString stringWithFormat:@"%0.2f",_knobControl.value];
	}

}


@end
