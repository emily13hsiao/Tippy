//
//  ViewController.m
//  Tippy
//
//  Created by emily13hsiao on 6/25/19.
//  Copyright © 2019 emily13hsiao. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *mealbillField;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tipControl;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //Load default tip.
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    double doubleValue = [defaults doubleForKey:@"default_tip_percentage"];
    
    NSLog(@"Default: %0.2f", doubleValue);
    
    int tip_index;
    if (doubleValue == 0.15) {
        tip_index = 0;
    } else if (doubleValue == 0.18){
        tip_index = 1;
    } else {
        tip_index = 2;
    }
    
    [self.tipControl setSelectedSegmentIndex:tip_index];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    NSLog(@"View did appear");
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    NSLog(@"View will disappear");
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    NSLog(@"View did disappear");
}

//Removes keyboard when tapping elsewhere.
- (IBAction)onTap:(id)sender {
    NSLog(@"Hello");
    [self.view endEditing:YES];
}

//Recalculates tip and total fields when parameters are edited.
- (IBAction)onEdit:(id)sender {
    
    double bill = [self.mealbillField.text doubleValue];
    
    NSArray *percentages = @[@(0.15), @(0.18), @(0.20)];
    double tipPercentage = [percentages[self.tipControl.selectedSegmentIndex] doubleValue];
    
    double tip = tipPercentage * bill;
    double total = bill + tip;
    
    self.tipLabel.text = [NSString stringWithFormat:@"$%0.2f", tip];
    self.totalLabel.text = [NSString stringWithFormat:@"$%0.2f", total];
}

//Animations upon begin edit billfield.
- (IBAction)onEditingBegin:(id)sender {
    
    [UIView animateWithDuration:0.2 animations:^{
        self.mealbillField.frame = CGRectMake(self.mealbillField.frame.origin.x, self.mealbillField.frame.origin.y + 30, self.mealbillField.frame.size.width, self.mealbillField.frame.size.height);
        self.tipLabel.alpha = 0;
    }];
}
    

//Return billfield to default after edit.
- (IBAction)onEditingEnd:(id)sender {
    CGRect newFrame = self.mealbillField.frame;
    newFrame.origin.y -= 30;
    
    [UIView animateWithDuration:0.2 animations:^{
        self.mealbillField.frame = newFrame;
        self.tipLabel.alpha = 1;
    }];
    self.mealbillField.frame = newFrame;
    
}

@end
