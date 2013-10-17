//
//  DPDynamicObject.m
//  DynamicsPlayground
//
//  Created by Renzo Pretto on 9/23/13.
//  Copyright (c) 2013 Renzo Pretto. All rights reserved.
//

#import "DPDynamicObject.h"

@implementation DPDynamicObject

- (CGRect)bounds {
	return CGRectMake(0.0, 0.0, 100.0, 100.0);
}

- (CGPoint)center {
	return CGPointMake(50.0, 50.0);
}

- (void)setCenter:(CGPoint)center {
	NSLog(@"Center = %@", NSStringFromCGPoint(center));
}

- (CGAffineTransform)transform {
	return CGAffineTransformIdentity;
}

- (void)setTransform:(CGAffineTransform)transform {
	NSLog(@"Transform = %@", NSStringFromCGAffineTransform(transform));
}

@end
