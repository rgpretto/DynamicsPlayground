//
//  DPGravityControllerViewController.m
//  DynamicsPlayground
//
//  Created by Renzo Pretto on 9/10/13.
//  Copyright (c) 2013 Renzo Pretto. All rights reserved.
//

#import "DPGravityViewController.h"
@import QuartzCore;
#import "UIColor+iOS7Colors.h"

@interface DPGravityViewController () <UIDynamicAnimatorDelegate>

@property (strong, nonatomic) UIDynamicAnimator *dynamicAnimator;
@property (weak, nonatomic) IBOutlet UIView *greenView;

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
    
    // evidence reference view bounds
	self.view.layer.borderColor = [UIColor iOS7darkBlueColor].CGColor;
	self.view.layer.borderWidth = 2.0f;
    
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
}

- (void)dynamicAnimatorDidPause:(UIDynamicAnimator *)animator {
	NSLog(@"Animator is %@", [self.dynamicAnimator isRunning] ? @"running" : @"stopped");
}

@end
