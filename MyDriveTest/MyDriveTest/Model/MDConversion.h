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
/**
 *  creates and populates a new instance of the MDConversion object
 *
 *  @param conversionDictionary received from the API
 *
 *  @return MDConversion object prepopulated with the data received from the API
 */
+ (instancetype)conversionFromConversionDictionary:(NSDictionary *)conversionDictionary;

@end
