//
//  PSPinCode.m
//  password
//
//  Created by Gomzyakov on 16.02.14.
//  Copyright (c) 2014 Alexander Gomzyakov. All rights reserved.
//

#import "PSPinCode.h"
#import "KeychainWrapper.h"

static NSString *const PCUserDefaultsKeyPasscode = @"PCUserDefaultsKeyPasscode";

@implementation PSPinCode

+ (NSNumber *)passcode
{
    NSNumber *passcode = [[NSUserDefaults standardUserDefaults] objectForKey:PCUserDefaultsKeyPasscode];
    return passcode;
}

#warning Используется метод?
+ (void)setPasscode:(NSNumber *)passcode
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:passcode forKey:PCUserDefaultsKeyPasscode];
    [defaults synchronize];
}

#pragma mark - Service Methods

+ (BOOL)isSet;
{
    BOOL isPinSetted = [[NSUserDefaults standardUserDefaults] boolForKey:PIN_SAVED];
    if (isPinSetted) {
        return YES;
    } else {
        return NO;
    }
}

+ (void)clear
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:nil forKey:PCUserDefaultsKeyPasscode];
    [defaults synchronize];
}

@end
