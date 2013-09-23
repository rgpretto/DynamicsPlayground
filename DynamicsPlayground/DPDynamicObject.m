//
//  DPDynamicObject.m
//  DynamicsPlayground
//
//  Created by Renzo Pretto on 9/23/13.
//  Copyright (c) 2013 Renzo Pretto. All rights reserved.
//

#import "DPDynamicObject.h"

@implementation DPDynamicObject


-(CGRect)bounds {
    
    return CGRectMake(0.0, 0.0, 100.0, 100.0);
}

-(CGPoint)center {
    
    return CGPointMake(50.0, 50.0);
}

-(CGAffineTransform)transform {
    
    return CGAffineTransformIdentity;
}

- (void)setCenter:(CGPoint)inCenter {
    
    NSLog(@"Center = %@", NSStringFromCGPoint(inCenter));

}

-(void)transform:(CGAffineTransform)inAffineTranform {
    
    NSLog(@"Transform = %@", NSStringFromCGAffineTransform(inAffineTranform));

}

@end
