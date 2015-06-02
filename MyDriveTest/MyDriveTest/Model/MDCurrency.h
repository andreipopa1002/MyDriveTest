//
//  MDCurrency.h
//  MyDriveTest
//
//  Created by Popa Andrei on 31/05/2015.
//  Copyright (c) 2015 Popa Andrei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MDConversion.h"

@interface MDCurrency : NSObject

@property (nonatomic, strong, readonly) NSString *currencyString;
@property (nonatomic, strong, readonly) NSArray *conversions;

+ (instancetype)currencyWithConversionDictionary:(NSDictionary *)conversionDictionary;
+ (NSString *)fromCurrecyFromDictionary:(NSDictionary *)conversionDictionary;
+ (NSDictionary *)reverserdConversionFromConversionDictionary:(NSDictionary *)conversionDictionary;

- (void)addConversionFromDictionary:(NSDictionary *)conversionDictionary;

@end
