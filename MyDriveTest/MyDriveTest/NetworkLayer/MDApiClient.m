//
//  MDApiClient.m
//  MyDriveTest
//
//  Created by Popa Andrei on 31/05/2015.
//  Copyright (c) 2015 Popa Andrei. All rights reserved.
//

#import "MDApiClient.h"
#import "AFNetworkActivityIndicatorManager.h"

static NSString *const kAPIBaseURLString = @"http://raw.githubusercontent.com/";

typedef NS_ENUM(NSInteger, APIHTTPMethod) {
    APIHTTPMethodGet,
    APIHTTPMethodPost,
};

@implementation MDApiClient

+ (instancetype)sharedClient {
    static MDApiClient *_sharedClient;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[MDApiClient alloc] initWithBaseURL:[NSURL URLWithString:kAPIBaseURLString]];
        _sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        _sharedClient.requestSerializer = [AFJSONRequestSerializer serializer];
        _sharedClient.responseSerializer = [AFJSONResponseSerializer serializer];
        _sharedClient.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
        AFNetworkActivityIndicatorManager.sharedManager.enabled = YES;
    });
    
    return _sharedClient;
}

# pragma mark - API methods
- (void)retrieveConversionsList:(void (^)(NSArray *currencyArray))callbackBlock {
    [self getRequestWithPath:@"/mydrive/code-tests/master/iOS-currency-exchange-rates/rates.json" parameters:nil callbackBlock:^(id responseObject) {
        if (responseObject) {
            if (callbackBlock) {
                callbackBlock(responseObject[@"conversions"]);
            }
        } else if (callbackBlock) {
            callbackBlock(nil);
        }
    }];
}

# pragma mark - Requests
- (void)getRequestWithPath:(NSString *)path parameters:(NSDictionary *)parameters callbackBlock:(void (^)(id responseObject))callbackBlock {
    [self requestWithPath:path method:APIHTTPMethodGet parameters:parameters callbackBlock:callbackBlock];
}

- (void)requestWithPath:(NSString *)path method:(APIHTTPMethod)method parameters:(NSDictionary *)parameters
          callbackBlock:(void (^)(id responseObject))callbackBlock {
    void (^successPath)(NSDictionary *) = ^(NSDictionary *responseObject) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (responseObject){
                callbackBlock(responseObject);
            } else {
                callbackBlock(nil);
            }
        });
    };
    
    void (^errorPath)(NSError *) = ^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self handleError:error];
            callbackBlock(nil);
        });
    };
    
    switch (method) {
            case APIHTTPMethodGet: {
                [self GET:path parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
                    successPath(responseObject);
                } failure:^(NSURLSessionDataTask *task, NSError *error) {
                    errorPath(error);
                }];
                break;
            }
            case APIHTTPMethodPost: {
                [self POST:path parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
                    if ([(NSHTTPURLResponse *)task.response statusCode] == 201) {
                        successPath([NSDictionary new]);
                    } else {
                        errorPath(nil);
                    }
                } failure:^(NSURLSessionDataTask *task, NSError *error) {
                    errorPath(error);
                }];
                break;
            }
        default:
            break;
    }
}

# pragma mark - Error handling
- (void)handleError:(NSError *)error {
    NSString *errorString = [NSString stringWithFormat:@"%ld - %@",(long)error.code,error.domain];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", nil)
                                                        message:errorString
                                                       delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
}

@end
