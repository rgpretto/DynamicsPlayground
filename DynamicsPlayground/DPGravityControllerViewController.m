//
//  DPGravityControllerViewController.m
//  DynamicsPlayground
//
//  Created by Renzo Pretto on 9/10/13.
//  Copyright (c) 2013 Renzo Pretto. All rights reserved.
//

#import "DPGravityControllerViewController.h"


@interface DPGravityControllerViewController ()

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
    
    UIGravityBehavior *gravityBehavior = [[UIGravityBehavior alloc] initWithItems:@[[self greenView]]];
    
    [self.animator addBehavior:gravityBehavior];
    
    // keep in mind the "Autolayout" Constraints
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
