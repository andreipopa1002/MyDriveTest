//
//  MDCurrency.m
//  MyDriveTest
//
//  Created by Popa Andrei on 31/05/2015.
//  Copyright (c) 2015 Popa Andrei. All rights reserved.
//

#import "MDCurrency.h"

@interface MDCurrency()

@property (nonatomic, strong, readwrite) NSString *currencyString;
@property (nonatomic, strong, readwrite) NSArray *conversions;

@end

@implementation MDCurrency

+ (instancetype)currencyWithConversionDictionary:(NSDictionary *)conversionDictionary {
    return [[MDCurrency alloc] initWithConversionDictionary:conversionDictionary];
}

+ (NSString *)fromCurrecyFromDictionary:(NSDictionary *)conversionDictionary {
    return conversionDictionary[@"from"];
}

+ (NSDictionary *)reverserdConversionFromConversionDictionary:(NSDictionary *)conversionDictionary {
    NSMutableDictionary *reversedConversion = [NSMutableDictionary new];
    [reversedConversion setObject:conversionDictionary[@"from"] forKey:@"to"];
    [reversedConversion setObject:conversionDictionary[@"to"] forKey:@"from"];
    [reversedConversion setObject:@(1/[conversionDictionary[@"rate"] floatValue]) forKey:@"rate"];
    return [NSDictionary dictionaryWithDictionary:reversedConversion];
}

- (instancetype)initWithConversionDictionary:(NSDictionary *)conversionDictionary {
    self = [super init];
    if (self) {
        _currencyString = conversionDictionary[@"from"];
        [self addConversionFromDictionary:conversionDictionary];
    }
    return self;
}

- (void)addConversionFromDictionary:(NSDictionary *)conversionDictionary {
    NSMutableArray *mutableConversions = [NSMutableArray arrayWithArray:self.conversions];
    [mutableConversions addObject:[MDConversion conversionFromConversionDictionary:conversionDictionary]];
    self.conversions = [NSArray arrayWithArray:mutableConversions];
}

- (NSString *)description {
    return self.currencyString;
}

@end
