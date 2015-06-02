//
//  MDConversion.m
//  MyDriveTest
//
//  Created by Popa Andrei on 31/05/2015.
//  Copyright (c) 2015 Popa Andrei. All rights reserved.
//

#import "MDConversion.h"

@interface MDConversion()

@property (nonatomic, copy, readwrite) NSString *toCurrencyString;
@property (nonatomic, assign, readwrite) float conversionRate;

@end

@implementation MDConversion

+ (instancetype)conversionFromConversionDictionary:(NSDictionary *)conversionDictionary {
    return [[MDConversion alloc] initWithConversionDictionary:conversionDictionary];
}

- (instancetype)initWithConversionDictionary:(NSDictionary *)conversionDictionary {
    self = [super init];
    if (self) {
        _toCurrencyString = conversionDictionary[@"to"];
        _conversionRate = [conversionDictionary[@"rate"] floatValue];
    }
    return self;
}

-(NSString *)description {
    return self.toCurrencyString;
}
@end
