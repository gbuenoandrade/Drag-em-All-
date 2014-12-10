//
//  Phase.h
//  MathChallenge
//
//  Created by Guilherme Andrade on 2/6/14.
//  Copyright (c) 2014 Guilherme Andrade. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ExpressionSetsGenerator.h"

typedef enum{
    EASY = 3,
    MEDIUM = 5,
    HARD = 8
} Difficult;


@interface Phase : NSObject

@property (nonatomic) Difficult difficult;
@property (nonatomic) ExpressionSetsGeneratorAttributes attributes;

+ (instancetype)getPhaseWithDifficult:(Difficult)difficult andAttriutes:(ExpressionSetsGeneratorAttributes)attributes;

@end
