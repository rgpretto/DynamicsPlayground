//
//  DPAnimatorStatusView.h
//  DynamicsPlayground
//
//  Created by Renzo Pretto on 9/10/13.
//  Copyright (c) 2013 Renzo Pretto. All rights reserved.
//

@import UIKit;

@interface DPAnimatorStatusView : UIView

@property (nonatomic, strong) UIDynamicAnimator *dynamicAnimator;

+ (instancetype)animatorStatusViewinContainerFrame:(CGRect)containerFrame;

- (void)setAnimatorStatus:(BOOL)isActive;


@end
