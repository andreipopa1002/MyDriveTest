//
//  ViewController.m
//  MyDriveTest
//
//  Created by Popa Andrei on 31/05/2015.
//  Copyright (c) 2015 Popa Andrei. All rights reserved.
//

#import "ViewController.h"
#import "MDDataSource.h"

@interface ViewController () <UIPickerViewDelegate>

@property (nonatomic, weak, readwrite) IBOutlet UIPickerView *fromPicker;
@property (nonatomic, weak, readwrite) IBOutlet UIPickerView *toPicker;
@property (nonatomic, weak, readwrite) IBOutlet UITextField *amountTextField;
@property (nonatomic, weak, readwrite) IBOutlet UIButton *calculateConversionButton;
@property (nonatomic, weak, readwrite) IBOutlet UILabel *resultLabel;

@property (nonatomic, strong, readwrite) MDDataSource *dataSource;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showLoadingIndicator];

    typeof(self) __weak weakSelf = self;
    self.dataSource = [MDDataSource dataSourceWithCompletion:^{
        [weakSelf hideLoadingIndicator];
        weakSelf.fromPicker.dataSource = weakSelf.dataSource;
        weakSelf.fromPicker.delegate = weakSelf.dataSource;
        weakSelf.toPicker.dataSource = weakSelf.dataSource;
        weakSelf.toPicker.delegate = weakSelf.dataSource;
        [weakSelf.fromPicker reloadAllComponents];
        [weakSelf.toPicker reloadAllComponents];
    }];
}

- (IBAction)calculateButtonTapped:(id)sender {
    NSString *fromCurrencyString = [self.dataSource currencyStringForPicker:self.fromPicker];
    NSString *toCurrencyString = [self.dataSource currencyStringForPicker:self.toPicker];
    CGFloat amount = [self.amountTextField.text floatValue];
    [self showLoadingIndicator];
    typeof(self) __weak weakSelf = self;
    [self.dataSource convertAmount:amount fromCurrency:fromCurrencyString toCurrency:toCurrencyString withCompletion:^(CGFloat result, NSError *error) {
        [weakSelf hideLoadingIndicator];
        weakSelf.resultLabel.text = [NSString stringWithFormat:@"%f %@ = %f %@",amount,fromCurrencyString,result,toCurrencyString];
    }];

    
}

@end
