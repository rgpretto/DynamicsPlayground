//
//  DPPushViewController.m
//  DynamicsPlayground
//
//  Created by Renzo Pretto on 9/18/13.
//  Copyright (c) 2013 Renzo Pretto. All rights reserved.
//

#import "DPPushComparisonViewController.h"

#import "DPAnimatorStatusView.h"
#import "UIColor+iOS7Colors.h"


@interface DPPushComparisonViewController () <UIDynamicAnimatorDelegate>

@property (strong, nonatomic) UIDynamicAnimator *dynamicAnimator;

@property (weak, nonatomic) IBOutlet UIView *blackView;
@property (weak, nonatomic) IBOutlet UIView *greenView;
@property (weak, nonatomic) IBOutlet UIView *redView;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *startButton;

@property (strong, nonatomic) DPAnimatorStatusView *animatorStatusView;

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
    
    self.animatorStatusView = [DPAnimatorStatusView animatorStatusViewinContainerFrame:[self.view frame]];
    [self.view addSubview:self.animatorStatusView];

    // evidence reference view bounds
	self.view.layer.borderColor = [UIColor iOS7redColor].CGColor;
	self.view.layer.borderWidth = 4.0f;
    
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
        
		UIPushBehavior *instantaneousPush = [[UIPushBehavior alloc] initWithItems:@[self.redView]
		                                                                    mode:UIPushBehaviorModeInstantaneous];
		instantaneousPush.pushDirection = pushVector;
        
		[self.dynamicAnimator addBehavior:gravity];
		[self.dynamicAnimator addBehavior:collisionBehavior];
		[self.dynamicAnimator addBehavior:continousPush];
		[self.dynamicAnimator addBehavior:instantaneousPush];
	}
}

#pragma mark - UIDynamicAnimatorDelegate

- (void)dynamicAnimatorWillResume:(UIDynamicAnimator *)animator {
	NSLog(@"Animator is %@", [self.dynamicAnimator isRunning] ? @"running" : @"stopped");
    [self.animatorStatusView setAnimatorStatus:[animator isRunning]];
}

- (void)dynamicAnimatorDidPause:(UIDynamicAnimator *)animator {
	NSLog(@"Animator is %@", [self.dynamicAnimator isRunning] ? @"running" : @"stopped");
    [self.animatorStatusView setAnimatorStatus:[animator isRunning]];
}

@end
