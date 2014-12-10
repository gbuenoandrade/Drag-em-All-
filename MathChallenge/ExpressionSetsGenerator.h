//
//  ExpressionSetsGenerator.h
//  MathChallenge
//
//  Created by Guilherme Andrade on 1/29/14.
//  Copyright (c) 2014 Guilherme Andrade. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum{
    ARITHMETIS = 1,
    TRIGONOMETRY = 2,
    COMPLEX_NUMBERS= 4,
    CALCULUS = 8
} ExpressionSetsGeneratorAttributes;


@interface ExpressionSetsGenerator : NSObject

+ (void)generate:(NSInteger)numberOfExpressions WithOperandArray:(NSMutableArray*)operandArray andOperatorArray:(NSMutableArray*)operatorArray withAttributes:(ExpressionSetsGeneratorAttributes) attributes;

@end
