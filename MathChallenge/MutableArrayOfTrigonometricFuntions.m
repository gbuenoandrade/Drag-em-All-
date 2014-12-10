//
//  MutableArrayOfTrigonometricFuntions.m
//  MathChallenge
//
//  Created by Guilherme Andrade on 1/31/14.
//  Copyright (c) 2014 Guilherme Andrade. All rights reserved.
//

#import "MutableArrayOfTrigonometricFuntions.h"
#import "TrigonometricFunction.h"
#import "PolynomialNode.h"
#import "Polynomial.h"

@implementation MutableArrayOfTrigonometricFuntions

+ (instancetype)getMutableArrayOfTrignometricFunctionsWithMutableArray:(NSMutableArray*)array{
    MutableArrayOfTrigonometricFuntions* mutAr = [[MutableArrayOfTrigonometricFuntions alloc] init];
    mutAr.arrayOfTrigonometricFunctions = array;
    mutAr.isNull = NO;
    return mutAr;
}

- (void)add:(MutableArrayOfTrigonometricFuntions*)trigToAdd{
    
   // NSLog(@"entrei nesse add doido");
    
    
    if (!trigToAdd.isNull){
        self.isNull = NO;
        for (TrigonometricFunction* trigNodeToAdd in trigToAdd.arrayOfTrigonometricFunctions) {
            __block NSUInteger idxToAdd = -1;
            [self.arrayOfTrigonometricFunctions enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                TrigonometricFunction* selfTrigNode = (TrigonometricFunction*)obj;
                if ( [selfTrigNode.cosineArgument isEqual:trigNodeToAdd.cosineArgument] && [selfTrigNode.sineArgument isEqual:trigNodeToAdd.sineArgument]) {
                    idxToAdd = idx;
                    *stop = YES;
                }
            }];
            
            if (idxToAdd != -1) {  // FOUND
                id<ArgumentProtocol> sinCoef = [self.arrayOfTrigonometricFunctions[idxToAdd] sineCoefficient];
                id<ArgumentProtocol> cosCoef = [self.arrayOfTrigonometricFunctions[idxToAdd] cosineCoefficient];
                [sinCoef add:trigNodeToAdd.sineCoefficient];
                [cosCoef add:trigNodeToAdd.cosineCoefficient];
            }
            else{   // NOT FOUND
                [self.arrayOfTrigonometricFunctions addObject:[[TrigonometricFunction alloc] initWithSineCoefficient:trigNodeToAdd.sineCoefficient andSineArgument:trigNodeToAdd.sineArgument andCosineCoefficient:trigNodeToAdd.cosineCoefficient andCosineArgument:trigNodeToAdd.cosineArgument]];
            }

        }
    
    }
}




//- (void)setIsNull:(BOOL)isNull{
//    if (!isNull) {
//        NSLog(@"estou setando isNUll pra NotNUlll, why?");
//    }
//    
//    _isNull = isNull;
//}


- (BOOL)isEqual:(MutableArrayOfTrigonometricFuntions*)trigToCompare{
    if ([trigToCompare.arrayOfTrigonometricFunctions count] != [self.arrayOfTrigonometricFunctions count]) {
        
        NSLog(@"sai no count");
        
        return NO;
    }
    else if (self.isNull != trigToCompare.isNull){
        
        
        NSLog(@"isNUll sao diferentes");

        if(self.isNull)
            NSLog(@"self.isNUll");
        if (trigToCompare.isNull)
            NSLog(@"triToCompare.isNull");
        
        
        return NO;
    }
    else if (self.isNull && trigToCompare.isNull){
        
        NSLog(@"isNUll sao nulos, entao ja retornei sim");

        
        return YES;
    }
    else{
        
        
        NSLog(@"!isNull vamo pra comp");

        
        
        for (TrigonometricFunction* comparativeTrigNode in trigToCompare.arrayOfTrigonometricFunctions) {
            BOOL found = NO;
            for (TrigonometricFunction* baseTrigNode in self.arrayOfTrigonometricFunctions) {
                
                NSLog(@"node1: %@ x node2: %@",[comparativeTrigNode getStringValue],[baseTrigNode getStringValue]);
                
                if ([baseTrigNode isEqual:comparativeTrigNode]) {
                    found = YES;
                    break;
                }
            }
                if (found == NO) {
                    
                    NSLog(@"nao estou achanado um irmao");

                    
                    return NO;
                }
        }
    }
    
    return YES;
}

- (NSMutableString*)getStringValue{
    NSMutableString* returnString = [[NSMutableString alloc] init];

    
    if (!self.isNull){
    
        if ([self.arrayOfTrigonometricFunctions count] > 0){
            
            
            for (NSInteger idx = 0; idx<([self.arrayOfTrigonometricFunctions count] - 1); idx++) {
                TrigonometricFunction* trigNode = [self.arrayOfTrigonometricFunctions objectAtIndex:idx];
                [returnString appendString:[NSString stringWithFormat:@" %@ +",[trigNode getStringValue]]];
            }
            TrigonometricFunction* lastTrigNode = [self.arrayOfTrigonometricFunctions objectAtIndex:[self.arrayOfTrigonometricFunctions count] - 1];
            [returnString appendString:[NSString stringWithFormat:@" %@",[lastTrigNode getStringValue]]];
        }
    
    }
    
    return returnString;
}

- (void)print{
    NSLog(@"%@",[self getStringValue]);
}



- (void)multiplyByPolynomial:(Polynomial*)pol{
    if (!self.isNull) {
            for (TrigonometricFunction* trigNode in self.arrayOfTrigonometricFunctions) {
                [trigNode.cosineCoefficient multiplyByPolynomial:pol];
                [trigNode.sineCoefficient multiplyByPolynomial:pol];
            }
    }
}





- (void)derivare{
    
    if (!self.isNull){
    
        for (TrigonometricFunction* trigNode in self.arrayOfTrigonometricFunctions) {
            [trigNode derivare];
        }
        
    }
}

- (void)integrate{
    for (TrigonometricFunction* trigNode in self.arrayOfTrigonometricFunctions) {
        [trigNode integrate];
    }
}

+ (instancetype)returnNullElement{
    NSMutableArray* array = [NSMutableArray arrayWithObject:[TrigonometricFunction returnNullElement]];
    MutableArrayOfTrigonometricFuntions* mut = [MutableArrayOfTrigonometricFuntions getMutableArrayOfTrignometricFunctionsWithMutableArray:array];
    mut.isNull = YES;
    return mut;
}

- (MutableArrayOfTrigonometricFuntions*)getCopy{
    NSMutableArray* array = [NSMutableArray array];
    for (TrigonometricFunction* trigNode in self.arrayOfTrigonometricFunctions) {
        [array addObject:[[TrigonometricFunction alloc] initWithSineCoefficient:[trigNode.sineCoefficient getCopy] andSineArgument:[trigNode.sineArgument getCopy] andCosineCoefficient:[trigNode.cosineCoefficient getCopy] andCosineArgument:[trigNode.cosineArgument getCopy]]];
    }
    
    return [MutableArrayOfTrigonometricFuntions getMutableArrayOfTrignometricFunctionsWithMutableArray:array];
}
@end
