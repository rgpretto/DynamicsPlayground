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


@interface DPSpringsAttachmentsViewController () <UIDynamicAnimatorDelegate>

@property (strong, nonatomic) UIDynamicAnimator *dynamicAnimator;
@property (strong, nonatomic) DPAnimatorStatusView *animatorStatusView;

@property (weak, nonatomic) IBOutlet UIView *greenView1;
@property (weak, nonatomic) IBOutlet UIView *greenView2;
@property (weak, nonatomic) IBOutlet UIView *greenView3;
@property (weak, nonatomic) IBOutlet UIView *redView1;
@property (weak, nonatomic) IBOutlet UIView *redView2;
@property (weak, nonatomic) IBOutlet UIView *redView3;

@property (weak, nonatomic) IBOutlet DPSpringSettingsView *spring1settingsView;
@property (weak, nonatomic) IBOutlet DPSpringSettingsView *spring2settingsView;
@property (weak, nonatomic) IBOutlet DPSpringSettingsView *spring3settingsView;

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
	self.view.layer.borderWidth = 4.0f;
    
	UIAttachmentBehavior *attachmentBehavior1 = nil;
	UIAttachmentBehavior *attachmentBehavior2 = nil;
	UIAttachmentBehavior *attachmentBehavior3 = nil;
        
	attachmentBehavior1 = [[UIAttachmentBehavior alloc] initWithItem:self.greenView1
	                                               attachedToAnchor:[self.redView1 center]];
	attachmentBehavior1.frequency = 2.0;
	attachmentBehavior1.damping = 0.1;
    
	attachmentBehavior2 = [[UIAttachmentBehavior alloc] initWithItem:self.greenView2
                                                    attachedToAnchor:[self.redView2 center]];
	attachmentBehavior2.frequency = 2.0;
	attachmentBehavior2.damping = 0.3;

    attachmentBehavior3 = [[UIAttachmentBehavior alloc] initWithItem:self.greenView3
                                                    attachedToAnchor:[self.redView3 center]];
	attachmentBehavior3.frequency = 4.0;
	attachmentBehavior3.damping = 0.1;
    
    UIPushBehavior *push = [[UIPushBehavior alloc] initWithItems:@[self.greenView1, self.greenView2, self.greenView3]
                                                            mode:UIPushBehaviorModeInstantaneous];
    push.magnitude = 7.0f;
    push.angle = M_PI_2;
    
    
    [self.spring1settingsView updateWithSpringAttachment:attachmentBehavior1];
    [self.spring2settingsView updateWithSpringAttachment:attachmentBehavior2];
    [self.spring3settingsView updateWithSpringAttachment:attachmentBehavior3];
    
	self.dynamicAnimator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
	self.dynamicAnimator.delegate = self;
	[self.dynamicAnimator addBehavior:attachmentBehavior1];
	[self.dynamicAnimator addBehavior:attachmentBehavior2];
	[self.dynamicAnimator addBehavior:attachmentBehavior3];
    
    [self.dynamicAnimator addBehavior:push];

}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
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
