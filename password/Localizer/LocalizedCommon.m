//
//  LocalizedCommon.m
//  password
//
//  Created by Alexander Gomzyakov on 11.04.14.
//  Copyright (c) 2014 Alexander Gomzyakov. All rights reserved.
//

#import "LocalizedCommon.h"

@implementation LocalizedCommon

+ (NSString *)alertTitleError
{
    return NSLocalizedStringWithDefaultValue(@"alert.error.title",
                                             @"Common",
                                             [NSBundle mainBundle],
                                             @"Error",
                                             @"Заголовок алерта: Error");
}

+ (NSString *)alertTitleWarning
{
    return NSLocalizedStringWithDefaultValue(@"alert.warning.title",
                                             @"Common",
                                             [NSBundle mainBundle],
                                             @"Warning",
                                             @"Заголовок алерта сообщающего возможности импорта");
}

+ (NSString *)buttonTitleOK
{
    return NSLocalizedStringWithDefaultValue(@"alert.okButton.title",
                                             @"Common",
                                             [NSBundle mainBundle],
                                             @"Ok",
                                             @"Стандартная надпись на кнопке алерта: ОК");
}

+ (NSString *)buttonTitleCancel
{
    return NSLocalizedStringWithDefaultValue(@"alert.cancelButton.title",
                                             @"Common",
                                             [NSBundle mainBundle],
                                             @"Cancel",
                                             @"Кнопка отмены импорта паролей");
}

+ (NSString *)buttonTitleImport
{
    return NSLocalizedStringWithDefaultValue(@"alert.importButton.title",
                                             @"Common",
                                             [NSBundle mainBundle],
                                             @"Import",
                                             @"Кнопка разрешающая импортировать пароли");
}

@end
