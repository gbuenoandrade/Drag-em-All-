//
//  BlockView.h
//  MathChallenge
//
//  Created by Guilherme Andrade on 1/29/14.
//  Copyright (c) 2014 Guilherme Andrade. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Expression.h"
#import "ExpressionOperator.h"

@interface BlockView : UIView

@property (strong, nonatomic) Expression* exp;
@property (strong, nonatomic) ExpressionOperator* expOp;


@property (strong, nonatomic) UIAttachmentBehavior* attach;
@property (strong, nonatomic) UISnapBehavior* snap;

- (id)initWithFrame:(CGRect)frame andExpression:(Expression*)exp;
- (id)initWithExpression:(Expression*)exp OnView:(UIView*)view;
- (id)initWithOperator:(ExpressionOperator*)expOp OnView:(UIView*)view;



@property (strong, nonatomic) UIView* gameView;



@end
