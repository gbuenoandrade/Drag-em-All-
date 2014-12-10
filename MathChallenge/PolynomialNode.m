//
//  PolynomialNode.m
//  MathChallenge
//
//  Created by Guilherme Andrade on 1/26/14.
//  Copyright (c) 2014 Guilherme Andrade. All rights reserved.
//

#import "PolynomialNode.h"

@implementation PolynomialNode

- (id)initWithCoefficient:(CGFloat)coeffiecient andExponent:(CGFloat)exponent{
    self = [super init];
    if (self) {
        self.coefficient = coeffiecient;
        self.exponent = exponent;
    }
    return self;
}



@end
