//
//  TipOptionViewController.m
//  BillSplitter
//
//  Created by Steve on 2015-09-06.
//  Copyright (c) 2015 Steve. All rights reserved.
//

#import "TipOptionViewController.h"

@interface TipOptionViewController ()
@property (weak, nonatomic) IBOutlet UITextField *txtTipPercent;
@property (weak, nonatomic) IBOutlet UISlider *tipPercentSliderOutlet;
- (IBAction)returnBtn:(id)sender;
- (IBAction)tipPercentageSlider:(id)sender;

@end

@implementation TipOptionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tipPercentSliderOutlet addTarget:self
                              action:@selector(roundSliderValue)
                    forControlEvents:UIControlEventEditingChanged];
    
    [self.txtTipPercent addTarget:self
                           action:@selector(tipTextDidChange)
                 forControlEvents:UIControlEventEditingChanged];
    
//    self.tipPercentSliderOutlet.continuous = YES;
    
}

#pragma mark - Helper methods

- (void)roundSliderValue {
    self.tipPercentSliderOutlet.value = round(self.tipPercentSliderOutlet.value);
}

- (void)tipTextDidChange {
    self.tipPercentSliderOutlet.value = [self.txtTipPercent.text intValue];
}

#pragma mark - IBActions

- (IBAction)returnBtn:(id)sender {
    
    [self.delegate tipsPercentage:self.txtTipPercent.text];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (IBAction)tipPercentageSlider:(id)sender {
    
    self.txtTipPercent.text = [NSString stringWithFormat:@"%0.0f", self.tipPercentSliderOutlet.value];
    
    UIImageView *handleView = [_tipPercentSliderOutlet.subviews lastObject];
    
    UILabel *label = (UILabel*)[handleView viewWithTag:1000];
    
    if (label==nil) {
        
        label = [[UILabel alloc] initWithFrame:handleView.bounds];
        
        label.tag = 1000;
        
        label.backgroundColor = [UIColor clearColor];
        
        label.textAlignment = NSTextAlignmentCenter;
        
        [handleView addSubview:label];
        
        
    }
    
    label.text = [NSString stringWithFormat:@"%0.0f", self.tipPercentSliderOutlet.value];
    
}
@end
