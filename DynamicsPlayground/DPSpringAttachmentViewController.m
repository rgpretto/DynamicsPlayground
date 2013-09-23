//
//  DPAttachmentViewController.m
//  DynamicsPlayground
//
//  Created by Renzo Pretto on 9/12/13.
//  Copyright (c) 2013 Renzo Pretto. All rights reserved.
//

#import "DPSpringAttachmentViewController.h"


#define ATTACHMENT_POINT


@interface DPSpringAttachmentViewController () <UIDynamicAnimatorDelegate>


@property (weak, nonatomic) IBOutlet UIView *redView;
@property (weak, nonatomic) IBOutlet UIView *greenView;

@property (strong, nonatomic) UIDynamicAnimator *animator;

#ifdef ATTACHMENT_POINT
@property (strong, nonatomic) UIAttachmentBehavior *attachmentBehavior;
#endif

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
    
    UIAttachmentBehavior *attachmentBehavior = nil;
    UICollisionBehavior *collisionBehavior = nil;
    
#ifdef ATTACHMENT_POINT
    collisionBehavior = [[UICollisionBehavior alloc] initWithItems:@[self.greenView]];
    collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
    
    CGPoint anchorPoint = self.redView.center;
    attachmentBehavior = [[UIAttachmentBehavior alloc] initWithItem:self.greenView attachedToAnchor:anchorPoint];
    // These parameters set the attachment in spring mode, instead of a rigid connection.
    [attachmentBehavior setFrequency:1.0];
    [attachmentBehavior setDamping:0.1];
#else
    collisionBehavior = [[UICollisionBehavior alloc] initWithItems:@[self.redView, self.greenView]];
    collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
    attachmentBehavior = [[UIAttachmentBehavior alloc] initWithItem:[self greenView]
                                                     attachedToItem:[self redView]];
    attachmentBehavior.damping = 0.1;
    attachmentBehavior.frequency = 3.0;
#endif


    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:[self view]];
    self.animator.delegate = self;
    [self.animator addBehavior:collisionBehavior];
    [self.animator addBehavior:gravity];
    [self.animator addBehavior:attachmentBehavior];
    
#ifdef ATTACHMENT_POINT
    self.attachmentBehavior = attachmentBehavior;
#endif
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)handlePanGesture:(UIPanGestureRecognizer *)gestureRecognizer {
    CGPoint anchorPoint = [gestureRecognizer locationInView:[self view]];
    self.redView.center = anchorPoint;

#ifdef ATTACHMENT_POINT
    [self.attachmentBehavior setAnchorPoint:anchorPoint];
#else
    [self.animator updateItemUsingCurrentState:[self redView]];
#endif
}

#pragma mark - UIDynamicAnimatorDelegate

- (void)dynamicAnimatorWillResume:(UIDynamicAnimator*)animator {
    NSLog(@"Animator is %@", [self.animator isRunning] ? @"running" : @"stopped");
    
}

- (void)dynamicAnimatorDidPause:(UIDynamicAnimator*)animator {
    NSLog(@"Animator is %@", [self.animator isRunning] ? @"running" : @"stopped");
    
}






@end
