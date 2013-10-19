//
//  DPSpringSettingsView.h
//  DynamicsPlayground
//
//  Created by Renzo Pretto on 10/19/13.
//  Copyright (c) 2013 Renzo Pretto. All rights reserved.
//

@import  UIKit;

@interface DPSpringSettingsView : UIView

@property (strong, nonatomic) UILabel *dampingLabel;
@property (strong, nonatomic) UILabel *frequencyLabel;

- (void)updateWithSpringAttachment:(UIAttachmentBehavior *)inBehavior;

@end
