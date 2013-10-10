//
//  DPDynamicItemViewController.m
//  DynamicsPlayground
//
//  Created by Renzo Pretto on 9/23/13.
//  Copyright (c) 2013 Renzo Pretto. All rights reserved.
//

#import "DPDynamicItemViewController.h"

#import "UIColor+iOS7Colors.h"


@interface DPDynamicItemViewController () <UIDynamicAnimatorDelegate, UICollisionBehaviorDelegate>

@property (strong, nonatomic) UIDynamicAnimator *dynamicAnimator;
@property (strong, nonatomic) UICollisionBehavior *collisionBehavior;

@property (weak, nonatomic) IBOutlet UIView *greenView;
@property (weak, nonatomic) IBOutlet UIView *redView;

@end

@implementation DPDynamicItemViewController

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
    
	/*
     We want to show collisions between views and boundaries with different elasticities,
     we thus associate the two views to gravity and collision behaviors.
     We will only change the restitution parameter for one of these views.
	 */
	UIGravityBehavior *gravityBeahvior = [[UIGravityBehavior alloc] initWithItems:@[self.greenView, self.redView]];
	self.collisionBehavior = [[UICollisionBehavior alloc] initWithItems:@[self.greenView, self.redView]];
	self.collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
	self.collisionBehavior.collisionDelegate = self;
    
	//     make circle view
	//    self.redView.layer.cornerRadius = CGRectGetHeight([self.redView frame]) / 2.0f;
	//    self.redView.layer.masksToBounds = YES;
	//    self.redView.clipsToBounds = YES;
    
	/*
     A dynamic item behavior gives access to low-level properties of an item in
     Dynamics, here we change restitution on collisions only for redView,
     and keep square1 with its default value.
	 */
	UIDynamicItemBehavior *propertiesBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[self.redView]];
	propertiesBehavior.elasticity = 0.5;
	[propertiesBehavior addAngularVelocity:22.0 forItem:self.redView];
	propertiesBehavior.action = ^{
		// do something
	};
    
	[self.dynamicAnimator addBehavior:propertiesBehavior];
	[self.dynamicAnimator addBehavior:gravityBeahvior];
	[self.dynamicAnimator addBehavior:self.collisionBehavior];
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
