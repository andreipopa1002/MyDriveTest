//
//  MDApiClient.h
//  MyDriveTest
//
//  Created by Popa Andrei on 31/05/2015.
//  Copyright (c) 2015 Popa Andrei. All rights reserved.
//

#import "AFNetworking.h"

@interface MDApiClient : AFHTTPSessionManager
/**
 *  SharedClient
 *
 *  @return Shared instance for the MDApiClient class
 */
+ (instancetype)sharedClient;
/**
 *  This method will retrieve the currency list
 */
- (void)retrieveConversionsList:(void (^)(NSArray *currencyArray))callbackBlock;

@end
