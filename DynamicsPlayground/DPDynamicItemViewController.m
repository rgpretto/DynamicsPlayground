//
//  DPDynamicItemViewController.m
//  DynamicsPlayground
//
//  Created by Renzo Pretto on 9/23/13.
//  Copyright (c) 2013 Renzo Pretto. All rights reserved.
//

#import "DPDynamicItemViewController.h"

#import <QuartzCore/QuartzCore.h>

@interface DPDynamicItemViewController () <UIDynamicAnimatorDelegate>

@property (strong, nonatomic) UIDynamicAnimator *animator;

@property (weak, nonatomic) IBOutlet UIView *greenView;
@property (weak, nonatomic) IBOutlet UIView *redView;

@end

@implementation DPDynamicItemViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    self.animator.delegate = self;
    
    /*
     We want to show collisions between views and boundaries with different elasticities,
     we thus associate the two views to gravity and collision behaviors.
     We will only change the restitution parameter for one of these views.
     */
    UIGravityBehavior* gravityBeahvior = [[UIGravityBehavior alloc] initWithItems:@[self.greenView, self.redView]];
    UICollisionBehavior* collisionBehavior = [[UICollisionBehavior alloc] initWithItems:@[self.greenView, self.redView]];
    collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
    
    /*
     A dynamic item behavior gives access to low-level properties of an item in
     Dynamics, here we change restitution on collisions only for redView,
     and keep square1 with its default value.
     */
    UIDynamicItemBehavior* propertiesBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[self.redView]];
    propertiesBehavior.elasticity = 0.5;
    [propertiesBehavior addAngularVelocity:22.0 forItem:self.redView];
    
//    self.redView.layer.cornerRadius = CGRectGetWidth(self.redView.frame) / 2.0f;
//    self.redView.layer.masksToBounds = YES;
    
    [self.animator addBehavior:propertiesBehavior];
    [self.animator addBehavior:gravityBeahvior];
    [self.animator addBehavior:collisionBehavior];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIDynamicAnimatorDelegate

- (void)dynamicAnimatorWillResume:(UIDynamicAnimator*)animator {
    NSLog(@"Animator is %@", [self.animator isRunning] ? @"running" : @"stopped");
    
}

- (void)dynamicAnimatorDidPause:(UIDynamicAnimator*)animator {
    NSLog(@"Animator is %@", [self.animator isRunning] ? @"running" : @"stopped");
    
}


@end
