//
//  DPAttachmentViewController.m
//  DynamicsPlayground
//
//  Created by Renzo Pretto on 9/12/13.
//  Copyright (c) 2013 Renzo Pretto. All rights reserved.
//

#import "DPSpringAttachmentViewController.h"

@interface DPSpringAttachmentViewController () <UIDynamicAnimatorDelegate>


@property (weak, nonatomic) IBOutlet UIView *redView;
@property (weak, nonatomic) IBOutlet UIView *greenView;

@property (strong, nonatomic) UIDynamicAnimator *animator;

- (IBAction)handlePanGesture:(UIPanGestureRecognizer *)sender;


@end

@implementation DPSpringAttachmentViewController

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

    UIGravityBehavior *gravity = [[UIGravityBehavior alloc] initWithItems:@[[self greenView]]];
    


    UICollisionBehavior *collisionBehavior = [[UICollisionBehavior alloc] initWithItems:@[self.redView, self.greenView]];
    collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
    
    UIAttachmentBehavior *attachmentBehavior = [[UIAttachmentBehavior alloc] initWithItem:[self greenView]
                                                                           attachedToItem:[self redView]];
    attachmentBehavior.damping = 0.1;
    attachmentBehavior.frequency = 3.0;


    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:[self view]];
    self.animator.delegate = self;
    [self.animator addBehavior:collisionBehavior];
    [self.animator addBehavior:gravity];
    [self.animator addBehavior:attachmentBehavior];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)handlePanGesture:(UIPanGestureRecognizer *)gestureRecognizer {
    CGPoint anchorPoint = [gestureRecognizer locationInView:[self view]];
    self.redView.center = anchorPoint;
    
    [self.animator updateItemUsingCurrentState:[self redView]];
}

#pragma mark - UIDynamicAnimatorDelegate

- (void)dynamicAnimatorWillResume:(UIDynamicAnimator*)animator {
    NSLog(@"Animator is %@", [self.animator isRunning] ? @"running" : @"stopped");
    
}

- (void)dynamicAnimatorDidPause:(UIDynamicAnimator*)animator {
    NSLog(@"Animator is %@", [self.animator isRunning] ? @"running" : @"stopped");
    
}






@end
