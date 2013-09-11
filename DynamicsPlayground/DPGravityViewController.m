//
//  DPGravityControllerViewController.m
//  DynamicsPlayground
//
//  Created by Renzo Pretto on 9/10/13.
//  Copyright (c) 2013 Renzo Pretto. All rights reserved.
//

#import "DPGravityControllerViewController.h"


static NSString * const kvoCOntext = @"6842C86E-6C60-4095-8E67-CB6B08B71CD1"; // genrated with uuidgen
static NSString * const kKeyPath = @"isRunning";

@interface DPGravityControllerViewController () <UIDynamicAnimatorDelegate>

@property (nonatomic) UIDynamicAnimator* animator;
@property (weak, nonatomic) IBOutlet UIView *greenView;

@end

@implementation DPGravityControllerViewController

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
    self.title = NSLocalizedString(@"Gravity", @"iPhone Master controller title");

    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:[self view]];
    self.animator.delegate = self;
    
    UIGravityBehavior *gravityBehavior = [[UIGravityBehavior alloc] initWithItems:@[[self greenView]]];
    
    [self.animator addBehavior:gravityBehavior];
    
    // keep in mind the "Autolayout" Constraints
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    if (kvoCOntext == (__bridge NSString *)context) {
        NSLog(@"Animator is %@", [self.animator isRunning] ? @"running" : @"stopped");
    } else {
        [super observeValueForKeyPath:keyPath
                             ofObject:object
                               change:change
                              context:context];
    }
}


#pragma mark - UIDynamicAnimatorDelegate

- (void)dynamicAnimatorWillResume:(UIDynamicAnimator*)animator {
    NSLog(@"Animator is %@", [self.animator isRunning] ? @"running" : @"stopped");

}

- (void)dynamicAnimatorDidPause:(UIDynamicAnimator*)animator {
    NSLog(@"Animator is %@", [self.animator isRunning] ? @"running" : @"stopped");

}

@end
