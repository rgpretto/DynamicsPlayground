//
//  DPAttachmentOffsetViewController.m
//  DynamicsPlayground
//
//  Created by Renzo Pretto on 9/16/13.
//  Copyright (c) 2013 Renzo Pretto. All rights reserved.
//

#import "DPAttachmentOffsetViewController.h"

@interface DPAttachmentOffsetViewController ()
@property (weak, nonatomic) IBOutlet UIView *redView;
@property (weak, nonatomic) IBOutlet UIView *greenView;
@property (strong, nonatomic) UIDynamicAnimator *animator;
@property (strong, nonatomic) IBOutlet UIPanGestureRecognizer *panGestureRecognizer;
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
    
    UICollisionBehavior *collision = [[UICollisionBehavior alloc] initWithItems:@[self.greenView]];
    
    
    
//    UIAttachmentBehavior *attachmentBehavior = [[UIAttachmentBehavior alloc] initWithItem:[(id<UIDynamicItem>)
//                                                                         ]offsetFromCenter:(UIOffset)
//                                                                           attachedToItem:(id<UIDynamicItem>)
//                                                                         offsetFromCenter:(UIOffset)];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)handlePanGesture:(UIPanGestureRecognizer *)sender {
}
@end
