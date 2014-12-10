//
//  OptionsScreenVC.m
//  MathChallenge
//
//  Created by Guilherme Andrade on 2/5/14.
//  Copyright (c) 2014 Guilherme Andrade. All rights reserved.
//

#import "OptionsScreenVC.h"
#import "MainGameScreenVC.h"

@interface OptionsScreenVC ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentDifficult;
@property (weak, nonatomic) IBOutlet UISwitch *arithmeticSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *trigonometrySwitch;
@property (weak, nonatomic) IBOutlet UISwitch *calculusSwitch;


@property (nonatomic) Difficult selectedDifficult;
@property (nonatomic) ExpressionSetsGeneratorAttributes selectedAttributes;


@end

@implementation OptionsScreenVC


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    UIFont *font=[UIFont fontWithName:@"AmericanTypewriter" size:16.0f];    
    
    NSDictionary *attributes = [NSDictionary dictionaryWithObject:font
                                                           forKey:NSFontAttributeName];
    [self.segmentDifficult setTitleTextAttributes:attributes
                                    forState:UIControlStateNormal];
    
    
    
    
}

- (Difficult)selectedDifficult{
    switch (self.segmentDifficult.selectedSegmentIndex) {
        case 0:
            return EASY;
            break;
        case 1:
            return MEDIUM;
            break;
        case 2:
            return HARD;
            break;
        default:
            return MEDIUM; // whatever
            break;
    }
}

- (ExpressionSetsGeneratorAttributes)selectedAttributes{
    ExpressionSetsGeneratorAttributes attributes=0;
    
    if (self.arithmeticSwitch.isOn)
        attributes= attributes | ARITHMETIS;
    if (self.trigonometrySwitch.isOn)
        attributes= attributes | TRIGONOMETRY;
    if (self.calculusSwitch.isOn)
        attributes= attributes | CALCULUS;
    
    if (attributes == 0) {
        attributes = ARITHMETIS; //temporary solution to avoid crash
    }
    
    return attributes;
}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    MainGameScreenVC* gameVC = (MainGameScreenVC*)segue.destinationViewController;
    gameVC.currentAttributes = self.selectedAttributes;
    gameVC.currentDifficult = self.selectedDifficult;
}

@end
