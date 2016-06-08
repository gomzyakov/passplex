//
//  PSPasswordsGenerator.m
//  password
//
//  Created by Alexander Gomzyakov on 11.01.14.
//  Copyright (c) 2014 Alexander Gomzyakov. All rights reserved.
//

#import "PSPasswordsGenerator.h"

/// Минимально допустимая длинна пароля.
const NSUInteger minPasswordLenght = 4;

@implementation PSPasswordsGenerator

const NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789$&@!?#";

+ (NSString *)randomPasswordWithLength:(NSUInteger)len
{
    len = len > minPasswordLenght ? len : minPasswordLenght;

    NSMutableString *randomString = [NSMutableString stringWithCapacity:len];

    for (NSUInteger i = 0; i < len; i++) {
        [randomString appendFormat:@"%C", [letters characterAtIndex:arc4random() % [letters length]]];
    }

    return randomString;
}

@end