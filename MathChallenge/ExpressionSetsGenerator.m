//
//  ExpressionSetsGenerator.m
//  MathChallenge
//
//  Created by Guilherme Andrade on 1/29/14.
//  Copyright (c) 2014 Guilherme Andrade. All rights reserved.
//

#import "ExpressionSetsGenerator.h"
#import "Polynomial.h"
#import "PolynomialNode.h"
#import "ExpressionOperator.h"
#import "MutableArrayOfTrigonometricFuntions.h"
#import "TrigonometricFunction.h"

#define NUMBER_OF_EXPRESSION_KINDS 4
#define MAX_CONSTANT 9

//typedef enum{
//    PLUS, MINUS, TIMES, DIVISION, DIFFERENTIAL, INTEGRAL, EQUAL
//} OperatorType;

@implementation ExpressionSetsGenerator

+ (void)generate:(NSInteger)numberOfExpressions WithOperandArray:(NSMutableArray*)operandArray andOperatorArray:(NSMutableArray*)operatorArray withAttributes:(ExpressionSetsGeneratorAttributes) attributes{
    
    
    for (int count = 0; count < numberOfExpressions; count++) {
        
        ExpressionSetsGeneratorAttributes expressionKind;
        do{
            expressionKind = 1 << arc4random()%NUMBER_OF_EXPRESSION_KINDS;
        }while( !(expressionKind & attributes) );



        if (expressionKind == ARITHMETIS) {
            NSInteger firstOperand = arc4random()%MAX_CONSTANT;
            NSInteger secondOperand = arc4random()%(MAX_CONSTANT-1) + 1;
            ExpressionOperator* expOp = [ExpressionOperator getOperator:arc4random()%3];
            NSInteger result = 0;
            switch (expOp.operatorType) {
                case PLUS:
                    result = firstOperand + secondOperand;
                    break;
                case MINUS:
                    result = firstOperand - secondOperand;
                    break;
                case TIMES:
                    result = firstOperand*secondOperand;
                    break;
                case DIVISION:
                    result = firstOperand/secondOperand;
                    break;
                default:
                    break;
            }
            
            [operandArray addObject:[[Polynomial alloc] initWithFloat:firstOperand]];
            [operandArray addObject:[[Polynomial alloc] initWithFloat:secondOperand]];
            [operandArray addObject:[[Polynomial alloc] initWithFloat:result]];
            
            [operatorArray addObject:expOp];
            [operatorArray addObject:[ExpressionOperator getOperator:EQUAL]];
            
        }

        else if (expressionKind == CALCULUS){
            NSInteger operandCoefficient = arc4random()%(MAX_CONSTANT-1) + 1;
            NSInteger operandExponent = arc4random()%MAX_CONSTANT;
            ExpressionOperator* expOp = [ExpressionOperator getOperator:(arc4random()%2 + 4)];
            Polynomial* leftOperand = [[Polynomial alloc] initWithPolynomialNodesArray:[NSMutableArray arrayWithObject:[[PolynomialNode alloc] initWithCoefficient:operandCoefficient andExponent:operandExponent]]];
            Polynomial* rightOperand = [[Polynomial alloc] initWithPolynomialNodesArray:[NSMutableArray arrayWithObject:[[PolynomialNode alloc] initWithCoefficient:operandCoefficient andExponent:operandExponent]]];
            
            if (expOp.operatorType == DIFFERENTIAL) {
                [rightOperand derivare];
            }
            else if(expOp.operatorType == INTEGRAL){
                [rightOperand integrate];
            }
            
            [operandArray addObject:leftOperand];
            [operandArray addObject:rightOperand];
            
            [operatorArray addObject:expOp];
            [operatorArray addObject:[ExpressionOperator getOperator:EQUAL]];

        }

        else if (expressionKind == TRIGONOMETRY){
            NSInteger argumentCoefficient = arc4random()%(MAX_CONSTANT-1) + 1;
            NSInteger argumentExponent = arc4random()%(MAX_CONSTANT-1) + 1;
            NSInteger coefficient = arc4random()%(MAX_CONSTANT-1) + 1;
            Polynomial* coefPol = [[Polynomial alloc] initWithFloat:coefficient];
            Polynomial* argPol = [Polynomial getPolynomialWithSingleNodeAndCoefficient:argumentCoefficient andExponent:argumentExponent];
//            ExpressionOperator* expOp = [ExpressionOperator getOperator:(arc4random()%2 + 4)];
            
            
            ExpressionOperator* expOp = [ExpressionOperator getOperator:4];

            
            BOOL generateSine = arc4random()%2;
            NSMutableArray* arrayOfTrignometricFunctions;
            if (generateSine) {
                arrayOfTrignometricFunctions = [NSMutableArray arrayWithObject:[[TrigonometricFunction alloc] initWithSineCoefficient:coefPol andSineArgument:argPol andCosineCoefficient:[Polynomial returnNullElement] andCosineArgument:[Polynomial returnNullElement]]];
            }
            else{
                arrayOfTrignometricFunctions = [NSMutableArray arrayWithObject:[[TrigonometricFunction alloc] initWithSineCoefficient:[Polynomial returnNullElement] andSineArgument:[Polynomial returnNullElement] andCosineCoefficient:coefPol andCosineArgument:argPol]];
            }
            MutableArrayOfTrigonometricFuntions* leftOperand = [MutableArrayOfTrigonometricFuntions getMutableArrayOfTrignometricFunctionsWithMutableArray:arrayOfTrignometricFunctions];
            MutableArrayOfTrigonometricFuntions* rightOperand = [leftOperand getCopy];
            if (expOp.operatorType == DIFFERENTIAL) {
                [rightOperand derivare];
            }
            else if (expOp.operatorType == INTEGRAL){
                //TODO
            }
            [operandArray addObject:rightOperand];
            [operandArray addObject:leftOperand];
            [operatorArray addObject:expOp];
            [operatorArray addObject:[ExpressionOperator getOperator:EQUAL]];
        }
    }
        
}


@end
