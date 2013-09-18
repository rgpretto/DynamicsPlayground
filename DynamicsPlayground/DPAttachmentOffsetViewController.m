//
//  DPAttachmentOffsetViewController.m
//  DynamicsPlayground
//
//  Created by Renzo Pretto on 9/16/13.
//  Copyright (c) 2013 Renzo Pretto. All rights reserved.
//

#import "DPAttachmentOffsetViewController.h"

@interface DPAttachmentOffsetViewController () <UIDynamicAnimatorDelegate>

@property (weak, nonatomic) IBOutlet UIView *redView;
@property (weak, nonatomic) IBOutlet UIView *greenView;
@property (strong, nonatomic) UIDynamicAnimator *animator;
@property (strong, nonatomic) IBOutlet UIAttachmentBehavior *attachmentBehavior;

- (IBAction)handlePanGesture:(UIPanGestureRecognizer *)sender;

@end



@implementation DPAttachmentOffsetViewController

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
    
    UICollisionBehavior *collision = [[UICollisionBehavior alloc] initWithItems:@[self.greenView]];
    collision.translatesReferenceBoundsIntoBoundary = YES;
    
    UIOffset greenViewAttachmentPoint = UIOffsetZero;
    greenViewAttachmentPoint = UIOffsetMake(    CGRectGetWidth([self.greenView frame]) / 2.0 ,
                                                CGRectGetHeight([self.greenView frame]) /2.0 );
    
    self.attachmentBehavior = [[UIAttachmentBehavior alloc] initWithItem:self.greenView
                                                        offsetFromCenter:greenViewAttachmentPoint
                                                          attachedToItem:self.redView
                                                        offsetFromCenter:UIOffsetZero];
    
//    [self.animator addBehavior:collision];
    [self.animator addBehavior:self.attachmentBehavior];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)handlePanGesture:(UIPanGestureRecognizer *)gestureRecognizer {
    
    CGPoint anchorPoint = [gestureRecognizer locationInView:[self view]];
    
//    self.attachmentBehavior.anchorPoint = anchorPoint;
    self.redView.center = anchorPoint;

    [self.animator updateItemUsingCurrentState:[self redView]];
    
    NSLog(@"Attachment length = %0.1f", [self.attachmentBehavior length]);
    
}

#pragma mark - UIDynamicAnimatorDelegate

- (void)dynamicAnimatorWillResume:(UIDynamicAnimator*)animator {
    NSLog(@"Animator is %@", [self.animator isRunning] ? @"running" : @"stopped");
    
}

- (void)dynamicAnimatorDidPause:(UIDynamicAnimator*)animator {
    NSLog(@"Animator is %@", [self.animator isRunning] ? @"running" : @"stopped");
    
}

@end
