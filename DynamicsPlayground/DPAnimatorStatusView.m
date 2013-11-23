//
//  DPAnimatorStatusView.m
//  DynamicsPlayground
//
//  Created by Renzo Pretto on 9/10/13.
//  Copyright (c) 2013 Renzo Pretto. All rights reserved.
//

#import "DPAnimatorStatusView.h"

#import "UIColor+iOS7Colors.h"


@interface DPAnimatorStatusView ()

@property (strong, nonatomic) UILabel *animatorLabel;

@end

@implementation DPAnimatorStatusView


+ (instancetype)animatorStatusViewinContainerFrame:(CGRect)containerFrame {
    id newInstance = nil;
    
    const CGFloat yOffset = 40.0f;
    
    CGRect defaultFrame = CGRectMake(0.0, 0.0, 100.0, 30.0f);
    CGRect finalFrame = CGRectOffset(defaultFrame , CGRectGetMaxX(containerFrame) - CGRectGetWidth(defaultFrame), CGRectGetMinY(containerFrame) + yOffset);
    
    newInstance = [[self alloc] initWithFrame:finalFrame];
    [newInstance setAnimatorStatus:NO];
    
    return newInstance;
}


- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        _animatorLabel = [[UILabel alloc] initWithFrame:frame];
        _animatorLabel.text = @"Animator";
        _animatorLabel.font = [UIFont systemFontOfSize:22.0f];
//        [_animatorLabel sizeToFit];
        [self addSubview:_animatorLabel];
    }
    
    return self;
}


- (void)awakeFromNib {
	[super awakeFromNib];
    
}

- (void)setAnimatorStatus:(BOOL)isActive {
    if (isActive) {
        self.animatorLabel.textColor = [UIColor iOS7greenColor];
    } else {
        self.animatorLabel.textColor = [UIColor iOS7redColor];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.animatorLabel.frame = [self bounds];
}


@end
