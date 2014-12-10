//
//  MainGameScreenVC.h
//  MathChallenge
//
//  Created by Guilherme Andrade on 1/29/14.
//  Copyright (c) 2014 Guilherme Andrade. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Phase.h"

@interface MainGameScreenVC : UIViewController

@property (nonatomic) Difficult currentDifficult;
@property (nonatomic) ExpressionSetsGeneratorAttributes currentAttributes;

@property (strong, nonatomic) NSMutableArray* careerArray;
@property (nonatomic) BOOL careerMode;

@end
