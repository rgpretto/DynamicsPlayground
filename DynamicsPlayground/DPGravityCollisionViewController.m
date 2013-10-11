//
//  DPGravityControllerViewController.m
//  DynamicsPlayground
//
//  Created by Renzo Pretto on 9/10/13.
//  Copyright (c) 2013 Renzo Pretto. All rights reserved.
//

#import "DPGravityCollisionViewController.h"


#import "DPAnimatorStatusView.h"
#import "UIColor+iOS7Colors.h"

#define CUSTOM_BEHAVIOR

#ifdef CUSTOM_BEHAVIOR
#import "DPGravityCollisionBehavior.h"
#endif


@interface DPGravityCollisionViewController () <UIDynamicAnimatorDelegate, UICollisionBehaviorDelegate>

@property (strong, nonatomic) UIDynamicAnimator *dynamicAnimator;
@property (weak, nonatomic) IBOutlet UIView *greenView;

@property (strong, nonatomic) DPAnimatorStatusView *animatorStatusView;

@end

@implementation DPGravityCollisionViewController

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
    
	// keep in mind the "Autolayout" Constraints for greenView
	self.dynamicAnimator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
	self.dynamicAnimator.delegate = self;
    
	NSArray *items = @[self.greenView];
    
	//
	// Multiple gravity behavior per animator is undefined and may assert in the future
	//
#ifdef CUSTOM_BEHAVIOR
    
	DPGravityCollisionBehavior *gravityAndCollision = nil;
	gravityAndCollision = [[DPGravityCollisionBehavior alloc] initWithItems:items];
	[self.dynamicAnimator addBehavior:gravityAndCollision];
    
#else
    
	UIGravityBehavior *gravityBehavior = [[UIGravityBehavior alloc] initWithItems:items];
	UICollisionBehavior *collisionBehavior = [[UICollisionBehavior alloc] initWithItems:items];
	collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
	collisionBehavior.collisionDelegate = self;
    
    //
    //   NB: uncomment this code to add a collision boundary
    //
    // ----------------------------------------------------------------------------
    //    CGPoint firstPoint = CGPointMake(0.0f, CGRectGetMidY(self.view.bounds));
    //    CGPoint secondPoint = CGPointMake(firstPoint .x + CGRectGetMidX(self.view.bounds) - 30.0f, firstPoint.y);
    //
    //    [collisionBehavior addBoundaryWithIdentifier:@"first boundary"
    //                                       fromPoint:firstPoint
    //                                         toPoint:secondPoint];
    //
    //
    //    UIView *collisionBoundaryView = [[UIView alloc] initWithFrame:CGRectMake(firstPoint.x, firstPoint.y, secondPoint.x, 10.0f)];
    //    collisionBoundaryView.backgroundColor = [UIColor redColor];
    //    [self.view addSubview:collisionBoundaryView];
    // ----------------------------------------------------------------------------
    
	[self.dynamicAnimator addBehavior:gravityBehavior];
	[self.dynamicAnimator addBehavior:collisionBehavior];
    
#endif
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
	NSLog(@"Began contact with boundary \"%@\"", identifier);
}

- (void) collisionBehavior:(UICollisionBehavior *)behavior
       endedContactForItem:(id <UIDynamicItem> )item
    withBoundaryIdentifier:(id <NSCopying> )identifier {
	NSLog(@"End contact with boundary \"%@\"", identifier);
}

@end
