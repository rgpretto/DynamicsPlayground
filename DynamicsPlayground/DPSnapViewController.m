//
//  DPSnapViewController.m
//  DynamicsPlayground
//
//  Created by Renzo Pretto on 9/18/13.
//  Copyright (c) 2013 Renzo Pretto. All rights reserved.
//

#import "DPSnapViewController.h"

#import "UIColor+iOS7Colors.h"
@import QuartzCore;


@interface DPSnapViewController () <UIDynamicAnimatorDelegate>

@property (strong, nonatomic) UIDynamicAnimator *dynamicAnimator;
@property (strong, nonatomic) UISnapBehavior *snapBehavior;

@property (weak, nonatomic) IBOutlet UIView *greenView;

- (IBAction)handleTapGesture:(UITapGestureRecognizer *)sender;

@end



@implementation DPSnapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
		// Custom initialization
	}
	return self;
}

- (void)viewDidLoad {
	[super viewDidLoad];
    
	self.view.layer.borderColor = [UIColor iOS7darkBlueColor].CGColor;
	self.view.layer.borderWidth = 2.0f;
    
	self.dynamicAnimator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
	self.dynamicAnimator.delegate = self;
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (IBAction)handleTapGesture:(UITapGestureRecognizer *)gestureRecognizer {
	CGPoint snapPoint = [gestureRecognizer locationInView:self.view];
    
    
	// remove previous snap behaviour if any exists
	if (nil  != self.snapBehavior) {
		[self.dynamicAnimator removeBehavior:self.snapBehavior];
	}
    
	// default value for damping is 0.5
	self.snapBehavior = [[UISnapBehavior alloc] initWithItem:self.greenView
	                                             snapToPoint:snapPoint];
	//    self.snapBehavior.damping = 0.9f;
	//    NSLog(@"Default damping = %.1f", [self.snapBehavior damping]);
    
	[self.dynamicAnimator addBehavior:self.snapBehavior];
}

#pragma mark - UIDynamicAnimatorDelegate

- (void)dynamicAnimatorWillResume:(UIDynamicAnimator *)animator {
	NSLog(@"Animator is %@", [self.dynamicAnimator isRunning] ? @"running" : @"stopped");
}

- (void)dynamicAnimatorDidPause:(UIDynamicAnimator *)animator {
	NSLog(@"Animator is %@", [self.dynamicAnimator isRunning] ? @"running" : @"stopped");
}

@end
