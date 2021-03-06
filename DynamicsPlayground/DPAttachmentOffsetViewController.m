//
//  DPAttachmentOffsetViewController.m
//  DynamicsPlayground
//
//  Created by Renzo Pretto on 9/16/13.
//  Copyright (c) 2013 Renzo Pretto. All rights reserved.
//

#import "DPAttachmentOffsetViewController.h"

#import "DPAnimatorStatusView.h"
#import "UIColor+iOS7Colors.h"


@interface DPAttachmentOffsetViewController () <UIDynamicAnimatorDelegate>

@property (weak, nonatomic) IBOutlet UIView *redView;
@property (weak, nonatomic) IBOutlet UIView *greenView;
@property (strong, nonatomic) UIDynamicAnimator *dynamicAnimator;
@property (strong, nonatomic) UIAttachmentBehavior *attachmentBehavior;

@property (strong, nonatomic) DPAnimatorStatusView *animatorStatusView;

- (IBAction)handlePanGesture:(UIPanGestureRecognizer *)sender;

@end



@implementation DPAttachmentOffsetViewController

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
	self.view.layer.borderWidth = 4.0f;
    
	self.dynamicAnimator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
	self.dynamicAnimator.delegate = self;
    
	UICollisionBehavior *collision = [[UICollisionBehavior alloc] initWithItems:@[self.greenView]];
	collision.translatesReferenceBoundsIntoBoundary = YES;
    
	UIOffset greenViewAttachmentPoint = UIOffsetZero;
    
	greenViewAttachmentPoint = UIOffsetMake(CGRectGetWidth([self.greenView bounds]) / 2.0,
	                                        CGRectGetHeight([self.greenView bounds]) / 2.0);
    
	//    greenViewAttachmentPoint = UIOffsetMake( CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds) );
	self.attachmentBehavior = [[UIAttachmentBehavior alloc] initWithItem:self.greenView
	                                                    offsetFromCenter:greenViewAttachmentPoint
	                                                      attachedToItem:self.redView
	                                                    offsetFromCenter:UIOffsetZero];
    
	//    [self.animator addBehavior:collision];
	[self.dynamicAnimator addBehavior:self.attachmentBehavior];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (IBAction)handlePanGesture:(UIPanGestureRecognizer *)gestureRecognizer {
	CGPoint anchorPoint = [gestureRecognizer locationInView:self.view];
    
	self.redView.center = anchorPoint;
    
	[self.dynamicAnimator updateItemUsingCurrentState:self.redView];
    
	NSLog(@"Attachment length = %.1f", [self.attachmentBehavior length]);
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

@end
