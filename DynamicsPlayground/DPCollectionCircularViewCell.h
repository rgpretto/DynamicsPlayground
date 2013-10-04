//
//  DPCollectionViewCell.h
//  DynamicsPlayground
//
//  Created by Renzo Pretto on 9/21/13.
//  Copyright (c) 2013 Renzo Pretto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DPCollectionCircularViewCell : UICollectionViewCell

@property (strong, nonatomic) UILabel *textLabel;

+ (NSString *)cellIdentifier;

- (void)setBackgroundColor:(UIColor *)backgroundColor;

@end
