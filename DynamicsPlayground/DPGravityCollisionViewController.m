//
//  DPGravityControllerViewController.m
//  DynamicsPlayground
//
//  Created by Renzo Pretto on 9/10/13.
//  Copyright (c) 2013 Renzo Pretto. All rights reserved.
//

#import "DPGravityCollisionViewController.h"


@interface DPGravityCollisionViewController () <UIDynamicAnimatorDelegate, UICollisionBehaviorDelegate>

@property (nonatomic) UIDynamicAnimator* animator;
@property (weak, nonatomic) IBOutlet UIView *greenView;

@end

@implementation DPGravityCollisionViewController

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
    self.title = NSLocalizedString(@"Gravity + Collision", @"iPhone Master controller title");

    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:[self view]];
    self.animator.delegate = self;
    
    NSArray *items = @[[self greenView]];
        
    UIGravityBehavior *gravityBehavior = [[UIGravityBehavior alloc] initWithItems:items];
    UICollisionBehavior *collisionBehavior = [[UICollisionBehavior alloc] initWithItems:items];
    collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
    collisionBehavior.collisionDelegate = self;
    
    [self.animator addBehavior:gravityBehavior];
    [self.animator addBehavior:collisionBehavior];
    // keep in mind the "Autolayout" Constraints
    
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


#pragma mark - UICollisionBehaviorDelegate

- (void)collisionBehavior:(UICollisionBehavior*)behavior
      beganContactForItem:(id <UIDynamicItem>)item1
                 withItem:(id <UIDynamicItem>)item2
                  atPoint:(CGPoint)p {
    
}

- (void)collisionBehavior:(UICollisionBehavior*)behavior
      endedContactForItem:(id <UIDynamicItem>)item1
                 withItem:(id <UIDynamicItem>)item2 {
    
}

/*
    The identifier of a boundary created with translatesReferenceBoundsIntoBoundary
    or setTranslatesReferenceBoundsIntoBoundaryWithInsets is nil
*/
 - (void)collisionBehavior:(UICollisionBehavior*)behavior
      beganContactForItem:(id <UIDynamicItem>)item
   withBoundaryIdentifier:(id <NSCopying>)identifier
                   atPoint:(CGPoint)p {
     
 }

- (void)collisionBehavior:(UICollisionBehavior*)behavior
      endedContactForItem:(id <UIDynamicItem>)item
   withBoundaryIdentifier:(id <NSCopying>)identifier {
    
}


@end
