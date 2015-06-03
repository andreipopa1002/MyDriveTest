//
//  MDDataSource.h
//  MyDriveTest
//
//  Created by Popa Andrei on 01/06/2015.
//  Copyright (c) 2015 Popa Andrei. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;
/**
 *  This Class will represent the datasource for the UI elements from the view Controller
 *  it will fetch the date and manipulate it
 */

@interface MDDataSource : NSObject <UIPickerViewDataSource, UIPickerViewDelegate>
@property (nonatomic, strong, readonly) NSArray *curreciesObjects;
/**
 *  Creates a new MDDataSource and starts to fetch the data
 *
 *  @param completionBlock block that will be executed once the data is prepared to be displayed
 *
 *  @return MDDataSource new instance
 */
+ (instancetype)dataSourceWithCompletion:(void(^)(void))completionBlock;
/**
 *  will be called by the owner to find out a specific conversion
 *
 *  @param amount             amount of money that needs to be converted
 *  @param fromCurrencyString the currency that the user has the money
 *  @param toCurrencyString   destinatino currency
 *  @param completionBlock    block to be executed when the work is done and we have a conversion
 */
- (void)convertAmount:(CGFloat)amount fromCurrency:(NSString *)fromCurrencyString toCurrency:(NSString*)toCurrencyString withCompletion:(void(^)(CGFloat result, NSError *error))completionBlock;
/**
 *  returns the string for the selected currency inside the UIPickerView
 *
 *  @param picker UIPickerView that presented the currencies
 *
 *  @return NSString representing the selected currency
 */
- (NSString *)currencyStringForPicker:(UIPickerView *)picker;

@end
