//
//  DPCircularLayoutViewController.m
//  DynamicsPlayground
//
//  Created by Renzo Pretto on 10/4/13.
//  Copyright (c) 2013 Renzo Pretto. All rights reserved.
//

#import "DPCircularLayoutViewController.h"


#import "UIColor+iOS7Colors.h"
#import "DPCollectionCircularViewCell.h"
#import "DPCircularLayout.h"


static const CGFloat kItemDiameter = 35.0f;


@interface DPCircularLayoutViewController () <UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *tapRecognizer;

- (IBAction)handleTapGesture:(UITapGestureRecognizer *)sender;

@property (assign,nonatomic) NSInteger cellCount;

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
    
    self.cellCount = 10;
    
    DPCircularLayout *circularLayout = [[DPCircularLayout alloc] initWithItemDiameter:kItemDiameter];
    
    self.collectionView.collectionViewLayout = circularLayout;
    
    [self.collectionView registerClass:[DPCollectionCircularViewCell class]
            forCellWithReuseIdentifier:[DPCollectionCircularViewCell cellIdentifier]];
    
    [self.collectionView reloadData];
    self.collectionView.backgroundColor = [UIColor iOS7lightGrayColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -

- (IBAction)handleTapGesture:(UITapGestureRecognizer *)sender {
    if (UIGestureRecognizerStateEnded == [sender state]) {
        
        CGPoint initialPoint = [sender locationInView:[self collectionView]];
        
        NSIndexPath *tappedCellPath = [self.collectionView indexPathForItemAtPoint:initialPoint];
        
        if (nil != tappedCellPath) {
            self.cellCount -= 1;
            [self.collectionView performBatchUpdates:^{
                [self.collectionView deleteItemsAtIndexPaths:@[tappedCellPath]];
            } completion:nil];
        }
        else {
            self.cellCount += 1;
            
            [self.collectionView performBatchUpdates:^{
                [self.collectionView insertItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:0
                                                                                   inSection:0]]];
                 } completion:nil];
        }
    }
}


#pragma mark - UICollectionViewDataSource


- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    NSInteger result = 0;
    result = [self cellCount];
    return result;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[DPCollectionCircularViewCell cellIdentifier]
                                                                           forIndexPath:indexPath];
    
//    [self configureCell:cell forItemAtIndexPath:indexPath];
    
    return cell;
}

//- (void)configureCell:(UICollectionViewCell *)cell
//   forItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//}




@end
