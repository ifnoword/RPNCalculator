//
//  CalculatorBrain.m
//  Caculator
//
//  Created by MEI C on 2/2/14.
//  Copyright (c) 2014 MEI C. All rights reserved.
//

#import "CalculatorBrain.h"
@interface CalculatorBrain()
@property(nonatomic, strong) NSMutableArray *operandStack;
@end

@implementation CalculatorBrain
- (NSMutableArray *) operandStack{
    if(!_operandStack){
        _operandStack = [[NSMutableArray alloc] init];
    }
    return _operandStack;
}

- (void) clearStack{
    _operandStack = Nil;
    NSLog(@"stack is cleared");
}

- (void) pushOperand:(double)operand{
    
    [self.operandStack addObject:[NSNumber numberWithDouble:operand]];
    NSLog(@"Push! Stack is %@", _operandStack);

}
- (double) popOperand{
    NSNumber *operandOb = [self.operandStack lastObject];
    if (operandOb) {
        [self.operandStack removeLastObject];
    }
    return [operandOb doubleValue];

}

- (double) performOpretaion:(NSString *)operation{
    double result = 0;
    if ([operation isEqualToString:@"+"]) {
        result = [self popOperand]+[self popOperand];
    }
    else if ([operation isEqualToString:@"-"]){
        double subtrahend = [self popOperand];
        result = [self popOperand]- subtrahend;
    }
    else if ([operation isEqualToString:@"*"]){
        result = [self popOperand]*[self popOperand];
        
    }
    else if ([operation isEqualToString:@"/"]){
        double devisor = [self popOperand];
        if (devisor == 0) {
            NSException *ex= [[NSException alloc] initWithName:@"inValidDevisor" reason:@"devisor is 0" userInfo:nil];
            @throw(ex);
        }
        result = [self popOperand]/devisor;
    }
    else if ([operation isEqualToString:@"sin"]){
        result = sin([self popOperand]*M_PI/180);

    }
    else if ([operation isEqualToString:@"cos"]){
        result = cos([self popOperand]*M_PI/180);
    }
    else if ([operation isEqualToString:@"sqrt"]){
        result = sqrt([self popOperand]);
    }
    else if ([operation isEqualToString:@"log"]){
        result = log([self popOperand]);
    }
    else if ([operation isEqualToString:@"π"]){
        result = M_PI;
    }
    else {
        result = M_E;
    }
    [self pushOperand:result];
    //NSLog(@"%@! Stack is %@", operation, _operandStack);
    return result;
}
@end
