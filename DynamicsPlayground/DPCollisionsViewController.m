//
//  DPCollisionsViewController.m
//  DynamicsPlayground
//
//  Created by Renzo Pretto on 9/25/13.
//  Copyright (c) 2013 Renzo Pretto. All rights reserved.
//

#import "DPCollisionsViewController.h"

#import "DPAnimatorStatusView.h"
#import "UIColor+iOS7Colors.h"


@interface DPCollisionsViewController () <UIDynamicAnimatorDelegate>

@property (weak, nonatomic) IBOutlet UIView *greenView1;
@property (weak, nonatomic) IBOutlet UIView *greenView2;
@property (weak, nonatomic) IBOutlet UIView *greenView3;
@property (weak, nonatomic) IBOutlet UIView *redView1;
@property (weak, nonatomic) IBOutlet UIView *redView2;
@property (weak, nonatomic) IBOutlet UIView *redView3;

@property (strong, nonatomic) UIDynamicAnimator *dynamicAnimator;
@property (strong, nonatomic) DPAnimatorStatusView *animatorStatusView;

- (IBAction)handleStartButton:(id)sender;

@end

@implementation DPCollisionsViewController

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
	self.view.layer.borderWidth = 4.0f;
    
	self.dynamicAnimator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
	self.dynamicAnimator.delegate = self;
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (IBAction)handleStartButton:(id)sender {
	if (NO == [self.dynamicAnimator isRunning]) {
		NSArray *greens = @[self.greenView1, self.greenView2, self.greenView3];
		NSArray *reds = @[self.redView1, self.redView2, self.redView3];
        
		UICollisionBehavior *greenViewsCollision = [[UICollisionBehavior alloc] initWithItems:greens];
		greenViewsCollision.translatesReferenceBoundsIntoBoundary = YES;
		UICollisionBehavior *redViewsCollision = [[UICollisionBehavior alloc] initWithItems:reds];
		redViewsCollision.translatesReferenceBoundsIntoBoundary = YES;
        
		NSArray *views = [greens arrayByAddingObjectsFromArray:reds];
        
		UIGravityBehavior *gravity = [[UIGravityBehavior alloc] initWithItems:views];
        
		[self.dynamicAnimator addBehavior:greenViewsCollision];
		[self.dynamicAnimator addBehavior:redViewsCollision];
		[self.dynamicAnimator addBehavior:gravity];
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
