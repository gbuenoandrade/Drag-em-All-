//
//  RemovedBlockViews.h
//  MathChallenge
//
//  Created by Guilherme Andrade on 2/4/14.
//  Copyright (c) 2014 Guilherme Andrade. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BlockView.h"

@interface RemovedBlockViews : NSObject


- (void)addBlock:(BlockView*)block;
- (void)finishLot;

- (NSInteger)restoreLastLotAndReturnLotSize;


- (id)initWithColision:(UICollisionBehavior*)colision;

@property (strong, nonatomic) UIView* blocksStartView;


@end
