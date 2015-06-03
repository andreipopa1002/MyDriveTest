//
//  MDDataSource.m
//  MyDriveTest
//
//  Created by Popa Andrei on 01/06/2015.
//  Copyright (c) 2015 Popa Andrei. All rights reserved.
//

#import "MDDataSource.h"
#import "MDApiClient.h"
#import "MDConversion.h"

@interface MDDataSource()

@property (nonatomic, copy, readwrite) void(^completionBlock)(void);
@property (nonatomic, strong, readwrite) NSArray *curreciesObjects;
@property (nonatomic, strong, readwrite) NSMutableArray *currenciesConversionPath;

@end

@implementation MDDataSource

+ (instancetype)dataSourceWithCompletion:(void(^)(void))completionBlock {
    MDDataSource *dataSource = [MDDataSource new];
    [dataSource startFetchingData];
    dataSource.completionBlock = completionBlock;
    return dataSource;
}

- (NSString *)currencyStringForPicker:(UIPickerView *)picker {
    return [(MDCurrency *)self.curreciesObjects[[picker selectedRowInComponent:0]] currencyString];
}

- (void)convertAmount:(CGFloat)amount fromCurrency:(NSString *)fromCurrencyString toCurrency:(NSString*)toCurrencyString withCompletion:(void(^)(CGFloat result, NSError *error))completionBlock {
    if ([fromCurrencyString isEqualToString:toCurrencyString]) {
        completionBlock(amount,nil);
    } else {
        self.currenciesConversionPath = [NSMutableArray new];
        [self computePathForCurrencyString:fromCurrencyString toDestination:toCurrencyString];
        if ([[self.currenciesConversionPath.lastObject currencyString] isEqualToString:toCurrencyString]) {
            completionBlock([self convertAmount:amount accordingToPath:self.currenciesConversionPath], nil);
            self.currenciesConversionPath = nil;
        } else {
            completionBlock(0, [NSError errorWithDomain:@"Impossible conversion" code:100 userInfo:nil]);
        }
    }
}

# pragma mark - Internal Methods
- (void)computePathForCurrencyString:(NSString *)currencyString toDestination:(NSString *)toCurrency {
    MDCurrency *currencyObject = [self getCurrencyObjectForCurrencyString:currencyString];

    if (![self pathContainsCurrency:currencyObject]) {
        [self.currenciesConversionPath addObject:currencyObject];
        NSLog(@"# %@",self.currenciesConversionPath);
        if (![currencyObject.currencyString isEqualToString:toCurrency]) {
            
            int addedObjects = 0;
            for (MDConversion *conversionObject in currencyObject.conversions) {
                if (![[self.currenciesConversionPath.lastObject currencyString] isEqualToString:toCurrency]) {
                    MDCurrency *nextCurrency = [self getCurrencyObjectForCurrencyString:conversionObject.toCurrencyString];
                    if (![self pathContainsCurrency:nextCurrency]) {
                        addedObjects++;
                        [self computePathForCurrencyString:conversionObject.toCurrencyString toDestination:toCurrency];
                    }
                } else {
                    break;
                }
            }

            if (addedObjects == 0 && currencyObject.conversions.count >=2) {
                [self.currenciesConversionPath removeLastObject];
                [self.currenciesConversionPath removeLastObject];
            } else if (addedObjects == 0){
                [self.currenciesConversionPath removeLastObject];
            }
        }
    }
}

- (MDCurrency *)getCurrencyObjectForCurrencyString:(NSString *)currencyString {
    MDCurrency *foundCurrencyObject = nil;
    for (MDCurrency *currencyObject in self.curreciesObjects) {
        if ([currencyObject.currencyString isEqualToString:currencyString]) {
            foundCurrencyObject = currencyObject;
            break;
        }
    }
    return foundCurrencyObject;
}

- (BOOL)pathContainsCurrency:(MDCurrency *)currency {
    BOOL found = NO;
    for (MDCurrency *currencyObject in self.currenciesConversionPath) {
        if (currencyObject == currency) {
            found = YES;
            break;
        }
    }
    return found;
}

- (void)startFetchingData {
    typeof(self) __weak weakSelf = self;
    [[MDApiClient sharedClient] retrieveConversionsList:^(NSArray *currencyArray) {
        NSMutableArray *currenciesModels = [NSMutableArray arrayWithArray:weakSelf.curreciesObjects];
        
        for (NSDictionary *conversionDictionary in currencyArray) {
            [weakSelf addCurrencyToCurrencyArray:currenciesModels fromConversionDictionary:conversionDictionary];
            [weakSelf addCurrencyToCurrencyArray:currenciesModels fromConversionDictionary:[MDCurrency reverserdConversionDictionaryFromConversionDictionary:conversionDictionary]];
        }
        [currenciesModels sortUsingComparator:^NSComparisonResult(MDCurrency *obj1, MDCurrency *obj2) {
            return [obj1.currencyString compare:obj2.currencyString];
        }];
        weakSelf.curreciesObjects = [NSArray arrayWithArray:currenciesModels];
        if (weakSelf.completionBlock) {
            weakSelf.completionBlock();
        }
    }];
}

- (void)addCurrencyToCurrencyArray:(NSMutableArray *)currenciesModels fromConversionDictionary:(NSDictionary *)conversionDictionary {
    MDCurrency *foundCurrency = nil;
    for (MDCurrency *currency in currenciesModels) {
        NSString *fromCurrencyString = [MDCurrency currecyStringFromDictionary:conversionDictionary];
        if ([currency.currencyString isEqualToString:fromCurrencyString]) {
            foundCurrency = currency;
            break;
        }
    }
    if (foundCurrency == nil) {
        foundCurrency = [MDCurrency currencyWithConversionDictionary:conversionDictionary];
        [currenciesModels addObject:foundCurrency];
    } else {
        [foundCurrency addConversionFromDictionary:conversionDictionary];
    }
    
}

- (CGFloat)convertAmount:(CGFloat)amount accordingToPath:(NSArray *)conversionPath {
    for (int i = 0; i < conversionPath.count - 1; i++) {
        MDCurrency *currency = conversionPath[i];
        MDCurrency *nextCurrencyInPath = conversionPath[i+1];
        for (MDConversion *conversion in currency.conversions) {
            if ([conversion.toCurrencyString isEqualToString:nextCurrencyInPath.currencyString]) {
                amount = amount * conversion.conversionRate;
                break;
            }
        }
    }
    return amount;
}

# pragma mark - UIPickerViewDataSource methods
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.curreciesObjects.count;
}

# pragma mark - UIPickerDelegate Methods
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [(MDCurrency *)self.curreciesObjects[row] currencyString];
}

@end
