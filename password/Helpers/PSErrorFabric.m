//
//  PCErrorFabric.m
//  imopc
//
//  Created by Gomzyakov on 11.02.14.
//  Copyright (c) 2014 ABAK PRESS. All rights reserved.
//

#import "PSErrorFabric.h"

@implementation PSErrorFabric

static NSString *const PSPasswordErrorDomain = @"PSPasswordErrorDomain";

+ (NSError *)errorWithCode:(NSInteger)errorCode errorDescription:(NSString *)errorString
{
    errorString = [errorString isKindOfClass:[NSString class]] ? errorString : [NSString stringWithFormat:@"%@ error %ld", [PSErrorFabric errorDomain], (long)errorCode];
    NSDictionary *userInfoDict = @{ NSLocalizedDescriptionKey : errorString};

    NSError *error = [NSError errorWithDomain:PSPasswordErrorDomain code:errorCode userInfo:userInfoDict];
    return error;
}

+ (NSString *)errorDomain
{
    return PSPasswordErrorDomain;
}

@end
