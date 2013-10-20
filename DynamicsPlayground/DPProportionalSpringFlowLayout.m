//
//  DPDynamicCollectionViewFlowLayout.m
//  DynamicsPlayground
//
//  Created by Renzo Pretto on 9/21/13.
//  Copyright (c) 2013 Renzo Pretto. All rights reserved.
//

#import "DPProportionalSpringFlowLayout.h"



@implementation DPProportionalSpringFlowLayout

- (id)init {
	self = [super init];
	if (self) {
	}
	return self;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
	BOOL result = NO;
    
	// UIScrollView contentsOffset == bounds.origin
	UIScrollView *scrollView = [self collectionView];
    
	CGFloat scrollDelta = newBounds.origin.y - scrollView.bounds.origin.y;
    
	//  -1- get current touch location
	CGPoint touchLocation = [scrollView.panGestureRecognizer locationInView:scrollView];
    
	for (UIAttachmentBehavior *springBehavior in[self.dynamicAnimator behaviors]) {
		UICollectionViewLayoutAttributes *attribute = nil;
        
		// -2- scale the amount we restist the scroll
		CGPoint anchorPoint = [springBehavior anchorPoint];
		CGFloat distanceFromheTouch = fabsf(touchLocation.y - anchorPoint.y);
		CGFloat scrollResistance = distanceFromheTouch / 500.0f;
        
		attribute = [springBehavior.items firstObject];
		CGPoint center = [attribute center];
        
		// -3- set the spring stretch
		CGFloat springStretch = scrollDelta * scrollResistance;
		if (springStretch > 0) {
			center.y += MIN(scrollDelta, springStretch);
		}
		else {
			center.y += MAX(scrollDelta, springStretch);
		}
		attribute.center = center;
        
		// notify UIDynamicAnimator
		[self.dynamicAnimator updateItemUsingCurrentState:attribute];
	}
    
	// we return NO because Dynamic animator will move items around,
	// and this already cause the layout invalidation
	return result;
}

@end
