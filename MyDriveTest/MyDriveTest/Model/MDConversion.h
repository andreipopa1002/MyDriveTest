//
//  MDConversion.h
//  MyDriveTest
//
//  Created by Popa Andrei on 31/05/2015.
//  Copyright (c) 2015 Popa Andrei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MDCurrency.h"

@interface MDConversion : NSObject

@property (nonatomic, copy, readonly) NSString *toCurrencyString;
@property (nonatomic, assign, readonly) float conversionRate;

+ (instancetype)conversionFromConversionDictionary:(NSDictionary *)conversionDictionary;

@end
