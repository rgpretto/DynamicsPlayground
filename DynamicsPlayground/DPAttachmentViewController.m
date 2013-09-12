//
//  DPAttachmentViewController.m
//  DynamicsPlayground
//
//  Created by Renzo Pretto on 9/12/13.
//  Copyright (c) 2013 Renzo Pretto. All rights reserved.
//

#import "DPAttachmentViewController.h"

@interface DPAttachmentViewController ()
@property (weak, nonatomic) IBOutlet UIView *redView;
@property (weak, nonatomic) IBOutlet UIView *greenView;
@property (strong, nonatomic) IBOutlet UIPanGestureRecognizer *panGestureRecognizer;

@property (strong, nonatomic) UIDynamicAnimator *animator;

@end

@implementation DPAttachmentViewController

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
    
    self.redView.gestureRecognizers = @[[self panGestureRecognizer]];
    
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:[self animator]];
    
    UIAttachmentBehavior *attachment = [[UIAttachmentBehavior alloc] initWithItem:(id<UIDynamicItem>)
                                                                 offsetFromCenter:(UIOffset)0
                                                                 attachedToAnchor:(CGPoint)];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
