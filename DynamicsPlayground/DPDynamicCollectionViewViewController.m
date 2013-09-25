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

@interface DPDynamicCollectionViewViewController () <UICollectionViewDataSource, UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) UICollectionViewFlowLayout *flowLayout;

@end

@implementation DPDynamicCollectionViewViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
		// Custom initialization
	}
	return self;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view.
    
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
	result = 20;
	return result;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	UICollectionViewCell *cell = nil;
	cell = [collectionView dequeueReusableCellWithReuseIdentifier:[DPCollectionViewCell cellIdentifier]
	                                                 forIndexPath:indexPath];
    
	[self configureCell:cell forItemAtIndexPath:indexPath];
    
	return cell;
}

- (void) configureCell:(UICollectionViewCell *)cell
    forItemAtIndexPath:(NSIndexPath *)indexPath {
}

@end
