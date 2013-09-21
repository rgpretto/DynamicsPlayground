//
//  DPCollectionViewCell.m
//  DynamicsPlayground
//
//  Created by Renzo Pretto on 9/21/13.
//  Copyright (c) 2013 Renzo Pretto. All rights reserved.
//

#import "DPCollectionViewCell.h"

@implementation DPCollectionViewCell

+ (NSString *)cellIdentifier {
    static NSString *cellIdentifier = @"kCellIdentifier";
    return cellIdentifier;
}
    

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor redColor];
    }
    return self;
}

@end
