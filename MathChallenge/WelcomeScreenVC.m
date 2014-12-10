//
//  WelcomeScreenVC.m
//  MathChallenge
//
//  Created by Guilherme Andrade on 2/6/14.
//  Copyright (c) 2014 Guilherme Andrade. All rights reserved.
//

#import "WelcomeScreenVC.h"
#import "Phase.h"
#import "MainGameScreenVC.h"

@interface WelcomeScreenVC ()

@property (strong, nonatomic) NSMutableArray* phaseArray;

@end

@implementation WelcomeScreenVC

- (NSMutableArray*)phaseArray{
    if (!_phaseArray) {
        _phaseArray = [NSMutableArray arrayWithObjects:[Phase getPhaseWithDifficult:EASY andAttriutes:ARITHMETIS],[Phase getPhaseWithDifficult:EASY andAttriutes:ARITHMETIS | CALCULUS],[Phase getPhaseWithDifficult:EASY andAttriutes:ARITHMETIS | CALCULUS | TRIGONOMETRY],[Phase getPhaseWithDifficult:MEDIUM andAttriutes:ARITHMETIS],[Phase getPhaseWithDifficult:MEDIUM andAttriutes:ARITHMETIS | CALCULUS],[Phase getPhaseWithDifficult:MEDIUM andAttriutes:ARITHMETIS | CALCULUS | TRIGONOMETRY],[Phase getPhaseWithDifficult:HARD andAttriutes:ARITHMETIS],[Phase getPhaseWithDifficult:HARD andAttriutes:ARITHMETIS | CALCULUS],[Phase getPhaseWithDifficult:HARD andAttriutes:ARITHMETIS | CALCULUS | TRIGONOMETRY],nil];
    }
    return _phaseArray;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.identifier isEqualToString:@"goDirectlyToGameScreen"]) {
        MainGameScreenVC* gameVC = (MainGameScreenVC*)segue.destinationViewController;
        gameVC.careerArray = self.phaseArray;
        gameVC.careerMode = YES;
    }

}


@end
