//
//  Phase.m
//  MathChallenge
//
//  Created by Guilherme Andrade on 2/6/14.
//  Copyright (c) 2014 Guilherme Andrade. All rights reserved.
//

#import "Phase.h"

@implementation Phase

+ (instancetype)getPhaseWithDifficult:(Difficult)difficult andAttriutes:(ExpressionSetsGeneratorAttributes)attributes{
    Phase* instance = [[Phase alloc] init];
    instance.difficult = difficult;
    instance.attributes = attributes;
    return instance;
}

@end
