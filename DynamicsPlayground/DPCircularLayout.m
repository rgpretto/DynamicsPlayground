//
//  DPCircularLayout.m
//  DynamicsPlayground
//
//  Created by Renzo Pretto on 10/4/13.
//  Copyright (c) 2013 Renzo Pretto. All rights reserved.
//

#import "DPCircularLayout.h"


@interface DPCircularLayout ()

@property (assign, nonatomic) CGFloat itemDiameter;

@end

@implementation DPCircularLayout

- (instancetype)init {
    return nil;
}

- (instancetype)initWithItemDiameter:(CGFloat)diameter {
    self = [super init];
    if (self) {
        self.itemDiameter = diameter;
    }
    return self;
}

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
    UICollectionViewLayoutAttributes *attributes = nil;
    
    attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    attributes.size = CGSizeMake([self itemDiameter], [self itemDiameter]);
    attributes.center = CGPointMake(self.center.x + self.radius * cosf(2 * indexPath.item * M_PI / self.cellCount),
                                    self.center.y + self.radius * sinf(2 * indexPath.item * M_PI / self.cellCount));

    return attributes;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSMutableArray *attributes = nil;
    
    attributes = [NSMutableArray array];
    for (NSInteger i = 0; i < [self cellCount]; ++i) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *currAttribute = [self layoutAttributesForItemAtIndexPath:indexPath];
        [attributes addObject:currAttribute];
    }
    
    return attributes;
}


//- (UICollectionViewLayoutAttributes *)initialLayoutAttributesForAppearingItemAtIndexPath:(NSIndexPath *)itemIndexPath {
//    UICollectionViewLayoutAttributes *attribute = nil;
//    
//    attribute = [self layoutAttributesForItemAtIndexPath:itemIndexPath];
//    attribute.alpha = 0.0f;
//    attribute.center = CGPointMake(self.center.x, self.center.y);
//    
//    return attribute;
//}
//
//
//- (UICollectionViewLayoutAttributes *)finalLayoutAttributesForDisappearingItemAtIndexPath:(NSIndexPath *)itemIndexPath {
//    UICollectionViewLayoutAttributes *attribute = nil;
//    
//    attribute = [self layoutAttributesForItemAtIndexPath:itemIndexPath];
//    attribute.alpha = 0.0f;
//    attribute.center = CGPointMake(self.center.x, self.center.y);
//    attribute.transform3D = CATransform3DMakeScale(0.1f, 0.1f, 0.1f);
//    
//    return attribute;
//}


@end
