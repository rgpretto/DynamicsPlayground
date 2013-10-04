//
//  DPCollectionViewCell.m
//  DynamicsPlayground
//
//  Created by Renzo Pretto on 9/21/13.
//  Copyright (c) 2013 Renzo Pretto. All rights reserved.
//

#import "DPCollectionCircularViewCell.h"

#import "UIColor+iOS7Colors.h"
#import <QuartzCore/QuartzCore.h>

@implementation DPCollectionCircularViewCell

+ (NSString *)cellIdentifier {
	static NSString *cellIdentifier = @"DPCollectionCircularViewCellIdentifier";
	return cellIdentifier;
}

- (id)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		// Initialization code
        
        self.textLabel = [[UILabel alloc] initWithFrame:self.bounds];
        self.textLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.textLabel];

        self.backgroundColor = [UIColor iOS7darkBlueColor];

        self.layer.borderColor = [UIColor iOS7lightBlueColor].CGColor;
        self.layer.borderWidth = 2.0f;
        self.layer.masksToBounds = YES;
    }
	return self;
}

- (void)setBackgroundColor:(UIColor *)inBackgroundColor {
    self.contentView.backgroundColor = inBackgroundColor;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.layer.cornerRadius = CGRectGetWidth([self bounds]) / 2.0f;
}

@end
