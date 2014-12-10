//
//  MutableArrayOfTrigonometricFuntions.h
//  MathChallenge
//
//  Created by Guilherme Andrade on 1/31/14.
//  Copyright (c) 2014 Guilherme Andrade. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Polynomial;

@interface MutableArrayOfTrigonometricFuntions : NSObject

@property (strong, nonatomic) NSMutableArray* arrayOfTrigonometricFunctions;

+ (instancetype)getMutableArrayOfTrignometricFunctionsWithMutableArray:(NSMutableArray*)array;
+ (instancetype)returnNullElement;

- (void)add:(MutableArrayOfTrigonometricFuntions*)trigToAdd;
- (BOOL)isEqual:(MutableArrayOfTrigonometricFuntions*)trigToCompare;
- (void)multiplyByPolynomial:(Polynomial*)pol;

@property (nonatomic) BOOL isNull;  // temporary solution with flags


- (NSMutableString*)getStringValue;
- (void)print;

- (void)derivare;
- (void)integrate;

- (MutableArrayOfTrigonometricFuntions*)getCopy;

@end
