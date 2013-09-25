//
//  DPAttachmentViewController.m
//  DynamicsPlayground
//
//  Created by Renzo Pretto on 9/12/13.
//  Copyright (c) 2013 Renzo Pretto. All rights reserved.
//

#import "DPAttachmentViewController.h"

@interface DPAttachmentViewController () <UIDynamicAnimatorDelegate>


@property (weak, nonatomic) IBOutlet UIView *redView;
@property (weak, nonatomic) IBOutlet UIView *greenView;

@property (strong, nonatomic) UIDynamicAnimator *dynamicAnimator;

- (IBAction)handlePanGesture:(UIPanGestureRecognizer *)sender;


@end

@implementation DPAttachmentViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
		// Custom initialization
	}
	return self;
}

- (void)viewDidLoad {
	[super viewDidLoad];
    
	/*
     use gravity behavior to start animation and collision behavior to stop animation
	 */
    
	UICollisionBehavior *collisionBehavior = [[UICollisionBehavior alloc] initWithItems:@[self.redView, self.greenView]];
	collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
    
	UIAttachmentBehavior *attachmentBehavior = [[UIAttachmentBehavior alloc] initWithItem:[self greenView]
	                                                                       attachedToItem:[self redView]];
    //    UIGravityBehavior *gravity = [[UIGravityBehavior alloc] initWithItems:@[[self greenView]]];
    
    
	self.dynamicAnimator = [[UIDynamicAnimator alloc] initWithReferenceView:[self view]];
	self.dynamicAnimator.delegate = self;
	[self.dynamicAnimator addBehavior:collisionBehavior];
    //    [self.animator addBehavior:gravity];
	[self.dynamicAnimator addBehavior:attachmentBehavior];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (IBAction)handlePanGesture:(UIPanGestureRecognizer *)gestureRecognizer {
	CGPoint anchorPoint = [gestureRecognizer locationInView:[self view]];
	self.redView.center = anchorPoint;
    
	[self.dynamicAnimator updateItemUsingCurrentState:[self redView]];
}

#pragma mark - UIDynamicAnimatorDelegate

- (void)dynamicAnimatorWillResume:(UIDynamicAnimator *)animator {
	NSLog(@"Animator is %@", [self.dynamicAnimator isRunning] ? @"running" : @"stopped");
}

- (void)dynamicAnimatorDidPause:(UIDynamicAnimator *)animator {
	NSLog(@"Animator is %@", [self.dynamicAnimator isRunning] ? @"running" : @"stopped");
}

@end
