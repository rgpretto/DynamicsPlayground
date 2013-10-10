//
//  DPPushViewController.m
//  DynamicsPlayground
//
//  Created by Renzo Pretto on 9/18/13.
//  Copyright (c) 2013 Renzo Pretto. All rights reserved.
//

#import "DPPushViewController.h"

#import "UIColor+iOS7Colors.h"
@import QuartzCore;


@interface DPPushViewController () <UIDynamicAnimatorDelegate>

@property (strong, nonatomic) UIDynamicAnimator *dynamicAnimator;

@property (weak, nonatomic) IBOutlet UIView *greenView;
@property (weak, nonatomic) IBOutlet UIView *redView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *startButton;

- (IBAction)handleStartButton:(id)sender;

@end

@implementation DPPushViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
		// Custom initialization
	}
	return self;
}

- (void)viewDidLoad {
	[super viewDidLoad];
    
    self.view.layer.borderColor = [UIColor iOS7redColor].CGColor;
	self.view.layer.borderWidth = 2.0f;
    
	self.dynamicAnimator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
	self.dynamicAnimator.delegate = self;
}

#pragma mark - Actions


- (IBAction)handleStartButton:(id)sender {
	if (NO == [self.dynamicAnimator isRunning]) {
		UICollisionBehavior *collisionBehavior = [[UICollisionBehavior alloc] initWithItems:@[self.greenView, self.redView]];
		collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
        
		CGVector pushVector = CGVectorMake(0.0, 1.0);
		UIPushBehavior *continousPush = [[UIPushBehavior alloc] initWithItems:@[self.greenView, self.redView]
		                                                                 mode:UIPushBehaviorModeContinuous];
		continousPush.pushDirection = pushVector;
        
		[self.dynamicAnimator addBehavior:collisionBehavior];
		[self.dynamicAnimator addBehavior:continousPush];
	}
}

#pragma mark - UIDynamicAnimatorDelegate

- (void)dynamicAnimatorWillResume:(UIDynamicAnimator *)animator {
	NSLog(@"Animator is %@", [self.dynamicAnimator isRunning] ? @"running" : @"stopped");
}

- (void)dynamicAnimatorDidPause:(UIDynamicAnimator *)animator {
	NSLog(@"Animator is %@", [self.dynamicAnimator isRunning] ? @"running" : @"stopped");
}

@end
