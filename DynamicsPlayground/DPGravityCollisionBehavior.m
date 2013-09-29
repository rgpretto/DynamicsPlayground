//
//  DPGravityCollisionBehavior.m
//  DynamicsPlayground
//
//  Created by Renzo Pretto on 9/12/13.
//  Copyright (c) 2013 Renzo Pretto. All rights reserved.
//

#import "DPGravityCollisionBehavior.h"


@implementation DPGravityCollisionBehavior

- (instancetype)initWithItems:(NSArray *)items {
	self = [super init];
    
	if (self) {
		UIGravityBehavior *gravity = [[UIGravityBehavior alloc] initWithItems:items];
		UICollisionBehavior *collision = [[UICollisionBehavior alloc] initWithItems:items];
		collision.translatesReferenceBoundsIntoBoundary = YES;
        
        
		[self addChildBehavior:gravity];
		[self addChildBehavior:collision];
	}
	return self;
}

@end
