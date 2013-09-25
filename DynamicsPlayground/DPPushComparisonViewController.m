//
//  DPPushViewController.m
//  DynamicsPlayground
//
//  Created by Renzo Pretto on 9/18/13.
//  Copyright (c) 2013 Renzo Pretto. All rights reserved.
//

#import "DPPushComparisonViewController.h"

@interface DPPushComparisonViewController () <UIDynamicAnimatorDelegate>

@property (strong, nonatomic) UIDynamicAnimator *dynamicAnimator;

@property (weak, nonatomic) IBOutlet UIView *blackView;
@property (weak, nonatomic) IBOutlet UIView *greenView;
@property (weak, nonatomic) IBOutlet UIView *redView;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *startButton;

- (IBAction)handlePushButton:(id)sender;

@end

@implementation DPPushComparisonViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
		// Custom initialization
	}
	return self;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view.
    
	self.dynamicAnimator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
	self.dynamicAnimator.delegate = self;
}

#pragma mark - Actions


- (IBAction)handlePushButton:(id)sender {
	if (NO == [self.dynamicAnimator isRunning]) {
		UICollisionBehavior *collisionBehavior = [[UICollisionBehavior alloc] initWithItems:@[self.greenView, self.redView, self.blackView]];
		collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
        
        
		UIGravityBehavior *gravity = [[UIGravityBehavior alloc] initWithItems:@[self.blackView]];
        
		CGVector pushVector = CGVectorMake(0.0, 9.81);
		UIPushBehavior *continousPush = [[UIPushBehavior alloc] initWithItems:@[self.greenView]
		                                                                 mode:UIPushBehaviorModeContinuous];
		continousPush.pushDirection = pushVector;
        
		UIPushBehavior *istantaneousPush = [[UIPushBehavior alloc] initWithItems:@[self.redView]
		                                                                    mode:UIPushBehaviorModeInstantaneous];
		istantaneousPush.pushDirection = pushVector;
        
		[self.dynamicAnimator addBehavior:gravity];
		[self.dynamicAnimator addBehavior:collisionBehavior];
		[self.dynamicAnimator addBehavior:continousPush];
		[self.dynamicAnimator addBehavior:istantaneousPush];
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
