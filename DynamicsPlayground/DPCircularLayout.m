//
//  DPCircularLayout.m
//  DynamicsPlayground
//
//  Created by Renzo Pretto on 10/4/13.
//  Copyright (c) 2013 Renzo Pretto. All rights reserved.
//

#import "DPCircularLayout.h"

static const CGFloat kItemSize = 70;



@implementation DPCircularLayout

- (void)prepareLayout {
    [super prepareLayout];
    
    CGSize size = self.collectionView.frame.size;
    self.cellCount = [[self collectionView] numberOfItemsInSection:0];
    
    self.center = CGPointMake(size.width / 2.0f, size.height / 2.0f);
    self.radius = MIN(size.width, size.height) / 2.5f;
}

- (CGSize)collectionViewContentSize {
    CGSize result = CGSizeZero;
    result = [self collectionView].frame.size;
    return result;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *result = nil;
    
    result = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    result.size = CGSizeMake(kItemSize, kItemSize);
    result.center = CGPointMake(self.center.x + self.radius * cosf(2 * indexPath.item * M_PI / self.cellCount),
                                self.center.y + self.radius * sinf(2 * indexPath.item * M_PI / self.cellCount));

    return result;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSMutableArray *result = nil;
    
    result = [NSMutableArray array];
    for (NSInteger i = 0; i < [self cellCount]; ++i) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *currAttribute = [self layoutAttributesForItemAtIndexPath:indexPath];
        [result addObject:currAttribute];
    }
    
    return result;
}

@end
