//
//  Expression.h
//  MathChallenge
//
//  Created by Guilherme Andrade on 1/26/14.
//  Copyright (c) 2014 Guilherme Andrade. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Polynomial.h"
#import "TrigonometricFunction.h"
#import "MutableArrayOfTrigonometricFuntions.h"

@interface Expression : NSObject

@property (strong, nonatomic) NSArray *amountsArray;


- (void)derivare;
- (void)integrate;
- (void)add:(id)object;
- (BOOL)isEqual:(Expression*)exp;


- (NSMutableString*)getStringValue;

- (id)initWithPolynomial:(Polynomial*)pol andArrayOfTrigonometricFunction:(MutableArrayOfTrigonometricFuntions*)trig;

- (void)print;

- (Expression*)getCopy;

- (void)multiply:(Expression*)exp;


@end
