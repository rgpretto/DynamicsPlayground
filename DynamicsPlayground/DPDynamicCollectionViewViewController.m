//
//  DPViewController.m
//  DynamicsPlayground
//
//  Created by Renzo Pretto on 9/21/13.
//  Copyright (c) 2013 Renzo Pretto. All rights reserved.
//

#import "DPDynamicCollectionViewViewController.h"

#import "DPCollectionViewCell.h"
#import "DPFixedSpringFlowLayout.h"
#import "DPProportionalSpringFlowLayout.h"

const NSInteger kCellCount = 20;

@interface DPDynamicCollectionViewViewController () <UICollectionViewDataSource, UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) UICollectionViewFlowLayout *flowLayout;

@property (strong, nonatomic) NSMutableArray *colors;

@end

@implementation DPDynamicCollectionViewViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {

	}
	return self;
}

- (void)viewDidLoad {
	[super viewDidLoad];
    
    srand48(time(0));
    
    self.colors = [NSMutableArray array];
    for (NSInteger i = 0; i < kCellCount; ++i) {
        UIColor *color = [UIColor colorWithRed:drand48()
                                           green:drand48()
                                            blue:drand48()
                                           alpha:1.0f];
        [self.colors addObject:color];
    
    }
    
	[self.collectionView registerClass:[DPCollectionViewCell class]
	        forCellWithReuseIdentifier:[DPCollectionViewCell cellIdentifier]];
    
    //    self.flowLayout = [[DPFixedSpringFlowLayout alloc] init];
	self.flowLayout = [[DPProportionalSpringFlowLayout alloc] init];
    
	[self.collectionView setCollectionViewLayout:[self flowLayout]];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
	NSInteger result = NO;
	result = kCellCount;
	return result;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	DPCollectionViewCell *cell = nil;
	cell = (DPCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:[DPCollectionViewCell cellIdentifier]
                                                                             forIndexPath:indexPath];
	[self configureCell:cell forItemAtIndexPath:indexPath];
    
	return cell;
}

- (void) configureCell:(DPCollectionViewCell *)cell
    forItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self.colors count] > 0) {
        UIColor *currColor = self.colors[indexPath.row];
        cell.backgroundColor = currColor;
        
        cell.textLabel.text = [@(indexPath.row) stringValue];
    }
}

@end
