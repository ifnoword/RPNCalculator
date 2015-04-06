//
//  CalculatorBrain.h
//  Caculator
//
//  Created by MEI C on 2/2/14.
//  Copyright (c) 2014 MEI C. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject

- (void) pushOperand:(double)operand;
- (double) performOpretaion:(NSString *)operation;
- (void) clearStack;
@end
