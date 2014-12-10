//
//  RandomView.h
//  MathChallenge
//
//  Created by Guilherme Andrade on 2/6/14.
//  Copyright (c) 2014 Guilherme Andrade. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RandomView : NSObject

+ (CGPoint)returnRandomPointInView:(UIView*)view withGrid:(CGSize)size;

@end
