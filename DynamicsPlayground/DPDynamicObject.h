//
//  DPDynamicObject.h
//  DynamicsPlayground
//
//  Created by Renzo Pretto on 9/23/13.
//  Copyright (c) 2013 Renzo Pretto. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 *
 * This object conforom to UIDynamicItem protocol and log
 * property changes when UIDynamicAnimator acnt on it.
 *
 */
@interface DPDynamicObject : NSObject <UIDynamicItem>

@property (nonatomic, readwrite) CGPoint center;
@property (nonatomic, readonly) CGRect bounds;
@property (nonatomic, readwrite) CGAffineTransform transform;

@end
