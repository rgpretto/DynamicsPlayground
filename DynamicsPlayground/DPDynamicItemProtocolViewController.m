//
//  DPDynamicItemViewController.m
//  DynamicsPlayground
//
//  Created by Renzo Pretto on 9/23/13.
//  Copyright (c) 2013 Renzo Pretto. All rights reserved.
//

#import "DPDynamicItemProtocolViewController.h"

#import "DPDynamicObject.h"
#import "UIColor+iOS7Colors.h"


@interface DPDynamicItemProtocolViewController () <UIDynamicAnimatorDelegate>

@property (strong, nonatomic) UIDynamicAnimator *dynamicAnimator;
@property (strong, nonatomic) DPDynamicObject *dynamicObject;

- (IBAction)handleStartButton:(id)sender;

@end


@implementation DPDynamicItemProtocolViewController

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
    
	self.dynamicObject = [[DPDynamicObject alloc] init];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (IBAction)handleStartButton:(id)sender {
	if (NO == [self.dynamicAnimator isRunning]) {
		UIGravityBehavior *gravity = [[UIGravityBehavior alloc] initWithItems:@[self.dynamicObject]];
        
		UIDynamicItemBehavior *itemBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[self.dynamicObject]];
		itemBehavior.elasticity = 0.5f;
		[itemBehavior addAngularVelocity:2.0f forItem:self.dynamicObject];
        
		UICollisionBehavior *collision = [[UICollisionBehavior alloc] initWithItems:@[self.dynamicObject]];
		collision.translatesReferenceBoundsIntoBoundary = YES;
        
		[self.dynamicAnimator addBehavior:gravity];
		[self.dynamicAnimator addBehavior:itemBehavior];
		[self.dynamicAnimator addBehavior:collision];
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
