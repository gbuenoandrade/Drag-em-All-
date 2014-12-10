//
//  Expression.m
//  MathChallenge
//
//  Created by Guilherme Andrade on 1/26/14.
//  Copyright (c) 2014 Guilherme Andrade. All rights reserved.
//

#import "Expression.h"
#import "PolynomialNode.h"

@interface Expression ()

@property (strong, nonatomic) Polynomial *polynomialAmount;
@property (strong, nonatomic) MutableArrayOfTrigonometricFuntions *arrayOfTrigonometricAmounts;

//@property (strong, nonatomic) ComplexNumber *complexAmount;


@end

@implementation Expression


- (id)initWithPolynomial:(Polynomial*)pol andArrayOfTrigonometricFunction:(MutableArrayOfTrigonometricFuntions*)trig{
    self = [super init];
    if (self) {
        self.polynomialAmount = pol;
        self.arrayOfTrigonometricAmounts = trig;
    }
    return self;
}


- (NSArray*)amountsArray{
    if (!_amountsArray) {
        _amountsArray = [[NSArray alloc] initWithObjects:self.polynomialAmount, self.arrayOfTrigonometricAmounts, nil];
    }
    return _amountsArray;
}

- (void)derivare{
    [self.amountsArray makeObjectsPerformSelector:@selector(derivare)];
}

- (void)integrate{
    [self.amountsArray makeObjectsPerformSelector:@selector(integrate)];
}

- (void)add:(Expression*)exp{
    
    for (int i=0; i< [self.amountsArray count]; ++i) {
        [[self.amountsArray objectAtIndex:i] add:[exp.amountsArray objectAtIndex:i]];
    }
}

- (void)multiply:(Expression*)exp{
    if (!self.arrayOfTrigonometricAmounts.isNull && !exp.arrayOfTrigonometricAmounts.isNull ) {
        NSLog(@"nao sei multiplicar duas expressoes com partes trigonometricas nao-nulas");
    }
    else{
        if (!exp.arrayOfTrigonometricAmounts.isNull) {
            
            [exp.amountsArray makeObjectsPerformSelector:@selector(multiplyByPolynomial:) withObject:self.polynomialAmount];
            
            
            // será que vai?
            self.polynomialAmount = exp.polynomialAmount;
            self.arrayOfTrigonometricAmounts = exp.arrayOfTrigonometricAmounts;
            //unico caso problematico
            
        }
        else{
//            [self.arrayOfTrigonometricAmounts multiplyByPolynomial:exp.polynomialAmount];
//            [self.arrayOfTrigonometricAmounts multiplyByPolynomial:exp.polynomialAmount];
            [self.amountsArray makeObjectsPerformSelector:@selector(multiplyByPolynomial:) withObject:exp.polynomialAmount];
            
            
        }
    }
}



- (NSMutableString*)getStringValue{
    NSMutableString* returnString = [[NSMutableString alloc] init];
    
    if (self.arrayOfTrigonometricAmounts.isNull) {
        [returnString appendString:[self.polynomialAmount getStringValue]];
    }
    else{
        [returnString appendString:[self.arrayOfTrigonometricAmounts getStringValue]];
    }
    
    return returnString;
}

- (void)print{
    [self.amountsArray makeObjectsPerformSelector:@selector(print)];
}

- (BOOL)isEqual:(Expression*)exp{
    
    __block BOOL returnValue=YES;
    
    [self.amountsArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [[exp.amountsArray objectAtIndex:idx] print];
        if (![obj isEqual:[exp.amountsArray objectAtIndex:idx]]){
            returnValue = NO;
            *stop = YES;
        }
    }];

    return returnValue;
}

- (Expression*)getCopy{
    
    
    NSMutableArray* polArray = [[NSMutableArray alloc] init];
    for (PolynomialNode* node in self.polynomialAmount.polynomialNodesArray) {
        [polArray addObject:[[PolynomialNode alloc] initWithCoefficient:node.coefficient andExponent:node.exponent]];
    }
    
    NSMutableArray* trigArray = [[NSMutableArray alloc] init];
    for (TrigonometricFunction* trig in self.arrayOfTrigonometricAmounts.arrayOfTrigonometricFunctions) {
        [trigArray addObject:[[TrigonometricFunction alloc] initWithSineCoefficient:[trig.sineCoefficient getCopy] andSineArgument:[trig.sineArgument getCopy] andCosineCoefficient:[trig.cosineCoefficient getCopy] andCosineArgument:[trig.cosineArgument getCopy]]];
    }
    
    Polynomial* pol = [[Polynomial alloc] initWithPolynomialNodesArray:polArray];
    
    MutableArrayOfTrigonometricFuntions* mutTrig;
    if (!self.arrayOfTrigonometricAmounts.isNull){
        mutTrig = [MutableArrayOfTrigonometricFuntions getMutableArrayOfTrignometricFunctionsWithMutableArray:trigArray];
    }
    else{
        mutTrig = [MutableArrayOfTrigonometricFuntions returnNullElement];
    }
    
    Expression* copy = [[Expression alloc] initWithPolynomial:pol andArrayOfTrigonometricFunction:mutTrig];
    
    return copy;
}

@end
