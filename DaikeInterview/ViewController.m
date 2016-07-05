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
    
    //1. Product Array result
    NSArray *arr0 = @[@1, @2, @3, @4];
    NSLog(@"Product Array: %@, result: %@", arr0, [self productArrayWithSource:arr0]);
    
    //2. Number First result
    NSArray *arr1 = @[@0, @1, @0, @3, @12];
    NSLog(@"Number First: %@, result: %@", arr1, [self NumberFirstWithSource:arr1]);
    
    //4. Simple root square
    int calValue = 4;
    NSLog(@"Simple root square: %d, result: %d", calValue, [self sqrtCalculate:calValue]);
    
    //5. Power
    double x = 2;
    int    y = 8;
    NSLog(@"Power value with x: %lf, with y: %d, result: %lf", x, y, [self powerWithValue:x factorial:y]);
}

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

@end


