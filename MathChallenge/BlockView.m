//
//  BlockView.m
//  MathChallenge
//
//  Created by Guilherme Andrade on 1/29/14.
//  Copyright (c) 2014 Guilherme Andrade. All rights reserved.
//

#import "BlockView.h"
#import "RandomView.h"

//static const CGSize DROP_SIZE = {75,40};

@interface BlockView ()

@property (strong, nonatomic) NSString* stringValue;





@end


@implementation BlockView


//- (void)setCenter:(CGPoint)center{
//    
//    CGPoint centerModed = center;
//    
////    if (center.x > self.gameView.bounds.size.width) {
////        centerModed.x-= self.gameView.frame.size.width;
////    }
////    else if (center.x < self.gameView.bounds.size.width) {
////        centerModed.x+= self.gameView.frame.size.width;
////    }
////    if (center.y > self.gameView.bounds.size.height) {
////        centerModed.y-= self.gameView.frame.size.height;
////    }
////    else if (center.y < self.gameView.bounds.size.height) {
////        centerModed.y+= self.gameView.frame.size.height;
////    }
//
//    
//    super.center = centerModed;
//    NSLog(@"(%f, %f)",centerModed.x,centerModed.y);
//    
//}



- (id)initWithFrame:(CGRect)frame andExpression:(Expression*)exp
{
    self = [super initWithFrame:frame];
    if (self) {
        self.exp = exp;
    }
    return self;
}


- (id)initWithExpression:(Expression*)exp OnView:(UIView*)view
{
    CGRect frame;
    CGSize DROP_SIZE = CGSizeMake([[exp getStringValue] sizeWithAttributes:nil].width*2,[[exp getStringValue] sizeWithAttributes:nil].height*2);
 
    if (![[exp.amountsArray objectAtIndex:1] isNull]) {
        frame.size = CGSizeMake(DROP_SIZE.width*1, DROP_SIZE.height*1.05);

    }
    else{
        frame.size = CGSizeMake(DROP_SIZE.width*1.18, DROP_SIZE.height*1.05);
    }
    
    frame.origin = [RandomView returnRandomPointInView:view withGrid:DROP_SIZE];
    
    
    self = [super initWithFrame:frame];
    if (self) {
        self.exp = exp;
        self.stringValue = [exp getStringValue];
    }
    return self;
}


- (id)initWithOperator:(ExpressionOperator*)expOp OnView:(UIView*)view
{
    
    const CGSize DROP_SIZE = CGSizeMake([[expOp getStringValue] sizeWithAttributes:nil].width*3,[[expOp getStringValue] sizeWithAttributes:nil].height*3);

    
    
    CGRect frame;
    frame.size = DROP_SIZE;
    frame.origin = [RandomView returnRandomPointInView:view withGrid:DROP_SIZE];
    
    
    self = [super initWithFrame:frame];
    if (self) {
        self.expOp = expOp;
        self.stringValue = [expOp getStringValue];
    }
    return self;
}



- (void)setExp:(Expression *)exp{
    _exp = exp;
    [self setNeedsDisplay];
}


- (void)drawRect:(CGRect)rect
{
    
    if (self.exp) {
        NSMutableAttributedString *attString=[[NSMutableAttributedString alloc] initWithString:self.stringValue];
        NSInteger _stringLength=[self.stringValue length];
        UIColor *_black=[UIColor blackColor];
        UIFont *font=[UIFont fontWithName:@"AmericanTypewriter" size:20.0f];
        [attString addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, _stringLength)];
        [attString addAttribute:NSForegroundColorAttributeName value:_black range:NSMakeRange(0, _stringLength)];
        [attString drawAtPoint:CGPointMake(2, 2)];
    }
    
    if (self.expOp) {
        
        UILabel *label = [[UILabel alloc] init];
        
        label.text = self.stringValue;
        label.font = [UIFont fontWithName:@"AmericanTypewriter" size:20];
        
        CGRect frameLabel = self.bounds;
        
        if (self.expOp.operatorType == EQUAL){
            
            UIImageView *redStar = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"redStar"]];
            
            CGRect frame = self.bounds;
            
            frame.size.width *= 2;
            frame.origin.x -= 10;

            redStar.frame = frame;

            frameLabel = self.bounds;
            frameLabel.origin.x += 6;
            frameLabel.origin.y += 2;
            
            [self addSubview:redStar];
            
        } else if (self.expOp.operatorType == PLUS || self.expOp.operatorType == MINUS || self.expOp.operatorType == TIMES){
            
            UIImageView *newImage = [[UIImageView alloc] init];
            
//            CGRect newFrame = CGRectMake(self.frame.origin.x, self.frame.origin.y, 40, 40);
//            self.frame = newFrame;
//            self.layer.cornerRadius = 20;
            
            [self setRoundedView:self toDiameter:40];
            
            newImage.frame = self.bounds;
            
            [self setRoundedView:newImage toDiameter:40];
            
            newImage.frame = self.bounds;
            [newImage setBackgroundColor:[UIColor grayColor]];
            
            frameLabel = self.bounds;
            frameLabel.origin.x = 15;
            
            if (self.expOp.operatorType == TIMES) {
                frameLabel.origin.x -= 5;
                frameLabel.origin.y += 1;
            }
//            frameLabel.origin.y -= 5;
            
            [self addSubview:newImage];
            
        } else if (self.expOp.operatorType == DIFFERENTIAL || self.expOp.operatorType == INTEGRAL) {
            
            UIImageView *redRectangle = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rectagle-red"]];
            
            CGRect frame = self.bounds;
            frameLabel = self.bounds;
            
            if (self.expOp.operatorType == INTEGRAL) {
                frame.size.width = frame.size.width*2;
                self.bounds = frame;
                
            }
            
            frame.size.width = frame.size.width*2;
            frame.origin.x = frame.origin.x - 10;
            
            frameLabel.origin.x += 5;
            redRectangle.frame = frame;
            
            [self addSubview:redRectangle];
        }
        
        label.frame = frameLabel;
        
        [self addSubview:label];
    }
    
}

-(void)setRoundedView:(UIView *)roundedView toDiameter:(float)newSize;
{
    CGPoint saveCenter = roundedView.center;
    CGRect newFrame = CGRectMake(roundedView.frame.origin.x, roundedView.frame.origin.y, newSize, newSize);
    roundedView.frame = newFrame;
    roundedView.layer.cornerRadius = newSize / 2.0;
    roundedView.center = saveCenter;
}

@end
