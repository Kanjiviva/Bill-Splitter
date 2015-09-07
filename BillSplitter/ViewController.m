//
//  ViewController.m
//  BillSplitter
//
//  Created by Steve on 2015-09-06.
//  Copyright (c) 2015 Steve. All rights reserved.
//

#import "ViewController.h"
#import "TipOptionViewController.h"

@interface ViewController () <TipOptionViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UISlider *splitSlider;
@property (weak, nonatomic) IBOutlet UILabel *lblDisplayAmount;
@property (weak, nonatomic) IBOutlet UITextField *totalTextField;

- (IBAction)btnCalculateSplitAmount:(id)sender;
- (IBAction)actionSplitSlider:(id)sender;

@property (strong, nonatomic) NSString *getDelegateTips;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupDelegate];
    
}

-(void)viewDidAppear:(BOOL)animated {
    [self setupDelegate];
}

#pragma mark - Helper methods

- (float)calculateSplitBillsAmount {
    
//    return [self.totalTextField.text floatValue] / self.splitSlider.value;
    return ([self.totalTextField.text floatValue] + [self.totalTextField.text floatValue] * ([self.getDelegateTips floatValue] / 100)) / round(self.splitSlider.value);
    
}

- (void)roundSliderValue {
    
    self.splitSlider.value = round(self.splitSlider.value);


}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"showTip"]) {
        
        TipOptionViewController *tipOptionVC = segue.destinationViewController;
        
        tipOptionVC.delegate = self;
        
    }
    
    
}

#pragma mark - Delegate method

- (void)tipsPercentage:(NSString *)tips {
    
    self.getDelegateTips = tips;
    
    float result = ([self.totalTextField.text floatValue] + [self.totalTextField.text floatValue] * ([tips floatValue] / 100)) / self.splitSlider.value;
    
    self.lblDisplayAmount.text = [NSString stringWithFormat:@"%0.2f", result];
    
}

- (void)setupDelegate {
    [self.splitSlider addTarget:self
                         action:@selector(roundSliderValue)
               forControlEvents:UIControlEventValueChanged];
}

#pragma mark - IBActions

- (IBAction)btnCalculateSplitAmount:(id)sender {
    
    self.lblDisplayAmount.text = [NSString stringWithFormat:@"%0.2f", [self calculateSplitBillsAmount]];

}

- (IBAction)actionSplitSlider:(id)sender {
    
    UIImageView *handleView = [_splitSlider.subviews lastObject];

    UILabel *label = (UILabel*)[handleView viewWithTag:1000];

    if (label==nil) {
        
        label = [[UILabel alloc] initWithFrame:handleView.bounds];
        
        label.tag = 1000;
        
        label.backgroundColor = [UIColor clearColor];
        
        label.textAlignment = NSTextAlignmentCenter;
        
        [handleView addSubview:label];
        
        
    }

    label.text = [NSString stringWithFormat:@"%.0f", self.splitSlider.value];
    
    float result = [self calculateSplitBillsAmount];
    
    self.lblDisplayAmount.text = [NSString stringWithFormat:@"%.2f", result];
    
    

}
@end
