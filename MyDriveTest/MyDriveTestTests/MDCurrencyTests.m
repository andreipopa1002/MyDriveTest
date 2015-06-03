//
//  MDCurrencyTests.m
//  MyDriveTest
//
//  Created by Popa Andrei on 03/06/2015.
//  Copyright (c) 2015 Popa Andrei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "MDCurrency.h"

@interface MDCurrencyTests : XCTestCase

@property (nonatomic, strong, readwrite) MDCurrency *currency;

@end

@implementation MDCurrencyTests

- (void)setUp {
    [super setUp];
    self.currency = [MDCurrency currencyWithConversionDictionary:@{@"from": @"USD",
                                                                   @"to": @"GBP",
                                                                   @"rate": @(0.66)}];
}

- (void)testCurrencyObjectExistence {
    XCTAssert(self.currency != nil, @"Pass");
}

- (void)testCurrencyCurrencyString {
    XCTAssert([self.currency.currencyString isEqualToString:@"USD"],@"Pass");
}

- (void)testCurrencyCurrenciesList {
    XCTAssert(self.currency.conversions.count == 1, @"Pass");
}

- (void)testCurrencuStringFromConversionDictionary {
    NSDictionary *conversionDictionary = @{@"from": @"USD",
                                           @"to": @"GBP",
                                           @"rate": @(0.66)};
    XCTAssert([[MDCurrency currecyStringFromDictionary:conversionDictionary] isEqualToString:@"USD"], @"Pass");
}

- (void)testAddConversionFromDictionary {
    NSDictionary *conversionDictionary = @{@"from": @"USD",
                                           @"to": @"EUR",
                                           @"rate": @(0.52)};
    [self.currency addConversionFromDictionary:conversionDictionary];
    XCTAssert(self.currency.conversions.count == 2, @"Pass");
}

@end
