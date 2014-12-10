//
//  RemovedBlockViews.m
//  MathChallenge
//
//  Created by Guilherme Andrade on 2/4/14.
//  Copyright (c) 2014 Guilherme Andrade. All rights reserved.
//

#import "RemovedBlockViews.h"
#import "RandomView.h"

@interface RemovedBlockViews ()

@property (nonatomic) NSInteger currentLotSize;
@property (strong, nonatomic) NSMutableArray* removedBlockViewsArray;
@property (strong, nonatomic) NSMutableArray* lotsSizeArray;
@property (strong, nonatomic) UICollisionBehavior* colision;


@end


@implementation RemovedBlockViews

- (id)initWithColision:(UICollisionBehavior*)colision{
    self = [super init];
    if (self) {
        self.removedBlockViewsArray = [[NSMutableArray alloc] init];
        self.lotsSizeArray = [[NSMutableArray alloc] init];
        self.currentLotSize = 0;
        self.colision = colision;
    }
    return self;
}


- (NSInteger)restoreLastLotAndReturnLotSize{
    NSInteger lastLotSize = 0;
    
    NSLog(@"quantidade de lotes: %d",[self.lotsSizeArray count]);
    
    
    if ([self.removedBlockViewsArray count] != 0) {
        
        
        lastLotSize = [[self.lotsSizeArray lastObject] integerValue];
        NSLog(@"estou no caminho pra remover, removedBlocks count: %d",[self.removedBlockViewsArray count]);
        [self.lotsSizeArray removeLastObject];
        NSRange range;
        range.location = [self.removedBlockViewsArray count] - lastLotSize;
        range.length = lastLotSize;
        
        NSLog(@"(%d ... %d)",range.location,range.location + range.length);
        
        
        for (int i=1; i<=lastLotSize; ++i){
            BlockView* rebornedBlock = [self.removedBlockViewsArray objectAtIndex:[self.removedBlockViewsArray count] - i];
            CGRect newFrame;
            newFrame.size = rebornedBlock.frame.size;
            newFrame.origin = [RandomView returnRandomPointInView:self.blocksStartView withGrid:rebornedBlock.frame.size];
            rebornedBlock.frame = newFrame;
            
            [UIView animateWithDuration:1 animations:^{
                rebornedBlock.alpha = 1.0;
            }];
            
            [self.colision addItem:rebornedBlock];
        }
        
        [self.removedBlockViewsArray removeObjectsInRange:range];
    }
    return lastLotSize;
}

- (void)addBlock:(BlockView*)block{
    [self.removedBlockViewsArray addObject:block];
    self.currentLotSize++;
}

- (void)finishLot{
    NSNumber* x = [[NSNumber alloc] initWithInteger:self.currentLotSize];
    [self.lotsSizeArray addObject:x];
    self.currentLotSize = 0;
}





@end
