//
//  DPSnapViewController.m
//  DynamicsPlayground
//
//  Created by Renzo Pretto on 9/18/13.
//  Copyright (c) 2013 Renzo Pretto. All rights reserved.
//

#import "DPSnapViewController.h"

@interface DPSnapViewController () <UIDynamicAnimatorDelegate>

- (IBAction)handleTapGesture:(UITapGestureRecognizer *)sender;

@property (strong, nonatomic) UIDynamicAnimator *animator;
@property (weak, nonatomic) IBOutlet UIView *greenView;
@property (strong, nonatomic) UISnapBehavior *snapBehavior;

@end

@implementation DPSnapViewController

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

- (IBAction)handleTapGesture:(UITapGestureRecognizer *)gestureRecognizer {
    
    CGPoint snapPoint = [gestureRecognizer locationInView:self.view];


    // remove previous snap behaviour if any exists
    if (nil  != self.snapBehavior) {
        [self.animator removeBehavior:self.snapBehavior];
    }

    self.snapBehavior = [[UISnapBehavior alloc] initWithItem:self.greenView
                                                 snapToPoint:snapPoint];
    NSLog(@"Default damping = %.1f", [self.snapBehavior damping]);
    
    [self.animator addBehavior:self.snapBehavior];
    
}


#pragma mark - UIDynamicAnimatorDelegate

- (void)dynamicAnimatorWillResume:(UIDynamicAnimator*)animator {
    NSLog(@"Animator is %@", [self.animator isRunning] ? @"running" : @"stopped");
    
}

- (void)dynamicAnimatorDidPause:(UIDynamicAnimator*)animator {
    NSLog(@"Animator is %@", [self.animator isRunning] ? @"running" : @"stopped");
    
}


@end
