//
//  DPAttachmentViewController.m
//  DynamicsPlayground
//
//  Created by Renzo Pretto on 9/12/13.
//  Copyright (c) 2013 Renzo Pretto. All rights reserved.
//

#import "DPAttachmentViewController.h"

@interface DPAttachmentViewController () <UIDynamicAnimatorDelegate, UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UIView *redView;
@property (weak, nonatomic) IBOutlet UIView *greenView;
@property (strong, nonatomic) IBOutlet UIPanGestureRecognizer *panGestureRecognizer;

@property (strong, nonatomic) UIDynamicAnimator *animator;
@property (strong, nonatomic) UIAttachmentBehavior *attachmentBehavior;

- (IBAction)handlePanGesture:(UIPanGestureRecognizer *)sender;


@end

@implementation DPAttachmentViewController

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

    /*
     use gravity behavior to start animation and collision detection to stop animation
     */
    
    UICollisionBehavior *collisionBehavior = [[UICollisionBehavior alloc] initWithItems:@[[self redView]]];
    collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
    
    self.attachmentBehavior = [[UIAttachmentBehavior alloc] initWithItem:[self greenView]
                                                          attachedToItem:[self redView]];
    UIGravityBehavior *gravity = [[UIGravityBehavior alloc] initWithItems:@[[self greenView]]];
    

    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:[self view]];
    self.animator.delegate = self;
    [self.animator addBehavior:collisionBehavior];
    [self.animator addBehavior:gravity];
    [self.animator addBehavior:[self attachmentBehavior]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)handlePanGesture:(UIPanGestureRecognizer *)gestureRecognizer {
    CGPoint anchorPoint = [gestureRecognizer locationInView:[self view]];
    self.redView.center = anchorPoint;
    
    [self.animator removeBehavior:[self attachmentBehavior]];
    [self.animator addBehavior:[self attachmentBehavior]];
}

#pragma mark - UIDynamicAnimatorDelegate

- (void)dynamicAnimatorWillResume:(UIDynamicAnimator*)animator {
    NSLog(@"Animator is %@", [self.animator isRunning] ? @"running" : @"stopped");
    
}

- (void)dynamicAnimatorDidPause:(UIDynamicAnimator*)animator {
    NSLog(@"Animator is %@", [self.animator isRunning] ? @"running" : @"stopped");
    
}






@end
