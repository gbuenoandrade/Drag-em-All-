//
//  TrigonometricFunction.m
//  MathChallenge
//
//  Created by Guilherme Andrade on 1/26/14.
//  Copyright (c) 2014 Guilherme Andrade. All rights reserved.
//

#import "TrigonometricFunction.h"
#import "Polynomial.h"
#define ARGUMENT_FLAG_OF_NULL_COEFFICIENT 9999999;

@implementation TrigonometricFunction

- (id)initWithSineCoefficient:(id<ArgumentProtocol>)sinCoef andSineArgument:(id<ArgumentProtocol>)sineArgum andCosineCoefficient:(id<ArgumentProtocol>)cosCoef andCosineArgument:(id<ArgumentProtocol>)cosArgum {
    self = [super init];
    if (self) {
        self.sineArgument = sineArgum;
        self.sineCoefficient = sinCoef;
        self.cosineArgument = cosArgum;
        self.cosineCoefficient = cosCoef;
    }
    return self;
}


- (void)setSineCoefficient:(id<ArgumentProtocol>)sineCoefficient{
    _sineCoefficient = sineCoefficient;
    if ([_sineCoefficient isZero]) {
        CGFloat flag = ARGUMENT_FLAG_OF_NULL_COEFFICIENT;
        self.sineArgument = [[Polynomial alloc] initWithFloat:flag];
    }
}

- (void)setCosineCoefficient:(id<ArgumentProtocol>)cosineCoefficient{
    _cosineCoefficient = cosineCoefficient;
    if ([_cosineCoefficient isZero]) {
        CGFloat flag = ARGUMENT_FLAG_OF_NULL_COEFFICIENT;
        self.cosineArgument = [[Polynomial alloc] initWithFloat:flag];
    }
}


- (BOOL)isEqual:(id)object{
    TrigonometricFunction* trig = (TrigonometricFunction*)object;
    

    return ([self.cosineArgument isEqual:trig.cosineArgument] && [self.sineArgument isEqual:trig.sineArgument] && [self.cosineCoefficient isEqual:trig.cosineCoefficient] && [self.sineCoefficient isEqual:trig.sineCoefficient]);

}


- (void)swapArguments{
    id<ArgumentProtocol> temporaryVar = self.cosineArgument;
    self.cosineArgument = self.sineArgument;
    self.sineArgument = temporaryVar;
}


- (void)derivare{
    

    
    id<ArgumentProtocol> cosineArgumentDerivative = [self.cosineArgument isZero] ? [self.cosineArgument returnNullElement]:[self.cosineArgument getDerivative], sineArgumentDerivative =  [self.sineArgument isZero] ? [self.sineArgument returnNullElement]:[self.sineArgument getDerivative];
    
    
    
    [cosineArgumentDerivative multiplyByConstant:-1*[[self.cosineCoefficient getStringValue] floatValue]];
    [sineArgumentDerivative multiplyByConstant:[[self.sineCoefficient getStringValue] floatValue]];
    

    [self swapArguments];
    self.sineCoefficient = cosineArgumentDerivative;
    self.cosineCoefficient = sineArgumentDerivative;
    
    
    


}

- (void)integrate{
    NSLog(@"oh, man! i dont know how to integrate trigometric functions :/");
}

- (void)multiplyByConstant:(CGFloat)constant{
    [self.cosineCoefficient multiplyByConstant:constant];
    [self.sineCoefficient multiplyByConstant:constant];
}

- (void)print{
    NSLog(@"%@",[self getStringValue]);
}

- (NSString*)getStringValue{
    if([[self.sineCoefficient getStringValue]integerValue]!= 0 && [[self.cosineCoefficient getStringValue]integerValue]!= 0)
        return [NSString stringWithFormat:@"%@sin(%@) + %@cos(%@)",[self coefficientOmittingOne:self.sineCoefficient],[self.sineArgument getStringValue],[self coefficientOmittingOne:self.cosineCoefficient],[self.cosineArgument getStringValue]];
    else if([[self.sineCoefficient getStringValue]integerValue]== 0 && [[self.cosineCoefficient getStringValue]integerValue]!= 0)
       return [NSString stringWithFormat:@"%@cos(%@)",[self coefficientOmittingOne:self.cosineCoefficient],[self.cosineArgument getStringValue]];
    else if([[self.sineCoefficient getStringValue]integerValue]!= 0 && [[self.cosineCoefficient getStringValue]integerValue]== 0)
        return [NSString stringWithFormat:@"%@sin(%@)",[self coefficientOmittingOne:self.sineCoefficient],[self.sineArgument getStringValue]];
    else
        return nil;
}

- (NSString*)coefficientOmittingOne:(Polynomial*)pol{
    if ([[pol getStringValue] isEqualToString:@"1"]) {
        return @"";
    }
    return [pol getStringValue];
}

+ (instancetype)returnNullElement{
    TrigonometricFunction* trig = [[TrigonometricFunction alloc] initWithSineCoefficient:[Polynomial returnNullElement] andSineArgument:[Polynomial getPolynomialWithSingleNodeAndCoefficient:1 andExponent:1] andCosineCoefficient:[Polynomial returnNullElement] andCosineArgument:[Polynomial getPolynomialWithSingleNodeAndCoefficient:1 andExponent:1]];
    return trig;
}

@end

