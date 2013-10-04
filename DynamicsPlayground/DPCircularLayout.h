//
//  DPCircularLayout.h
//  DynamicsPlayground
//
//  Created by Renzo Pretto on 10/4/13.
//  Copyright (c) 2013 Renzo Pretto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DPCircularLayout : UICollectionViewLayout

@property (nonatomic, assign) CGPoint center;
@property (nonatomic, assign) CGFloat radius;
@property (nonatomic, assign) NSInteger cellCount;

- (instancetype)init;
- (instancetype)initWithItemDiameter:(CGFloat)diameter;

@end
