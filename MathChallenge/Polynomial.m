//
//  Polynomial.m
//  MathChallenge
//
//  Created by Guilherme Andrade on 1/26/14.
//  Copyright (c) 2014 Guilherme Andrade. All rights reserved.
//

#import "Polynomial.h"
#import "PolynomialNode.h"

@implementation Polynomial

+ (instancetype)getPolynomialWithSingleNodeAndCoefficient:(CGFloat)coefficient andExponent:(CGFloat)exponent{
    
    if (coefficient == 0) {
        exponent = 0;
    }
    NSMutableArray* array = [NSMutableArray arrayWithObject:[[PolynomialNode alloc] initWithCoefficient:coefficient andExponent:exponent]];
    Polynomial* pol = [[Polynomial alloc] initWithPolynomialNodesArray:array];
    return pol;
}

- (id)initWithPolynomialNodesArray:(NSMutableArray*)array{
    self = [super init];
    if (self) {
        self.polynomialNodesArray = array;
    }
    return self;
}

- (id)initWithFloat:(CGFloat)number{
    self = [super init];
    if (self) {
        self.polynomialNodesArray = [[NSMutableArray alloc] initWithObjects:[[PolynomialNode alloc] initWithCoefficient:number andExponent:0],nil];
    }
    return self;
}


- (NSMutableArray*)polynomialNodesArray{
    if (!_polynomialNodesArray) {
        _polynomialNodesArray = [[NSMutableArray alloc] init];
    }
    return _polynomialNodesArray;
}

- (CGFloat)degree{
    return [[self.polynomialNodesArray objectAtIndex:0] exponent];
}

- (void)print{
    if([self.polynomialNodesArray count] > 0)
    NSLog(@"%@",[self getStringValue]);
}

- (void)generateRandomPolynomialWithDegree:(NSInteger)degree{
    self.degree = degree;
    for (int i = degree; i>= 0; --i) {
        if(i!=degree){
            PolynomialNode *node = [[PolynomialNode alloc] initWithCoefficient:(arc4random()%10) andExponent:i];
            if (node.coefficient == 0)
                continue;
            [self.polynomialNodesArray addObject:node];
        }
        else{
            PolynomialNode *node = [[PolynomialNode alloc] initWithCoefficient:(arc4random()%10 + 1) andExponent:i];
            [self.polynomialNodesArray addObject:node];
        }
    }
}

- (void)derivare{
    for (PolynomialNode *node in self.polynomialNodesArray) {
        node.coefficient*= node.exponent;
        if (node.coefficient == 0 && [self.polynomialNodesArray count] > 1) {
            [self.polynomialNodesArray removeObject:node];
        }
        node.exponent--;
        if (node.coefficient == 0) {
            node.exponent = 0;
        }
    }
}

- (void)integrate{
    
    for (PolynomialNode *node in self.polynomialNodesArray) {
        node.coefficient/= node.exponent + 1;
        if (node.coefficient == 0) {
            [self.polynomialNodesArray removeObject:node];
        }
        node.exponent++;
    }
}

- (void)add:(id)object{
    Polynomial *pol = (Polynomial*)object;

    
    for (PolynomialNode *node in pol.polynomialNodesArray) {
        
        NSInteger index = [self.polynomialNodesArray indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
            PolynomialNode *inBlockNode = (PolynomialNode*)obj;
            
            if (inBlockNode.exponent < node.exponent) {
                *stop = YES;    //uma vez que os arrays estao sempre ordenados em ordem descendente, se o buscado é menor que o corrente, esse necessariamente nao esta contido
                return NO;
            }
            
            if (inBlockNode.exponent == node.exponent)
                return YES;
            return NO;
        }];
        
        if (index == NSNotFound) {
            [self.polynomialNodesArray addObject:[[PolynomialNode alloc] initWithCoefficient:node.coefficient andExponent:node.exponent]];
        }
        else{
            CGFloat newCoefficient = [[self.polynomialNodesArray objectAtIndex:index] coefficient] + node.coefficient;
            if (newCoefficient == 0){
                //maybe there is bugs here!
                
                if ([self.polynomialNodesArray count] > 1) {
                    [self.polynomialNodesArray removeObjectAtIndex:index];
                }
                else if ([self.polynomialNodesArray count] == 1){
                    [[self.polynomialNodesArray objectAtIndex:index] setCoefficient:0.0];
                    [[self.polynomialNodesArray objectAtIndex:index] setExponent:0.0];
                }
                
            }
            else{
                [[self.polynomialNodesArray objectAtIndex:index] setCoefficient:newCoefficient];
            }
        }
        
        
    
    }
    
    [self.polynomialNodesArray sortUsingComparator: ^(id obj1, id obj2) {
        
        if ([obj1 exponent] < [obj2 exponent]) {
            return (NSComparisonResult)NSOrderedDescending;
        }
        
        if ([obj1 exponent] > [obj2 exponent]) {
            return (NSComparisonResult)NSOrderedAscending;
        }
        return (NSComparisonResult)NSOrderedSame;
    }];

}

- (BOOL)isEqual:(id)object{
    Polynomial *pol = (Polynomial*)object;
    if ([self.polynomialNodesArray count] != [pol.polynomialNodesArray count]) {
        
        NSLog(@"dei errado por conta do count diferente %d x %d",[self.polynomialNodesArray count], [pol.polynomialNodesArray count]);
        
        
        return NO;
    }
    else{
        for (int i = 0; i < [self.polynomialNodesArray count]; ++i) {
            if ( [[self.polynomialNodesArray objectAtIndex:i] coefficient] != [[pol.polynomialNodesArray objectAtIndex:i] coefficient]  ||   [[self.polynomialNodesArray objectAtIndex:i] exponent] != [[pol.polynomialNodesArray objectAtIndex:i] exponent] ) {
                return NO;
            }
        }
        return YES;
    }
}

#pragma mark ArgumentProtocol

- (void)multiplyByConstant:(CGFloat)constant{

    for (PolynomialNode *node in self.polynomialNodesArray) {
        node.coefficient *= constant;
    }
}

- (void)multiplyByPolynomial:(Polynomial*)pol{
    for (PolynomialNode* polNode in pol.polynomialNodesArray) {
        for (PolynomialNode* selfNode in self.polynomialNodesArray) {
            selfNode.coefficient*= polNode.coefficient;
            selfNode.exponent+= polNode.exponent;
        }
    }
}

- (NSString*)getStringValue{
    if (![self isSymbolic]) {
        return [NSString stringWithFormat:@"%.0f",[[self.polynomialNodesArray objectAtIndex:0] coefficient]];
    }
    else{
        NSMutableString *stringForReturn = [[NSMutableString alloc] init];
        
        for (NSInteger i=0; i < [self.polynomialNodesArray count] - 1; ++i){
            if ([[self.polynomialNodesArray objectAtIndex:i] coefficient] != 1) {
            [stringForReturn appendString:[NSString stringWithFormat:@"%.1fx%@ + ",[[self.polynomialNodesArray objectAtIndex:i] coefficient],[self getSuperscriptOf:[[self.polynomialNodesArray objectAtIndex:i] exponent]]]];
            }
            
            
//            [self getSuperscriptOf:[[self.polynomialNodesArray objectAtIndex:i] exponent]]]
//            [self getSuperscriptOf:[lastNode exponent]]
            
            else{
            [stringForReturn appendString:[NSString stringWithFormat:@"x%@ + ",[self getSuperscriptOf:[[self.polynomialNodesArray objectAtIndex:i] exponent]]]];
            }
        }
        PolynomialNode *lastNode = [self.polynomialNodesArray objectAtIndex:[self.polynomialNodesArray count]-1];
        if (lastNode.exponent == 0) {
            [stringForReturn appendString:[NSString stringWithFormat:@"%.1f",lastNode.coefficient]];
        }
        else{
            if ([lastNode coefficient] != 1)
                [stringForReturn appendString:[NSString stringWithFormat:@"%.1fx%@",[lastNode coefficient],            [self getSuperscriptOf:[lastNode exponent]]
]];
            else
                [stringForReturn appendString:[NSString stringWithFormat:@"x%@",[self getSuperscriptOf:[lastNode exponent]]
]];

        }
        
        return stringForReturn;
    }
}


- (NSString*)getSuperscriptOf:(NSInteger)x{    
    switch (x) {
        case 0:
            return @"";
            break;
        case 1:
            return @"";
            break;
        case 2:
            return @"²";
            break;
        case 3:
            return @"³";
            break;
        case 4:
            return @"⁴";
            break;
        case 5:
            return @"⁵";
            break;
        case 6:
            return @"⁶";
            break;
        case 7:
            return @"⁷";
            break;
        case 8:
            return @"⁸";
            break;
        case 9:
            return @"⁹";
            break;
        default:
            return @"";
            break;
    }
}

- (id<ArgumentProtocol>)getDerivative{
    if (![self isSymbolic]) {
        
        
    //    NSLog(@"NAO SOU SIMBOLICOOOO");
        
        return [[Polynomial alloc] initWithFloat:0];
    }
        
    else{
        
        NSMutableArray *array = [[NSMutableArray alloc] init];
        for (PolynomialNode *node in self.polynomialNodesArray) {
            [array addObject:[[PolynomialNode alloc] initWithCoefficient:node.coefficient andExponent:node.exponent]];
        }
        
        Polynomial *copy = [[Polynomial alloc] initWithPolynomialNodesArray:array];
        [copy derivare];
        return copy;
    }
}

- (BOOL)isSymbolic{
        return !(self.degree == 0 && [[self.polynomialNodesArray objectAtIndex:0] coefficient] != 0);

}

- (BOOL)isZero{
    if ([self isSymbolic] && [[self.polynomialNodesArray objectAtIndex:0] coefficient] == 0) {
        return YES;
    }
    else
        return NO;
}

- (id<ArgumentProtocol>)getCopy{
    NSMutableArray* array = [[NSMutableArray alloc] init];
    for (PolynomialNode* node in self.polynomialNodesArray) {
        [array addObject:[[PolynomialNode alloc] initWithCoefficient:node.coefficient andExponent:node.exponent]];
    }
    Polynomial* pol = [[Polynomial alloc] initWithPolynomialNodesArray:array];
    return pol;
}


+ (id<ArgumentProtocol>)returnNullElement{
    return [[Polynomial alloc] initWithFloat:0.0];
}

@end
