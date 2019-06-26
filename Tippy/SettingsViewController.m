//
//  SettingsViewController.m
//  Tippy
//
//  Created by emily13hsiao on 6/25/19.
//  Copyright © 2019 emily13hsiao. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *defaultPercent;

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //Load default tip.
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    double doubleValue = [defaults doubleForKey:@"default_tip_percentage"];
    
    int tip_index;
    if (doubleValue == 0.15) {
        tip_index = 0;
    } else if (doubleValue == 0.18){
        tip_index = 1;
    } else {
        tip_index = 2;
    }
    
    [self.defaultPercent setSelectedSegmentIndex:tip_index];
}

//Update default setting upon change.
- (IBAction)updateDefaltTipPercentage:(id)sender {
    
    NSArray *percentages = @[@(0.15), @(0.18), @(0.20)];
    double tipPercentage = [percentages[self.defaultPercent.selectedSegmentIndex] doubleValue];
    
    NSLog(@"%f", tipPercentage);
    NSUserDefaults *defaultPercent = [NSUserDefaults standardUserDefaults];
    [defaultPercent setDouble:tipPercentage forKey:@"default_tip_percentage"];
    [defaultPercent synchronize];
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
