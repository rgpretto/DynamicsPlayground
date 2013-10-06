//
//  DPGravityControllerViewController.m
//  DynamicsPlayground
//
//  Created by Renzo Pretto on 9/10/13.
//  Copyright (c) 2013 Renzo Pretto. All rights reserved.
//

#import "DPGravityComparisonViewController.h"
@import QuartzCore;
#import "UIColor+iOS7Colors.h"


@interface DPGravityComparisonViewController () <UIDynamicAnimatorDelegate, UICollisionBehaviorDelegate>

@property (strong, nonatomic) UIDynamicAnimator *dynamicAnimator;
@property (weak, nonatomic) IBOutlet UIView *greenView;
@property (weak, nonatomic) IBOutlet UIView *redView;

@end

@implementation DPGravityComparisonViewController

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
    
	// keep in mind the "Autolayout" Constraints for greenView
	self.dynamicAnimator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
	self.dynamicAnimator.delegate = self;
    
	NSArray *items = @[self.greenView, self.redView];
    
	//
	// Multiple gravity behavior per animator is undefined and may assert in the future
	//
	UIGravityBehavior *gravityBehavior = [[UIGravityBehavior alloc] initWithItems:items];
	UICollisionBehavior *collisionBehavior = [[UICollisionBehavior alloc] initWithItems:items];
	collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
	collisionBehavior.collisionDelegate = self;
	[self.dynamicAnimator addBehavior:gravityBehavior];
	[self.dynamicAnimator addBehavior:collisionBehavior];
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

#pragma mark - UICollisionBehaviorDelegate

- (void)collisionBehavior:(UICollisionBehavior *)behavior
      beganContactForItem:(id <UIDynamicItem> )item1
                 withItem:(id <UIDynamicItem> )item2
                  atPoint:(CGPoint)p {
}

- (void)collisionBehavior:(UICollisionBehavior *)behavior
      endedContactForItem:(id <UIDynamicItem> )item1
                 withItem:(id <UIDynamicItem> )item2 {
}

/*
 The identifier of a boundary created with translatesReferenceBoundsIntoBoundary
 or setTranslatesReferenceBoundsIntoBoundaryWithInsets is nil
 */
- (void) collisionBehavior:(UICollisionBehavior *)behavior
       beganContactForItem:(id <UIDynamicItem> )item
    withBoundaryIdentifier:(id <NSCopying> )identifier
                   atPoint:(CGPoint)p {
}

- (void) collisionBehavior:(UICollisionBehavior *)behavior
       endedContactForItem:(id <UIDynamicItem> )item
    withBoundaryIdentifier:(id <NSCopying> )identifier {
}

@end
