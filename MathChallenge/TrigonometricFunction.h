//
//  TrigonometricFunction.h
//  MathChallenge
//
//  Created by Guilherme Andrade on 1/26/14.
//  Copyright (c) 2014 Guilherme Andrade. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ArgumentProtocol.h"

@interface TrigonometricFunction : NSObject

@property (nonatomic) id<ArgumentProtocol> sineCoefficient;
@property (strong, nonatomic) id<ArgumentProtocol> sineArgument;
@property (nonatomic) id<ArgumentProtocol> cosineCoefficient;
@property (strong, nonatomic) id<ArgumentProtocol> cosineArgument;



- (id)initWithSineCoefficient:(id<ArgumentProtocol>)sinCoef andSineArgument:(id<ArgumentProtocol>)sineArgum andCosineCoefficient:(id<ArgumentProtocol>)cosCoef andCosineArgument:(id<ArgumentProtocol>)cosArgum;
- (void)print;

+ (instancetype)returnNullElement;


- (NSString*)getStringValue;

- (void) derivare;
- (void) integrate;

//- (BOOL)isEqual:(id)object;

@end
