//
//  DPDynamicCollectionViewFlowLayout.m
//  DynamicsPlayground
//
//  Created by Renzo Pretto on 9/21/13.
//  Copyright (c) 2013 Renzo Pretto. All rights reserved.
//

#import "DPFixedSpringFlowLayout.h"

@interface DPFixedSpringFlowLayout ()
@property (strong, readwrite, nonatomic) UIDynamicAnimator *dynamicAnimator;
@end


@implementation DPFixedSpringFlowLayout

- (id)init {
	self = [super init];
	if (self) {
	}
	return self;
}

- (CGSize)itemSize {
	CGSize result = CGSizeZero;
	result = CGSizeMake(CGRectGetWidth(self.collectionView.frame), 50.0f);
	return result;
}

- (void)prepareLayout {
	// create UICollectionViewLayoutAttribute
    
	[super prepareLayout];
    
	if (nil == [self dynamicAnimator]) {
		// create UIDynamicAnimator and UIAttachmentBahavior
		self.dynamicAnimator = [[UIDynamicAnimator alloc] initWithCollectionViewLayout:self];
		CGSize contentSize = [self collectionViewContentSize];
		CGRect contentRect = { CGPointZero, contentSize };
		NSArray *layoutAttributes = [super layoutAttributesForElementsInRect:contentRect];
        
		// create spring behavior foe each item
        
		for (UICollectionViewLayoutAttributes *attribute in layoutAttributes) {
			UIAttachmentBehavior *springBehavior = nil;
			springBehavior = [[UIAttachmentBehavior alloc] initWithItem:attribute
			                                           attachedToAnchor:[attribute center]];
			// spring length has to be zero, so the sprint come to rest in the anchor point
			springBehavior.length = 0.0f;
			springBehavior.damping = 0.5;
			springBehavior.frequency = 0.8;
            
			//FIXME: add the spring only to item visible on the screens using "addBehavior" and "removebehavior" methods of dynamic animator
			[self.dynamicAnimator addBehavior:springBehavior];
		}
	}
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
	NSArray *result = nil;
	result = [self.dynamicAnimator itemsInRect:rect];
	return result;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
	UICollectionViewLayoutAttributes *result = nil;
	result = [self.dynamicAnimator layoutAttributesForCellAtIndexPath:indexPath];
	return result;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
	BOOL result = NO;
    
	// UIScrollView contentsOffset == bounds.origin
	UIScrollView *scrollView = [self collectionView];
    
	// shit layout attribute position by delta
	CGFloat scrollDelta = newBounds.origin.y - scrollView.bounds.origin.y;
    
	for (UIAttachmentBehavior *springBehavior in [self.dynamicAnimator behaviors]) {
		UICollectionViewLayoutAttributes *attribute = nil;
        
		attribute = [springBehavior.items firstObject];
		CGPoint center = [attribute center];
        
		center.y += scrollDelta;
        
		attribute.center = center;
        
		// notify UIDynamicAnimator
		[self.dynamicAnimator updateItemUsingCurrentState:attribute];
	}
    
    
	// we return NO because Dynamic animator will move items around,
	// and this already cause the layout invalidation
	return result;
}

@end
