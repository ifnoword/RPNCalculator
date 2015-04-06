//
//  CalculatorViewController.m
//  Caculator
//
//  Created by MEI C on 2/2/14.
//  Copyright (c) 2014 MEI C. All rights reserved.
//

#import "CalculatorViewController.h"
#import "CalculatorBrain.h"

@interface CalculatorViewController ()//public property in header.
    // private here.
@property (nonatomic) BOOL inTheMiddleOfEnterNum;
@property (nonatomic) BOOL previousPressOnPiorE;
@property (nonatomic, strong) CalculatorBrain *brain;

@end

@implementation CalculatorViewController

-(CalculatorBrain *) brain {
    if (!_brain) {
        _brain = [[CalculatorBrain alloc] init];
    }
    return _brain;
}
- (void) updateMiniDislayWith:(NSString *)oprand{
    self.miniDisplay.text= [self.miniDisplay.text stringByReplacingOccurrencesOfString:@"=" withString:[oprand stringByAppendingString:@" ="]];
}
- (IBAction)signChangedPressed {
    if (self.inTheMiddleOfEnterNum) {
        if ([self.signDisplay.text isEqualToString:@"-"]) {
            self.signDisplay.text = @"";
        }
        else{
            self.signDisplay.text = @"-";
        }
            
    }

}

- (IBAction)digitPressed:(id)sender {
    NSString *digit =[(UIButton*)sender currentTitle];
    NSLog(@"user touched %@, color %@", digit, self.pointBtn.backgroundColor);
    if ([digit isEqualToString:@"."]) {
        self.pointBtn.enabled = NO;
        NSLog(@".is disabled");
    }

    if (self.inTheMiddleOfEnterNum){
        self.display.text = [self.display.text stringByAppendingString:digit];
    }
    else{
        self.display.text = digit;
        self.inTheMiddleOfEnterNum = YES;
    
    }
    self.previousPressOnPiorE = NO;
}
- (IBAction)enterPressed {
    [self updateMiniDislayWith:[self.signDisplay.text stringByAppendingString:self.display.text]];
    
    if (!self.previousPressOnPiorE) {
        double valueFromDisplay = [[@"0" stringByAppendingString:self.display.text] doubleValue];
        if ([self.signDisplay.text isEqualToString:@"-"]) {
            valueFromDisplay = -valueFromDisplay;
            self.signDisplay.text = @"";
        }
        
        [self.brain pushOperand:valueFromDisplay];

        self.display.text = @"0";
        self.inTheMiddleOfEnterNum = NO;
        self.pointBtn.enabled = YES;
        NSLog(@".is enabled");
    }
}
- (IBAction)clearPressed {
    [self.brain clearStack];
    self.miniDisplay.text = @"=";
    self.display.text = @"0";
    self.inTheMiddleOfEnterNum = NO;
    self.pointBtn.enabled = YES;
    self.previousPressOnPiorE = NO;
    self.signDisplay.text=@"";
    
}
- (IBAction)backPressed {
    NSInteger len = self.display.text.length;
    NSLog(@"LEN= %d", len);
    if (len == 1) {
        if (![self.display.text isEqualToString:@"."]) {
            self.pointBtn.enabled = YES;
        }
        self.display.text=@"0";
        self.inTheMiddleOfEnterNum = NO;
    } else {
        self.display.text = [self.display.text substringToIndex:(len-1)];
    }
    self.previousPressOnPiorE = NO;
}

- (IBAction)operationPressed:(id)sender {
    NSString *opreration =[(UIButton *)sender currentTitle];
    NSLog(@"%@ is pressed", opreration);
    if (self.inTheMiddleOfEnterNum) {
        [self updateMiniDislayWith:[self.signDisplay.text stringByAppendingString:self.display.text]];
        double valueFromDisplay = [[@"0" stringByAppendingString:self.display.text] doubleValue];
        if ([self.signDisplay.text isEqualToString:@"-"]) {
            valueFromDisplay = -valueFromDisplay;
            self.signDisplay.text = @"";
        }
        [self.brain pushOperand:valueFromDisplay];
        self.inTheMiddleOfEnterNum = NO;
        NSLog(@"User doesn't press enter before OP");
    }
    
    double result =0;
    
    @try {
        result = [self.brain performOpretaion:opreration];
    }
    @catch (NSException *exception) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:exception.name message:exception.reason delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];//
    }
    
    [self updateMiniDislayWith:opreration];
    self.pointBtn.enabled = YES;
    NSLog(@".is disabled");
    
    if (![opreration isEqualToString:@"π"] && ![opreration isEqualToString:@"e"]) {
        NSLog(@"result %f is returned", result);
        self.display.text=[NSString stringWithFormat:@"%g", result];
        self.previousPressOnPiorE = NO;
    }
    else{
        self.previousPressOnPiorE = YES;
    }

}

/*


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
*/
@end
