//
//  ArgumentProtocol.h
//  MathChallenge
//
//  Created by Guilherme Andrade on 1/26/14.
//  Copyright (c) 2014 Guilherme Andrade. All rights reserved.
//

#import <Foundation/Foundation.h>


@class Polynomial;
@protocol ArgumentProtocol <NSObject>

//- (void)integrate;

- (void)multiplyByConstant:(CGFloat)constant;
- (NSString*)getStringValue;
- (id<ArgumentProtocol>)getDerivative;
- (BOOL)isSymbolic;
- (BOOL)isZero;
+ (id<ArgumentProtocol>)returnNullElement;
- (void)add:(id)object;
- (id<ArgumentProtocol>)getCopy;

- (void)multiplyByPolynomial:(Polynomial*)pol;


@end
