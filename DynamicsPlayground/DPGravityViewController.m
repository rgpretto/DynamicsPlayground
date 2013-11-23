//
//  DPGravityControllerViewController.m
//  DynamicsPlayground
//
//  Created by Renzo Pretto on 9/10/13.
//  Copyright (c) 2013 Renzo Pretto. All rights reserved.
//

#import "DPGravityViewController.h"

#import "DPAnimatorStatusView.h"
#import "UIColor+iOS7Colors.h"

@interface DPGravityViewController () <UIDynamicAnimatorDelegate>

@property (strong, nonatomic) UIDynamicAnimator *dynamicAnimator;
@property (weak, nonatomic) IBOutlet UIView *greenView;

@property (strong, nonatomic) DPAnimatorStatusView *animatorStatusView;

@end

@implementation DPGravityViewController

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
    
	self.view.layer.borderColor = [UIColor iOS7darkBlueColor].CGColor;
	self.view.layer.borderWidth = 4.0f;
    
	// keep in mind the "Autolayout" Constraints for greenView
	self.dynamicAnimator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
	self.dynamicAnimator.delegate = self;
    
	UIGravityBehavior *gravityBehavior = [[UIGravityBehavior alloc] initWithItems:@[self.greenView]];
	[self.dynamicAnimator addBehavior:gravityBehavior];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
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
