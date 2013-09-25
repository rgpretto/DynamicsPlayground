//
//  DPCollisionsViewController.m
//  DynamicsPlayground
//
//  Created by Renzo Pretto on 9/25/13.
//  Copyright (c) 2013 Renzo Pretto. All rights reserved.
//

#import "DPCollisionsViewController.h"

@interface DPCollisionsViewController () <UIDynamicAnimatorDelegate>

@property (weak, nonatomic) IBOutlet UIView *greenView1;
@property (weak, nonatomic) IBOutlet UIView *greenView2;
@property (weak, nonatomic) IBOutlet UIView *greenView3;
@property (weak, nonatomic) IBOutlet UIView *redView1;
@property (weak, nonatomic) IBOutlet UIView *redView2;
@property (weak, nonatomic) IBOutlet UIView *redView3;

@property (strong, nonatomic) UIDynamicAnimator *dynamicAnimator;

@end

@implementation DPCollisionsViewController

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
    NSArray *greens = @[self.greenView1, self.greenView2, self.greenView3];
    NSArray *reds = @[self.redView1, self.redView2, self.redView3];
    
    self.dynamicAnimator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
	self.dynamicAnimator.delegate = self;
    
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

- (void)didReceiveMemoryWarning
{
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
