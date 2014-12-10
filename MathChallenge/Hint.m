//
//  Hint.m
//  MathChallenge
//
//  Created by Guilherme Andrade on 2/6/14.
//  Copyright (c) 2014 Guilherme Andrade. All rights reserved.
//

#import "Hint.h"
#import "Expression.h"

typedef enum{
    TRIG, ARI,CALC
}ExpKind;

@interface Hint ()

@property (strong, nonatomic) NSArray* trigonometricHints;
@property (strong, nonatomic) NSArray* arithmeticsHints;
@property (strong, nonatomic) NSArray* calculusHints;


@end

@implementation Hint

- (NSArray*)arithmeticsHints{
    if (!_arithmeticsHints) {
        _arithmeticsHints = [NSArray arrayWithObjects:@"DICA: Você pode multiplicar por 5 multiplicando por 10 e depois dividindo por 2\n\n", @"DICA: Para multiplicar por 9 basta multiplicar por 10 e subtrair o número original\n\n",nil];
    }
    return _arithmeticsHints;
}

- (NSArray*)calculusHints{
    if (!_calculusHints) {
        _calculusHints = [NSArray arrayWithObjects:@"DICA: A derivada de uma constante é zero\n\n", @"DICA: A derivada de x em relação a x é 1\n\n",@"DICA: As constantes devem ser colocadas para o lado de fora do sinal de derivação\n\n",nil];
    }
    return _calculusHints;
}

- (NSArray*)trigonometricHints{
    if (!_trigonometricHints) {
        _trigonometricHints = [NSArray arrayWithObjects:@"DICA: Não esqueça a regra da cadeia\n\n", @"DICA: Derivada de seno é igual a cosseno\n\n", @"DICA: Derivada de cosseno é igual a menos seno\n\n",nil];
    }
    return _trigonometricHints;
}

- (NSString*)getStringHintForExpression:(Expression*)exp{
    ExpKind kind = [self getExpressionKindOfExpression:exp];
    
    switch (kind) {
        case TRIG:
        {
            NSInteger hintNumber = arc4random()%[self.trigonometricHints count];
            return [self.trigonometricHints objectAtIndex:hintNumber];
        }
            break;
        case CALC:
        {
            NSInteger hintNumber = arc4random()%[self.calculusHints count];
            return [self.calculusHints objectAtIndex:hintNumber];

        }
            break;
        default:    //ARI
        {
            NSInteger hintNumber = arc4random()%[self.arithmeticsHints count];
            return [self.arithmeticsHints objectAtIndex:hintNumber];
        }
            break;
    }
    
}

- (ExpKind)getExpressionKindOfExpression:(Expression*)exp{
    if (![[exp.amountsArray objectAtIndex:1] isNull]) {
        return TRIG;
    }
    else if ([[exp.amountsArray objectAtIndex:0] isSymbolic]){
        return CALC;
    }
    else{
        return ARI;
    }
}
@end
