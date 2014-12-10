//
//  PolynomialNode.h
//  MathChallenge
//
//  Created by Guilherme Andrade on 1/26/14.
//  Copyright (c) 2014 Guilherme Andrade. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PolynomialNode : NSObject

@property (nonatomic) CGFloat coefficient;
@property (nonatomic) CGFloat exponent;    //licença matematica

- (id)initWithCoefficient:(CGFloat)coeffiecient andExponent:(CGFloat)exponent;

@end
