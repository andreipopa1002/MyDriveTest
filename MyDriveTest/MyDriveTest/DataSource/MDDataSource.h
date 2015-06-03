//
//  MDDataSource.h
//  MyDriveTest
//
//  Created by Popa Andrei on 01/06/2015.
//  Copyright (c) 2015 Popa Andrei. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

@interface MDDataSource : NSObject <UIPickerViewDataSource, UIPickerViewDelegate>
@property (nonatomic, strong, readonly) NSArray *curreciesObjects;

+ (instancetype)dataSourceWithCompletion:(void(^)(void))completionBlock;
- (void)convertAmount:(CGFloat)amount fromCurrency:(NSString *)fromCurrencyString toCurrency:(NSString*)toCurrencyString withCompletion:(void(^)(CGFloat result, NSError *error))completionBlock;
- (NSString *)currencyStringForPicker:(UIPickerView *)picker;

@end
