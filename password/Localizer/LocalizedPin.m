//
//  LocalizedPin.m
//  password
//
//  Created by Alexander Gomzyakov on 13.04.14.
//  Copyright (c) 2014 Alexander Gomzyakov. All rights reserved.
//

#import "LocalizedPin.h"

@implementation LocalizedPin

+ (NSString *)alertMessagePasscodeIsEnteredIncorrectly
{
    return NSLocalizedStringWithDefaultValue(@"alert.passcodeIsEnteredIncorrectly.message",
                                             @"Pin",
                                             [NSBundle mainBundle],
                                             @"Passcode is entered incorrectly!",
                                             @"Сообщение алерта о том, что некорректно введен PIN-код");
}

+ (NSString *)viewTitleSetPin
{
    return NSLocalizedStringWithDefaultValue(@"view.setPin.title",
                                             @"Pin",
                                             [NSBundle mainBundle],
                                             @"Set Passcode",
                                             @"Сообщение с запросом на ввод пин-кода");
}

+ (NSString *)viewTitleEnterPin
{
    return NSLocalizedStringWithDefaultValue(@"view.enterPin.title",
                                             @"Pin",
                                             [NSBundle mainBundle],
                                             @"Enter a passcode",
                                             @"Заголовок блока для ввода PIN-кода");
}

+ (NSString *)viewTitleConfirmPin
{
    return NSLocalizedStringWithDefaultValue(@"view.confirmPin.title",
                                             @"Pin",
                                             [NSBundle mainBundle],
                                             @"Confirm passcode",
                                             @"Заголовок блока для подтверждения ввода PIN-кода");
}

+ (NSString *)alertMessageIncorrectPasscodeConfirmation
{
    return NSLocalizedStringWithDefaultValue(@"alert.incorrectPin.message",
                                             @"Pin",
                                             [NSBundle mainBundle],
                                             @"Incorrectly entered passcode confirmation!",
                                             @"Сообщение алерта о том, что некорректно введено подтверждение PIN-кода");
}

@end
