//
//  DPAttachmentViewController.m
//  DynamicsPlayground
//
//  Created by Renzo Pretto on 9/12/13.
//  Copyright (c) 2013 Renzo Pretto. All rights reserved.
//

#import "DPSpringsAttachmentsViewController.h"

#import "DPAnimatorStatusView.h"
#import "UIColor+iOS7Colors.h"
#import "DPSpringSettingsView.h"

#define ATTACHMENT_POINT


@interface DPSpringsAttachmentsViewController () <UIDynamicAnimatorDelegate>


@property (weak, nonatomic) IBOutlet UIView *greenView1;
@property (weak, nonatomic) IBOutlet UIView *greenView2;
@property (weak, nonatomic) IBOutlet UIView *greenView3;
@property (weak, nonatomic) IBOutlet UIView *redView1;
@property (weak, nonatomic) IBOutlet UIView *redView2;
@property (weak, nonatomic) IBOutlet UIView *redView3;

@property (strong, nonatomic) UIDynamicAnimator *dynamicAnimator;

@property (strong, nonatomic) DPAnimatorStatusView *animatorStatusView;

#ifdef ATTACHMENT_POINT
@property (strong, nonatomic) UIAttachmentBehavior *attachmentBehavior;
#endif
@property (weak, nonatomic) IBOutlet DPSpringSettingsView *spring1settingsView;
@property (weak, nonatomic) IBOutlet DPSpringSettingsView *spring2settingsView;
@property (weak, nonatomic) IBOutlet DPSpringSettingsView *spring3settingsView;


- (IBAction)handlePanGesture:(UIPanGestureRecognizer *)sender;


@end

@implementation DPSpringsAttachmentsViewController

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
    
	UIGravityBehavior *gravity = [[UIGravityBehavior alloc] initWithItems:@[self.greenView1]];
    
	UIAttachmentBehavior *attachmentBehavior = nil;
	UICollisionBehavior *collisionBehavior = nil;
    
	collisionBehavior = [[UICollisionBehavior alloc] initWithItems:@[self.greenView1]];
	collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
    
	CGPoint anchorPoint = [self.redView center];
	attachmentBehavior = [[UIAttachmentBehavior alloc] initWithItem:self.greenView1
	                                               attachedToAnchor:anchorPoint];
	// These parameters set the attachment in spring mode, instead of a rigid connection.
	attachmentBehavior.frequency = 4.0; // 2.0, 2.0, 4.0
	attachmentBehavior.damping = 0.1;   // 0.1, 0.5, 0.1

    
    UIPushBehavior *push = [[UIPushBehavior alloc] initWithItems:@[self.greenView1]
                                                            mode:UIPushBehaviorModeInstantaneous];
    push.magnitude = 5.0f;
    push.angle = M_PI_2;
    
	self.dynamicAnimator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
	self.dynamicAnimator.delegate = self;
//	[self.dynamicAnimator addBehavior:collisionBehavior];
//	[self.dynamicAnimator addBehavior:gravity];
	[self.dynamicAnimator addBehavior:attachmentBehavior];

        
    [self.dynamicAnimator addBehavior:push];
        
#ifdef ATTACHMENT_POINT
	self.attachmentBehavior = attachmentBehavior;
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

@end
