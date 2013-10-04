//
//  DPCircularLayoutViewController.m
//  DynamicsPlayground
//
//  Created by Renzo Pretto on 10/4/13.
//  Copyright (c) 2013 Renzo Pretto. All rights reserved.
//

#import "DPCircularLayoutViewController.h"

@interface DPCircularLayoutViewController ()

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *tapRecognizer;

- (IBAction)handleTapGesture:(UITapGestureRecognizer *)sender;

@end

@implementation DPCircularLayoutViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)handleTapGesture:(UITapGestureRecognizer *)sender {
    
}


@end
