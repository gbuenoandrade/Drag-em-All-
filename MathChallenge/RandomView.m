//
//  RandomView.m
//  MathChallenge
//
//  Created by Guilherme Andrade on 2/6/14.
//  Copyright (c) 2014 Guilherme Andrade. All rights reserved.
//

#import "RandomView.h"

@implementation RandomView

+ (CGPoint)returnRandomPointInView:(UIView*)view withGrid:(CGSize)size{
    
    CGPoint point;
    
    int x, y;
    x= (arc4random()%((int)view.frame.size.width)- 2*size.width) / size.width;
    point.x = x * size.width + size.width;
    y= (arc4random()%((int)view.frame.size.height) - 2*size.height) / size.height;
    point.y = y * size.height + size.height;

    point.x += view.frame.origin.x;
    point.y += view.frame.origin.y;

    return point;
}

@end
