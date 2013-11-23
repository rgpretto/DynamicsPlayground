//
//  DPDynamicCollectionViewFlowLayout.h
//  DynamicsPlayground
//
//  Created by Renzo Pretto on 9/21/13.
//  Copyright (c) 2013 Renzo Pretto. All rights reserved.
//

@import UIKit;

/*
 This layout makes same spring stretch for every layout element
 */
@interface DPFixedSpringFlowLayout : UICollectionViewFlowLayout

@property (strong, readonly, nonatomic) UIDynamicAnimator *dynamicAnimator;

@end
