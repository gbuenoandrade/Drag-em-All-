//
//  Polynomial.h
//  MathChallenge
//
//  Created by Guilherme Andrade on 1/26/14.
//  Copyright (c) 2014 Guilherme Andrade. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ArgumentProtocol.h"

@interface Polynomial : NSObject <ArgumentProtocol>

@property (nonatomic) CGFloat degree;
@property (strong, nonatomic) NSMutableArray *polynomialNodesArray;

+ (instancetype)getPolynomialWithSingleNodeAndCoefficient:(CGFloat)coefficient andExponent:(CGFloat)exponent;

- (id)initWithPolynomialNodesArray:(NSMutableArray*)array;
- (id)initWithFloat:(CGFloat)number;

- (void)derivare;
- (void)integrate;
- (void)add:(id)object;
- (BOOL)isZero;

- (id<ArgumentProtocol>)getCopy;

//- (BOOL)isEqual:(id)object;
- (void)multiplyByPolynomial:(Polynomial*)pol;



- (void)print;
- (void)generateRandomPolynomialWithDegree:(NSInteger)degree;
+ (id<ArgumentProtocol>)returnNullElement;

@end
