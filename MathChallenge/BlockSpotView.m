//
//  BlockSpotView.m
//  MathChallenge
//
//  Created by Guilherme Andrade on 1/29/14.
//  Copyright (c) 2014 Guilherme Andrade. All rights reserved.
//

#import "BlockSpotView.h"

@implementation BlockSpotView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}




// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    self.layer.borderColor = [UIColor blackColor].CGColor;
    self.layer.borderWidth = 3.0f;
    self.alpha = 0.5;
    
    if (self.tag == 3) [self setRoundedView:self toDiameter:40];
    else if (self.tag == 1) self.layer.cornerRadius = 7.0;
    else if(self.tag == 4){
//        p3
//       *  *
//    *       *
//    p1******p2
        
        CGPoint p1,p2,p3;
        p1 = CGPointMake(0, self.bounds.size.height - 2);
        p2 = CGPointMake(self.bounds.size.width, p1.y);
        p3 = CGPointMake(self.bounds.size.width/2, 0);
        
        UIBezierPath* path = [[UIBezierPath alloc] init];
        [path moveToPoint:p1];
        [path addLineToPoint:p2];
        [path addLineToPoint:p3];
        [path closePath];
        path.lineWidth = 3;
        
        [[UIColor whiteColor] setFill];
        [[UIColor blackColor] setStroke];
        [path fill];
        [path stroke];
        [path addClip];
        
        
        self.layer.borderWidth = 0;
        self.backgroundColor = [UIColor clearColor];
        
    }
    self.clipsToBounds = YES;
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
