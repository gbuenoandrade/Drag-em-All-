//
//  MainGameScreenVC.m
//  MathChallenge
//
//  Created by Guilherme Andrade on 1/29/14.
//  Copyright (c) 2014 Guilherme Andrade. All rights reserved.
//

#import "MainGameScreenVC.h"
#import "BlockView.h"
#import "PolynomialNode.h"
#import "BlockSpotView.h"
#import "ExpressionOperator.h"
#import "Polynomial.h"
#import "TrigonometricFunction.h"
#import "PolynomialNode.h"

#import "MutableArrayOfTrigonometricFuntions.h"

#import "RemovedBlockViews.h"
#import "Doida.h"

#import "Hint.h"
#import "RandomView.h"

@interface MainGameScreenVC () <UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *gameView;
@property (weak, nonatomic) IBOutlet UIView *blocksStartView;

@property (weak, nonatomic) IBOutlet BlockSpotView *leftOperator;
@property (weak, nonatomic) IBOutlet BlockSpotView *middleOperator;
@property (weak, nonatomic) IBOutlet BlockSpotView *rightOperator;
@property (weak, nonatomic) IBOutlet BlockSpotView *leftOperand;
@property (weak, nonatomic) IBOutlet BlockSpotView *rightOperand;
@property (weak, nonatomic) IBOutlet BlockSpotView *resultOperand;
@property (weak, nonatomic) IBOutlet BlockSpotView *equalitySign;

@property (weak, nonatomic) IBOutlet UILabel *labelRemainingPieces;
@property (nonatomic) NSInteger remainingPieces;

@property (strong, nonatomic) NSMutableArray *operandArray;
@property (strong, nonatomic) NSMutableArray *operatorArray;

@property (strong, nonatomic) NSArray *operatorSpotsArray;
@property (strong, nonatomic) NSArray *operandSpotsArray;


@property (strong, nonatomic) NSArray *generalSpotsArray;

@property (weak, nonatomic) IBOutlet UITextView *textView;

@property (strong, nonatomic) UIDynamicAnimator *animator;
@property (strong, nonatomic) UICollisionBehavior *collision;


@property (strong, nonatomic) RemovedBlockViews* removedBlockViews;


@property (strong, nonatomic) NSMutableString* textViewMutableString;

@property (strong, nonatomic) NSMutableArray* arrayWithReferenceForAllBlocks;

@property (strong, nonatomic) Hint* hintInstance;
@property (weak, nonatomic) IBOutlet UIButton *nextPhaseButton;

@end

typedef enum{
    NON_EVALUABLE, EVALUABLE_WITH_LEFT_OPERAND, EVALUABLE_WITH_RIGHT_OPERAND,EVALUABLE_WITH_TWO_OPERANDS
}viewExpressionCases;



@implementation MainGameScreenVC

#pragma mark - Lazy Instantiations

- (Hint*)hintInstance{
    if (!_hintInstance) {
        _hintInstance = [[Hint alloc] init];
    }
    return _hintInstance;
}
- (NSMutableArray*)arrayWithReferenceForAllBlocks{
    if (!_arrayWithReferenceForAllBlocks) {
        _arrayWithReferenceForAllBlocks = [NSMutableArray array];
    }
    return _arrayWithReferenceForAllBlocks;
}

- (NSMutableString*)textViewMutableString{
    if (!_textViewMutableString) {
        _textViewMutableString = [[NSMutableString alloc] init];
    }
    return _textViewMutableString;
}

- (RemovedBlockViews*)removedBlockViews{
    if (!_removedBlockViews) {
        _removedBlockViews = [[RemovedBlockViews alloc] initWithColision:self.collision];
        _removedBlockViews.blocksStartView = self.blocksStartView;
    }
    return _removedBlockViews;
}

- (void)setRemainingPieces:(NSInteger)remainingPieces{
    _remainingPieces = remainingPieces;
    self.labelRemainingPieces.text = [NSString stringWithFormat:@"Peças restantes: %d",_remainingPieces];
    if (remainingPieces == 0 && self.careerMode) {
        [self endPhase];
    }
    else if (remainingPieces == 0 && !self.careerMode){
        NSLog(@"FIM DE PARTIDA SIMPLES");
        [self performSegueWithIdentifier:@"returnToWelcomeScreen" sender:nil];
    }
}

- (NSArray*)operatorSpotsArray{
    if (!_operatorSpotsArray) {
        _operatorSpotsArray = [NSArray arrayWithObjects:self.leftOperator,self.rightOperator, nil];
    }
    return _operatorSpotsArray;
}

- (NSArray*)operandSpotsArray{
    if (!_operandSpotsArray) {
        _operandSpotsArray = [NSArray arrayWithObjects:self.leftOperand,self.rightOperand,self.resultOperand, nil];
    }
    return _operandSpotsArray;
}

- (NSArray*)generalSpotsArray{
    if (!_generalSpotsArray) {
        _generalSpotsArray = [NSArray arrayWithObjects:self.leftOperand,self.rightOperand,self.resultOperand,self.leftOperator,self.rightOperator,self.middleOperator,self.equalitySign, nil];
    }
    return _generalSpotsArray;
}

- (UICollisionBehavior*)collision{
    if (!_collision) {
        _collision = [[UICollisionBehavior alloc] init];
        
        
//        _collision.translatesReferenceBoundsIntoBoundary = YES;
        
//        p1-------p2
//        -         -
//        -         -
//        -         -
//        -         -
//        -         -
//        p3-------p4
        
//        CGPoint p1,p2,p3,p4;
//        p1 = self.gameView.frame.origin;
//        p2 = CGPointMake(p1.x + self.gameView.frame.size.width, p1.y);
//        p3 = CGPointMake(p1.x, p1.y + self.gameView.frame.size.height);
//        p4 = CGPointMake(p2.x, p2.y + self.gameView.frame.size.height);
//    
//        [_collision addBoundaryWithIdentifier:@"upperWall" fromPoint:p1 toPoint:p2];
//        [_collision addBoundaryWithIdentifier:@"lowerWall" fromPoint:p3 toPoint:p4];
//        [_collision addBoundaryWithIdentifier:@"leftWall" fromPoint:p1 toPoint:p3];
//        [_collision addBoundaryWithIdentifier:@"rightWall" fromPoint:p2 toPoint:p4];

    }
    return _collision;
}

- (UIDynamicAnimator*)animator{
    if (!_animator) {
        _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.gameView];
    }
    return _animator;
}

- (NSMutableArray*)operandArray{
    if (!_operandArray) {
        _operandArray = [[NSMutableArray alloc] init];
    }
    return _operandArray;
}

- (NSMutableArray*)operatorArray{
    if (!_operatorArray) {
        _operatorArray = [[NSMutableArray alloc] init];
    }
    return _operatorArray;
}

#pragma mark - Auxiliary Methods

- (BlockSpotView*)blockSpotviewForBlock:(BlockView*)block thatContainsPoint:(CGPoint)point{
    
    NSArray* arrayWithSpots;
    if (block.exp) {
        arrayWithSpots = self.operandSpotsArray;
    }
    else if (block.expOp){
        if (block.expOp.operatorType == PLUS || block.expOp.operatorType == MINUS ||block.expOp.operatorType == TIMES ||block.expOp.operatorType == DIVISION) {
            arrayWithSpots = [NSArray arrayWithObject:self.middleOperator];
        }
        else if (block.expOp.operatorType == EQUAL){
            arrayWithSpots = [NSArray arrayWithObject:self.equalitySign];
        }
        else{
            arrayWithSpots = self.operatorSpotsArray;
        }
    }
    
    for (BlockSpotView* blockSpot in arrayWithSpots) {
        CGRect targetFrame = blockSpot.frame;
        if (point.x >= targetFrame.origin.x && point.x <= (targetFrame.origin.x + targetFrame.size.width)
            && point.y >= targetFrame.origin.y && point.y <= (targetFrame.origin.y + targetFrame.size.height))
            return blockSpot;
    }
    
    return nil;
}

- (void)attachBlock:(BlockView*)blockView toPoint:(CGPoint)anchorPoint{
    blockView.attach = [[UIAttachmentBehavior alloc]initWithItem:blockView attachedToAnchor:anchorPoint];
    blockView.attach.length = 0.0;
    [self.animator addBehavior:blockView.attach];
}


- (void)clearScreen{
    [self.animator removeAllBehaviors];
    self.removedBlockViews = nil;
    [self.operandArray removeAllObjects];
    [self.operatorArray removeAllObjects];
}







- (void)setup{
    
    if (!self.careerMode) {
        self.nextPhaseButton.hidden = YES;
    }
    
    [self.animator addBehavior:self.collision];
    
    if (self.careerMode && [self.careerArray count] > 0) {
        Phase* currentPhase = [self.careerArray firstObject];
        self.currentDifficult = currentPhase.difficult;
        self.currentAttributes = currentPhase.attributes;
        [self.careerArray removeObject:currentPhase];
    }
    else if (self.careerMode && [self.careerArray count] == 0) {
        
        NSLog(@"FIM DE CARREIRA!");
        [self performSegueWithIdentifier:@"returnToWelcomeScreen" sender:nil];
        
        
    }
    
    
    [ExpressionSetsGenerator generate:(NSInteger)self.currentDifficult WithOperandArray:self.operandArray andOperatorArray:self.operatorArray withAttributes:self.currentAttributes];
    
    for (id x in self.operandArray) {
        Expression* exp;
        if ([x isKindOfClass:[Polynomial class]])
            exp = [[Expression alloc] initWithPolynomial:x andArrayOfTrigonometricFunction:[MutableArrayOfTrigonometricFuntions returnNullElement]];
        else if ([x isKindOfClass:[MutableArrayOfTrigonometricFuntions class]])
            exp = [[Expression alloc] initWithPolynomial:[Polynomial returnNullElement] andArrayOfTrigonometricFunction:x];
        
        BlockView* block = [[BlockView alloc] initWithExpression:exp OnView:self.blocksStartView];
        [block setBackgroundColor:[UIColor orangeColor]];
        UIPanGestureRecognizer* pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
        [block addGestureRecognizer:pan];
        
        [self.gameView addSubview:block];
        [self.collision addItem:block];
        [self.arrayWithReferenceForAllBlocks addObject:block];
        self.remainingPieces++;
    }
    
    for (id x in self.operatorArray) {
        
        BlockView* block = [[BlockView alloc]initWithOperator:x OnView:self.blocksStartView];
        
        [block setBackgroundColor:[UIColor clearColor]];
        UIPanGestureRecognizer* pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
        [block addGestureRecognizer:pan];
        
        //teste
        block.gameView = self.gameView;
        
        
        [self.gameView addSubview:block];
        [self.collision addItem:block];
        [self.arrayWithReferenceForAllBlocks addObject:block];
        self.remainingPieces++;
        
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setup];
    
}

- (IBAction)restoreLotOfRemovedView:(id)sender {
    
    self.remainingPieces+= [self.removedBlockViews restoreLastLotAndReturnLotSize];
    
}

- (void)pan:(UIPanGestureRecognizer*)sender{
    CGPoint gesturePoint = [sender locationInView:self.gameView];

    
    BlockView *blockView = (BlockView*)sender.view;
    
    if(sender.state == UIGestureRecognizerStateBegan){
        if (blockView.snap) {
            [self.animator removeBehavior:blockView.snap];
            blockView.snap = nil;
            [self removeFromRespectiveSpotTheBlockView:blockView];
        }
            [self attachBlock:blockView toPoint:gesturePoint];
    }
    else if (sender.state == UIGestureRecognizerStateChanged){
        blockView.attach.anchorPoint = gesturePoint;
    }
    else if (sender.state == UIGestureRecognizerStateEnded){
        [self.animator removeBehavior:blockView.attach];
        
        BlockSpotView* blockSpot = [self blockSpotviewForBlock:blockView thatContainsPoint:gesturePoint];
        if (blockSpot) {
            
            if (blockSpot.withinBlock) {
                [self.animator removeBehavior:blockSpot.withinBlock.snap];
                blockSpot.withinBlock.snap = nil;
            }
            
            
            blockView.snap = [[UISnapBehavior alloc] initWithItem:blockView snapToPoint:blockView.center];
            blockView.snap.damping = 0.1;
            [self.animator addBehavior:blockView.snap];
            blockSpot.withinBlock = blockView;
        }
        
    }
}




- (void)removeFromRespectiveSpotTheBlockView:(BlockView*)block {
    NSArray* arrayWithSpots;
    if (block.exp) {
        arrayWithSpots = self.operandSpotsArray;
    }
    else if (block.expOp){
        if (block.expOp.operatorType == PLUS || block.expOp.operatorType == MINUS ||block.expOp.operatorType == TIMES ||block.expOp.operatorType == DIVISION) {
            arrayWithSpots = [NSArray arrayWithObject:self.middleOperator];
        }
        else if (block.expOp.operatorType == EQUAL){
            arrayWithSpots = [NSArray arrayWithObject:self.equalitySign];
        }
        else{
            arrayWithSpots = self.operatorSpotsArray;
        }
    }
    
    for (BlockSpotView* blockSpot in arrayWithSpots) {
        if (blockSpot.withinBlock == block){
            blockSpot.withinBlock = nil;
            return;
        }
    }
}



- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation{
    NSLog(@"gireeeei");
}

- (IBAction)evaluateExpression:(id)sender {
    Expression* leftExpression;
    switch ([self returnCurrentViewExpressionCase]) {
        case EVALUABLE_WITH_LEFT_OPERAND:
        {
            NSLog(@"EVALUABLE WITH LEFT OPERAND EXPRESSION");
            leftExpression = [self getExpressionWhitinBlockSpotView:self.leftOperand andApplyOperator:self.leftOperator withCopyInCaseOfNilOperator:NO];
        }
            break;
        case EVALUABLE_WITH_RIGHT_OPERAND:
        {
            NSLog(@"EVALUABLE WITH RIGHT OPERAND EXPRESSION");
           leftExpression = [self getExpressionWhitinBlockSpotView:self.rightOperand andApplyOperator:self.rightOperator withCopyInCaseOfNilOperator:NO];
        }
            break;
        case EVALUABLE_WITH_TWO_OPERANDS:
        {
            leftExpression = [self getExpressionWhitinBlockSpotView:self.leftOperand andApplyOperator:self.leftOperator withCopyInCaseOfNilOperator:YES];
            
            switch (self.middleOperator.withinBlock.expOp.operatorType) {
                case PLUS:
                {
                    [leftExpression add:[self getExpressionWhitinBlockSpotView:self.rightOperand andApplyOperator:self.rightOperator withCopyInCaseOfNilOperator:NO]];
                }
                    break;
                case MINUS:
                {
                    Expression* rightExpression = [self getExpressionWhitinBlockSpotView:self.rightOperand andApplyOperator:self.rightOperator withCopyInCaseOfNilOperator:YES];
                    Expression* signalChangeExpression = [[Expression alloc] initWithPolynomial:[Polynomial getPolynomialWithSingleNodeAndCoefficient:-1 andExponent:0] andArrayOfTrigonometricFunction:[MutableArrayOfTrigonometricFuntions returnNullElement]];
                    [rightExpression multiply:signalChangeExpression];
                    [leftExpression add:rightExpression];
                }
                    break;
                case TIMES:
                {
                    
                    NSLog(@"entrei na multiplicao");
                    
                    [leftExpression multiply:[self getExpressionWhitinBlockSpotView:self.rightOperand andApplyOperator:self.rightOperator withCopyInCaseOfNilOperator:NO]];
                }
                    break;
                default:
                    break;
            }
            
        }
            break;
        default:    //NON_EVALUABLE
        {
            [self.textViewMutableString insertString:@"Expressão incompleta!\n\n" atIndex:0];
            self.textView.text = self.textViewMutableString;
            self.textView.font = [UIFont fontWithName:@"AmericanTypewriter-CondensedBold" size:16.0];
            self.textView.textAlignment = UITextAlignmentCenter;
            self.textView.textColor = [UIColor blackColor];
            return;
        }
            break;
    }
    if ([leftExpression isEqual:self.resultOperand.withinBlock.exp]) {
        NSLog(@"EQUAL EXPRESSIONS");
        [self decreaseRemainingPiecesLabelAndSetAlphaZero];
    }
    else{
        
        [self.textViewMutableString insertString:[self.hintInstance getStringHintForExpression:leftExpression] atIndex:0];
        [self.textViewMutableString insertString:@"Expressão incorreta!\n" atIndex:0];
        self.textView.text = self.textViewMutableString;
        self.textView.font = [UIFont fontWithName:@"AmericanTypewriter-CondensedBold" size:16.0];
        self.textView.textAlignment = UITextAlignmentCenter;
        self.textView.textColor = [UIColor blackColor];

        NSLog(@"DIFFERENT EXPRESSIONS");
        
        
    }
}


- (void)endPhase{
    [self clearScreen];
    [self setup];
    
    NSLog(@"FASE CONCLUIDA!");
    
}


- (IBAction)returnHome:(id)sender {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Confirmação" message:@"Deseja voltar à tela inicial?" delegate:self cancelButtonTitle:@"Cancelar" otherButtonTitles:@"Sim", nil];
    
    [alert show];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        [self performSegueWithIdentifier:@"returnToWelcomeScreen" sender:nil];
    }

}

- (void)decreaseRemainingPiecesLabelAndSetAlphaZero{
    for (BlockSpotView* spotView in self.generalSpotsArray) {
        if (spotView.withinBlock) {
            [self.removedBlockViews addBlock:spotView.withinBlock];
            [self.animator removeBehavior:spotView.withinBlock.snap];
            [self.collision removeItem:spotView.withinBlock];
            
            [UIView animateWithDuration:1.2 animations:^{
                spotView.withinBlock.alpha = 0;
            } completion:^(BOOL finished) {
                spotView.withinBlock = nil;
                self.remainingPieces--;
            }];
            
        }
    }
    [self.removedBlockViews finishLot];
    
}

- (Expression*)getExpressionWhitinBlockSpotView:(BlockSpotView*)operandSpot andApplyOperator:(BlockSpotView*)operatorSpot withCopyInCaseOfNilOperator:(BOOL)copy{
    Expression* exp;
    if (operatorSpot.withinBlock.expOp) {
        exp = [operandSpot.withinBlock.exp getCopy];
        switch (operatorSpot.withinBlock.expOp.operatorType) {
            case DIFFERENTIAL:
                [exp derivare];
                break;
            case INTEGRAL:
                [exp integrate];
                break;
            default:
                break;
        }
    }
    else{
        if (copy) {
            exp = [operandSpot.withinBlock.exp getCopy];
        }
        else{
            exp = operandSpot.withinBlock.exp;
        }
    }
    return exp;
}


- (viewExpressionCases)returnCurrentViewExpressionCase{
    viewExpressionCases viewCase = NON_EVALUABLE;
    
    if (self.equalitySign.withinBlock && self.resultOperand.withinBlock) {
        if (self.leftOperand.withinBlock || self.rightOperand.withinBlock) {
            if (self.leftOperand.withinBlock && self.rightOperand.withinBlock && self.middleOperator.withinBlock) {
                viewCase = EVALUABLE_WITH_TWO_OPERANDS;
            }
            else if (self.leftOperand.withinBlock && !self.rightOperand.withinBlock && !self.middleOperator.withinBlock && !self.rightOperator.withinBlock){
                viewCase = EVALUABLE_WITH_LEFT_OPERAND;
            }
            else if (self.rightOperand.withinBlock && !self.leftOperand.withinBlock && !self.middleOperator.withinBlock && !self.leftOperator.withinBlock){
                viewCase = EVALUABLE_WITH_RIGHT_OPERAND;
            }
        }
    }
    return viewCase;
}

- (BOOL)isBlock:(BlockView*)block beyondView:(UIView*)view{
    
    if (block.center.x > view.frame.origin.x + view.frame.size.width || block.center.x < view.frame.origin.x ||
        block.center.y > view.frame.origin.y + view.frame.size.height || block.center.y < view.frame.origin.y ) {
        return YES;
    }
    return NO;
}

// game shark for test
- (IBAction)nextPhase:(id)sender {
    if (self.careerMode) {
        
        [self.arrayWithReferenceForAllBlocks enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            BlockView* block = (BlockView*)obj;
            block.alpha = 0;
            [self.collision removeItem:block];
        }];
        [self.arrayWithReferenceForAllBlocks removeAllObjects];
        
        
        [self endPhase];
    }
}
- (IBAction)recoverBlocks:(id)sender {
    
    for (BlockView* block in self.arrayWithReferenceForAllBlocks) {
        if ([self isBlock:block beyondView:self.gameView]) {
            [self.collision removeItem:block];
            block.center = [RandomView returnRandomPointInView:self.blocksStartView withGrid:block.frame.size];
            [self.collision addItem:block];
        }
    }

}

@end
