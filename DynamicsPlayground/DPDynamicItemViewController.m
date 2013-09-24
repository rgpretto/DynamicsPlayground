//
//  DPDynamicItemViewController.m
//  DynamicsPlayground
//
//  Created by Renzo Pretto on 9/23/13.
//  Copyright (c) 2013 Renzo Pretto. All rights reserved.
//

#import "DPDynamicItemViewController.h"

@interface DPDynamicItemViewController () <UIDynamicAnimatorDelegate>

@property (strong, nonatomic) UIDynamicAnimator *animator;

@property (weak, nonatomic) IBOutlet UIView *greenView;
@property (weak, nonatomic) IBOutlet UIView *redView;

@end

@implementation DPDynamicItemViewController

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


@end
