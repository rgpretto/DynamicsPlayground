//
//  DPPushViewController.m
//  DynamicsPlayground
//
//  Created by Renzo Pretto on 9/18/13.
//  Copyright (c) 2013 Renzo Pretto. All rights reserved.
//

#import "DPInstantaneousPushViewController.h"

#import "DPAnimatorStatusView.h"
#import "UIColor+iOS7Colors.h"


@interface DPInstantaneousPushViewController () <UIDynamicAnimatorDelegate>

@property (strong, nonatomic) UIDynamicAnimator *dynamicAnimator;
@property (strong, nonatomic) UIPushBehavior *instantaneousPush;

@property (weak, nonatomic) IBOutlet UIView *greenView;
@property (weak, nonatomic) IBOutlet UIView *redView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *startButton;

@property (strong, nonatomic) DPAnimatorStatusView *animatorStatusView;

- (IBAction)handleStartButton:(id)sender;

@end

@implementation DPInstantaneousPushViewController

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
    
    self.view.layer.borderColor = [UIColor iOS7redColor].CGColor;
	self.view.layer.borderWidth = 2.0f;
    
	self.dynamicAnimator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
	self.dynamicAnimator.delegate = self;
}

#pragma mark - Actions


- (IBAction)handleStartButton:(id)sender {
	if (nil == self.instantaneousPush) {
		UICollisionBehavior *collisionBehavior = [[UICollisionBehavior alloc] initWithItems:@[self.greenView, self.redView]];
		collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
        
		CGVector pushVector = CGVectorMake(0.0, 1.0);
		self.instantaneousPush = [[UIPushBehavior alloc] initWithItems:@[self.greenView, self.redView]
                                                                  mode:UIPushBehaviorModeInstantaneous];
		self.instantaneousPush.pushDirection = pushVector;
        
		[self.dynamicAnimator addBehavior:collisionBehavior];
		[self.dynamicAnimator addBehavior:self.instantaneousPush];

	} else {
        if (NO == [self.instantaneousPush active]) {
            [self.instantaneousPush setActive:YES];
        }
    }
}

#pragma mark - UIDynamicAnimatorDelegate

- (void)dynamicAnimatorWillResume:(UIDynamicAnimator *)animator {
	NSLog(@"Animator is %@", [self.dynamicAnimator isRunning] ? @"running" : @"stopped");
    NSLog(@"Is instantaneous push behavior active? %@",  [self.instantaneousPush active] ? @"YES" : @"NO");
    [self.animatorStatusView setAnimatorStatus:[animator isRunning]];
}

- (void)dynamicAnimatorDidPause:(UIDynamicAnimator *)animator {
	NSLog(@"Animator is %@", [self.dynamicAnimator isRunning] ? @"running" : @"stopped");
	NSLog(@"Is instantaneous push behavior active? %@",  [self.instantaneousPush active] ? @"YES" : @"NO");
    [self.animatorStatusView setAnimatorStatus:[animator isRunning]];
}

@end
