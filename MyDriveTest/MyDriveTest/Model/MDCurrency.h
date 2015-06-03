//
//  MDCurrency.h
//  MyDriveTest
//
//  Created by Popa Andrei on 31/05/2015.
//  Copyright (c) 2015 Popa Andrei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MDConversion.h"
/**
 *  This class will encapsulate one currency and all the possible conversions
 */
@interface MDCurrency : NSObject

@property (nonatomic, strong, readonly) NSString *currencyString;
@property (nonatomic, strong, readonly) NSArray *conversions;
/**
 *  creates a new MDCurrency object
 *
 *  @param conversionDictionary NSDictionary that represents one conversion
 *
 *  @return MDCurrency object with one conversion in the conversions object
 */
+ (instancetype)currencyWithConversionDictionary:(NSDictionary *)conversionDictionary;
/**
 *  Returns the TO currency string from a conversion dictionary
 *
 *  @param conversionDictionary NSDictionary received from the API
 *
 *  @return NSString representing the currency from which we are converting
 */
+ (NSString *)currecyStringFromDictionary:(NSDictionary *)conversionDictionary;
/**
 *  creates the reversed conversion dictinary from one conversion dictionary
 *
 *  @param conversionDictionary initial conversion dictionary, received from the API
 *
 *  @return NSDictionary containing the reversed conversion
 */
+ (NSDictionary *)reverserdConversionDictionaryFromConversionDictionary:(NSDictionary *)conversionDictionary;
/**
 *  Adds one conversion to the conversion array
 *
 *  @param conversionDictionary conversion dictionary received from the API
 */
- (void)addConversionFromDictionary:(NSDictionary *)conversionDictionary;

@end
