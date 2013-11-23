//
//  DPAttachmentOffsetViewController.m
//  DynamicsPlayground
//
//  Created by Renzo Pretto on 9/16/13.
//  Copyright (c) 2013 Renzo Pretto. All rights reserved.
//

#import "DPMultipleAttachmentOffsetViewController.h"

#import "DPAnimatorStatusView.h"
#import "UIColor+iOS7Colors.h"


@interface DPMultipleAttachmentOffsetViewController () <UIDynamicAnimatorDelegate>

@property (weak, nonatomic) IBOutlet UIView *redView;
@property (weak, nonatomic) IBOutlet UIView *greenView;
@property (weak, nonatomic) IBOutlet UIView *blackView;

@property (strong, nonatomic) UIDynamicAnimator *dynamicAnimator;
@property (strong, nonatomic) DPAnimatorStatusView *animatorStatusView;
@property (strong, nonatomic) UIAttachmentBehavior *firstAttachment;


- (IBAction)handlePanGesture:(UIPanGestureRecognizer *)sender;

@end



@implementation DPMultipleAttachmentOffsetViewController

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
    
    self.view.layer.borderColor = [UIColor iOS7greenColor].CGColor;
	self.view.layer.borderWidth = 4.0f;
    
	self.dynamicAnimator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
	self.dynamicAnimator.delegate = self;
    
    UIGravityBehavior *gravity = [[UIGravityBehavior alloc] initWithItems:@[self.greenView, self.blackView]];
    
	UIOffset redToGreenOffset = UIOffsetZero;
	redToGreenOffset = UIOffsetMake(-CGRectGetWidth([self.greenView bounds]) / 2.0,
                                    -CGRectGetHeight([self.greenView bounds]) / 2.0);
    
    UIOffset greenToBlackOffset = UIOffsetZero;
	greenToBlackOffset = UIOffsetMake(CGRectGetWidth([self.greenView bounds]) / 2.0,
                                      CGRectGetHeight([self.greenView bounds]) / 2.0);

    UIOffset blackTogreenOffset = UIOffsetZero;
	blackTogreenOffset = UIOffsetMake(CGRectGetWidth([self.greenView bounds]) / 4.0,
                                      CGRectGetHeight([self.greenView bounds]) / 4.0);

    self.firstAttachment = [[UIAttachmentBehavior alloc] initWithItem:self.greenView
                                                     offsetFromCenter:redToGreenOffset
                                                     attachedToAnchor:[self.redView center]];

    UIAttachmentBehavior *secondAttachment = nil;
    secondAttachment = [[UIAttachmentBehavior alloc] initWithItem:self.greenView
                                                 offsetFromCenter:greenToBlackOffset
                                                   attachedToItem:self.blackView
                                                 offsetFromCenter:blackTogreenOffset];
    
    [self.dynamicAnimator addBehavior:gravity];
	[self.dynamicAnimator addBehavior:self.firstAttachment];
	[self.dynamicAnimator addBehavior:secondAttachment];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (IBAction)handlePanGesture:(UIPanGestureRecognizer *)gestureRecognizer {
	CGPoint newAnchorPoint = [gestureRecognizer locationInView:self.view];
    
	self.redView.center = newAnchorPoint;
    self.firstAttachment.anchorPoint = newAnchorPoint;
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
