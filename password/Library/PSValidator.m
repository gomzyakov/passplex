//
//  PSValidator.m
//  password
//
//  Created by Alexander Gomzyakov on 11.01.14.
//  Copyright (c) 2014 Alexander Gomzyakov. All rights reserved.
//

#import "PSValidator.h"

@implementation PSValidator

+ (BOOL)validateTitle:(id)value
{
    return [PSValidator validateUsername:value];
}

+ (BOOL)validatePassword:(id)value
{
    return [PSValidator validateUsername:value];
}

+ (BOOL)validateUsername:(id)value
{
    BOOL     isValid = NO;
    NSString *toTest = (NSString *)value;

    if (![toTest isEqualToString:@""] && toTest.length < 256) {
        isValid = YES;
    }
    return isValid;
}

+ (BOOL)validateEmail:(NSString *)candidate
{
    NSString    *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest  = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];

    return [emailTest evaluateWithObject:candidate];
}

+ (BOOL)validateURLString:(NSString *)url
{
    NSString *regex =
        @"((?:http|https)://)?(?:www\\.)?[\\w\\d\\-_]+\\.\\w{2,3}(\\.\\w{2})?(/(?<=/)(?:[\\w\\d\\-./_]+)?)?";
    /// OR use this
    ///NSString *regex = "(http|ftp|https)://[\w-_]+(.[\w-_]+)+([\w-.,@?^=%&:/~+#]* [\w-\@?^=%&/~+#])?";
    NSPredicate *regextest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];

    return [regextest evaluateWithObject:url];
}

@end
