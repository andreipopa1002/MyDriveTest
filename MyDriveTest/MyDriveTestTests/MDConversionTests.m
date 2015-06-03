//
//  MDConversionTests.m
//  MyDriveTest
//
//  Created by Popa Andrei on 03/06/2015.
//  Copyright (c) 2015 Popa Andrei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "MDConversion.h"

@interface MDConversionTests : XCTestCase

@property (nonatomic, strong, readwrite) MDConversion *conversion;

@end

@implementation MDConversionTests

- (void)setUp {
    [super setUp];
    self.conversion = [MDConversion conversionFromConversionDictionary:@{@"from": @"USD",
                                                                         @"to": @"EUR",
                                                                         @"rate": @(0.52)}];
}

- (void)testConversionObjectValidity {
    XCTAssert(self.conversion != nil, @"Pass");
}

- (void)testConversionToCurrencyStringProperty {
    XCTAssert([self.conversion.toCurrencyString isEqualToString:@"EUR"], @"Pass");
}

- (void)testConversionConversionRate {
    XCTAssert(self.conversion.conversionRate == [@(0.52) floatValue], @"Pass");
}

@end
