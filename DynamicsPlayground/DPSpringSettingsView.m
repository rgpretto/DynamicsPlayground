//
//  DPSpringSettingsView.m
//  DynamicsPlayground
//
//  Created by Renzo Pretto on 10/19/13.
//  Copyright (c) 2013 Renzo Pretto. All rights reserved.
//

#import "DPSpringSettingsView.h"

@implementation DPSpringSettingsView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}


- (void)awakeFromNib {
    [super awakeFromNib];

    [self commonInit];

}

- (void)updateWithSpringAttachment:(UIAttachmentBehavior *)inBehavior {
    self.dampingLabel.text = [NSString stringWithFormat:@"d: %.1f", [inBehavior damping]];
    self.frequencyLabel.text = [NSString stringWithFormat:@"f: %.1f", [inBehavior frequency]];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat height = CGRectGetHeight([self frame]) / 2.0;
    self.frequencyLabel.frame = CGRectMake(0.0, 0.0, CGRectGetWidth([self frame]), height);
    self.dampingLabel.frame =  CGRectMake(0.0, CGRectGetMaxY([self.frequencyLabel frame]), CGRectGetWidth([self.frequencyLabel frame]), height);
}

- (void)commonInit {
    
    UIFont *font = [UIFont systemFontOfSize:20.0f];
    
    _dampingLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _frequencyLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    
    self.dampingLabel.font = font;
    self.frequencyLabel.font = font;
    
    self.dampingLabel.textAlignment = NSTextAlignmentCenter;
    self.frequencyLabel.textAlignment = NSTextAlignmentCenter;
    
    [self addSubview:self.dampingLabel];
    [self addSubview:self.frequencyLabel];
}

@end
