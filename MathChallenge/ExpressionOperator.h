//
//  ExpressionOperator.h
//  MathChallenge
//
//  Created by Guilherme Andrade on 1/29/14.
//  Copyright (c) 2014 Guilherme Andrade. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum{
    PLUS, MINUS, TIMES, DIVISION, DIFFERENTIAL, INTEGRAL, EQUAL
} OperatorType;

@interface ExpressionOperator : NSObject

@property (nonatomic) OperatorType operatorType;

- (NSString*)getStringValue;

+ (ExpressionOperator*)getOperator:(OperatorType)operatorType;


@end
