//
//  ExpressionOperator.m
//  MathChallenge
//
//  Created by Guilherme Andrade on 1/29/14.
//  Copyright (c) 2014 Guilherme Andrade. All rights reserved.
//

#import "ExpressionOperator.h"


//typedef enum{
//    PLUS, MINUS, TIMES, DIVISION, DIFFERENTIAL, INTEGRAL, EQUAL
//} OperatorType;

@implementation ExpressionOperator

- (NSString*)getStringValue{
    switch (self.operatorType) {
        case PLUS:
            return @"+";
            break;
        case MINUS:
            return @"−";
            break;
        case TIMES:
            return @"⊗";
            break;
        case DIVISION:
            return @"÷";
            break;
        case DIFFERENTIAL:
            return @"∇";    //TEMPORARY
            break;
        case INTEGRAL:
            return @"∫";
            break;
        case EQUAL:
            return @"=";
            break;
        default:
            return @"";
            break;
    }
}

+ (ExpressionOperator*)getOperator:(OperatorType)operatorType{
    ExpressionOperator* expOp = [[ExpressionOperator alloc] init];
    expOp.operatorType = operatorType;
    return expOp;
}


@end
