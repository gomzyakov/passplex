//
//  LocalizedEdit.m
//  password
//
//  Created by Alexander Gomzyakov on 13.04.14.
//  Copyright (c) 2014 Alexander Gomzyakov. All rights reserved.
//

#import "LocalizedEdit.h"

@implementation LocalizedEdit

+ (NSString *)titleEdit
{
    return NSLocalizedStringWithDefaultValue(@"title.edit",
                                             @"Edit",
                                             [NSBundle mainBundle],
                                             @"Edit password",
                                             @"Заголовок представления редактирования пароля");
}

+ (NSString *)titleAdd
{
    return NSLocalizedStringWithDefaultValue(@"title.add",
                                             @"Edit",
                                             [NSBundle mainBundle],
                                             @"Add password",
                                             @"Заголовок представления создания нового пароля");
}

+ (NSString *)fieldPlaceholderTitle
{
    return NSLocalizedStringWithDefaultValue(@"field.title.placeholder",
                                             @"Edit",
                                             [NSBundle mainBundle],
                                             @"Title",
                                             @"Плейсхолдер поля для ввода заголовка пароля");
}

+ (NSString *)fieldPlaceholderLogin
{
    return NSLocalizedStringWithDefaultValue(@"field.login.placeholder",
                                             @"Edit",
                                             [NSBundle mainBundle],
                                             @"Username",
                                             @"Плейсхолдер поля для ввода логина");
}

+ (NSString *)fieldPlaceholderSiteUrl
{
    return NSLocalizedStringWithDefaultValue(@"field.siteUrl.placeholder",
                                             @"Edit",
                                             [NSBundle mainBundle],
                                             @"Site URL",
                                             @"Плейсхолдер поля для ввода URL-адреса сайта");
}

+ (NSString *)fieldPlaceholderPassword
{
    return NSLocalizedStringWithDefaultValue(@"field.password.placeholder",
                                             @"Edit",
                                             [NSBundle mainBundle],
                                             @"Password",
                                             @"Плейсхолдер поля для ввода непосредственно пароля");
}

+ (NSString *)alertMessageFailedToSavePassword
{
    return NSLocalizedStringWithDefaultValue(@"alert.failedToSavePassword.message",
                                             @"Edit",
                                             [NSBundle mainBundle],
                                             @"Failed to save password",
                                             @"Заголовок алерта сообщающего об ошибке при попытке сохранить пароль локально");
}

+ (NSString *)alertMessageIncorrectlyFilledSomeFields
{
    return NSLocalizedStringWithDefaultValue(@"alert.incorrectlyFilledSomeFields.message",
                                             @"Edit",
                                             [NSBundle mainBundle],
                                             @"Incorrectly filled some fields", @"Сообщение алерта о некорректном заполнении полей карточки пароля");

}

@end
