//
//  ViewController.m
//  DaikeInterview
//
//  Created by 李伯通 on 16/7/5.
//  Copyright © 2016年 李伯通. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1. Product Array testing
    NSArray *arr0 = @[@1, @2, @3, @4];
    NSLog(@"Product Array: %@, result: %@", arr0, [self productArrayWithSource:arr0]);
    
    //2. Number First testing
    NSArray *arr1 = @[@0, @1, @0, @3, @12];
    NSLog(@"Number First: %@, result: %@", arr1, [self NumberFirstWithSource:arr1]);
    
    //3. Game of life testing
    NSMutableArray *arr = [self randomBoardForGameOfLife];
    NSLog(@"Game of life original random board: %@", arr);
    [self gameOfLifeWithBoard:arr];
    NSLog(@"Game of life board after next generation: %@", arr);
    
    //4. Simple root square testing
    int calValue = 4;
    NSLog(@"Simple root square: %d, result: %d", calValue, [self sqrtCalculate:calValue]);
    
    //5. Power testing
    double x = 2;
    int    y = 8;
    NSLog(@"Power value with x: %lf, with y: %d, result: %lf", x, y, [self powerWithValue:x factorial:y]);
}

#pragma mark - Test Answers

//1. Product Array implementation
- (NSMutableArray *)productArrayWithSource:(NSArray *)sources {
    
    NSMutableArray *products = [@[@1] mutableCopy];
    int interval = 1;
    
    for (int i = 1; i < sources.count; i ++) {
        
        [products insertObject:[NSNumber numberWithInteger: ([products[i - 1] integerValue] * [sources[i - 1] integerValue]) ] atIndex:i];
    }
    
    for (int i = (int)sources.count - 2; i >= 0; i--) {
        interval   *= [sources[i + 1] integerValue];
        products[i] = [NSNumber numberWithInteger:interval * [products[i] integerValue]];
    }
    return products;
}

//2. Number First implementation
- (NSMutableArray *)NumberFirstWithSource:(NSArray *)sources {
    
    NSMutableArray *numberFirsts = [NSMutableArray new];
    int zeroCount = 0;
    for (int i  = 0; i < sources.count; i ++) {
        int number = [sources[i] intValue];
        if (number == 0) {
            zeroCount ++;
        }
        else {
            [numberFirsts addObject: [NSNumber numberWithInt:number]];
        }
    }
    for (int j = (int)numberFirsts.count; j < (int)sources.count; j ++) {
        [numberFirsts addObject:[NSNumber numberWithInt:0]];
    }
    return numberFirsts;
}

//3. Game Of Life implementation
- (void)gameOfLifeWithBoard:(NSMutableArray *)board
{
    //cell value explaination
    //cell value 0: dead to dead
    //cell value 1: live to live
    //cell value 2: live to dead
    //cell value 3: dead to live
    
    NSUInteger lines = board.count;
    NSUInteger columes = [[board objectAtIndex:0] count];
    
    //assign board cells value
    for(int i = 0; i < lines; i++) {
        for(int j = 0; j < columes; j++) {
            int liveCells = [self detectLiveCellsWithBoard:board lines:(int)lines columes:(int)columes positionX:i positionY:j];
            
            //live cell with fewer than two live neighbors dies
            //live cell with more than three live neighbors dies
            if([board[i][j] intValue] == 1 && (liveCells < 2 || liveCells > 3) ) {
                board[i][j] = @2;
            }
            //Any dead cell with exactly three live neighbors becomes a live cell
            if([board[i][j] intValue] == 0  && liveCells == 3) {
                board[i][j] = @3;
            }
        }
    }
    
    //update board cells state in-place, at the same time
    //transfer board cells value to cell state --- live (1) or dead (0)
    for (int i = 0; i < lines; ++i) {
        for (int j = 0; j < columes; ++j) {
            board[i][j] = [NSNumber numberWithInt:[board[i][j] intValue] % 2];
        }
    }
}

//detect how many live cells around target cell on position (x, y)
- (int)detectLiveCellsWithBoard:(NSMutableArray *)board lines:(int)lines columes:(int)columes positionX:(int)x positionY:(int)y {
    
    int liveCells = 0;
    
    //solve the board size border problem before cycling / detect live cell
    int initIndexX  = (((x - 1) >= 0)      ? (x - 1) : 0);
    int linesCount  = (((x + 1) < lines)   ? (x + 1) : x);
    int initIndexY  = (((y - 1) >= 0)      ? (y - 1) : 0);
    int columesCount= (((y + 1) < columes) ? (y + 1) : y);
    
    // start to cycling to canculate how many live cells around position(x, y) cell
    // then return the live cell count
    for (int i = initIndexX; i <= linesCount; i++) {
        for (int j = initIndexY; j <= columesCount; j++) {
            
            if (!((i == x) && (j == y))) {
                
                int neighborOriginState = [board[i][j] intValue];
                
                if ([board[i][j] intValue] == 2) {
                    neighborOriginState = 1;
                }
                
                else if ([board[i][j] intValue] == 3) {
                    neighborOriginState = 0;
                }
                
                if (neighborOriginState == 1) {
                    liveCells++;
                }
            }
        }
    }
    return liveCells;
}

//4. Simple root square implementation
- (int)sqrtCalculate:(int) x{
    
    double result = (double)x;
    
    while (ABS(result * result - x) > 0.000001) {
        result = ( result + x / result) / 2;
    }
    
    return (int)result;
}

//5. Power implementation
- (double)powerWithValue:(double)x factorial:(int)n
{
    if(n==0)
        return 1.0;
    
    else if(n<0)
        return 1.0/[self powerWithValue:x factorial:-n];
    
    else return x * [self powerWithValue:x factorial:n - 1];
}

#pragma mark - Testing Methods

- (NSMutableArray *)randomBoardForGameOfLife {
    
    //create a random board under 6 * 6 limit (u can set any board size by changing below divided number)
    int lines  = arc4random() % 6 + 1;
    int columes = arc4random() % 6 + 1;
    
    NSMutableArray *arr = [NSMutableArray new];
    for (int i = 0; i < lines; i ++) {
        NSMutableArray *arrElement = [NSMutableArray new];
        for (int j = 0; j < columes; j ++) {
            [arrElement addObject:[NSNumber numberWithInt:arc4random() % 2]];
        }
        [arr addObject:arrElement];
    }
    return arr;
}
@end


