//
//  LocalizedPasswordsList.m
//  password
//
//  Created by Alexander Gomzyakov on 13.04.14.
//  Copyright (c) 2014 Alexander Gomzyakov. All rights reserved.
//

#import "LocalizedPasswordsList.h"

@implementation LocalizedPasswordsList

+ (NSString *)title
{
    return NSLocalizedStringWithDefaultValue(@"title",
                                             @"PasswordsList",
                                             [NSBundle mainBundle],
                                             @"Passwords",
                                             @"Заголовок представления в котором выводится список паролей");
}

+ (NSString *)alertMessageImport
{
    return NSLocalizedStringWithDefaultValue(@"alert.import.message",
                                             @"PasswordsList",
                                             [NSBundle mainBundle],
                                             @"Do you want to import data from a backup? Existing data will be lost",
                                             @"Заголовок алерта сообщающего возможности импорта");
}

+ (NSString *)tableMessageEmptyPasswordList
{
    return NSLocalizedStringWithDefaultValue(@"emptyPasswordsList.message",
                                             @"PasswordsList",
                                             [NSBundle mainBundle],
                                             @"Add new item",
                                             @"Сообщение о том, что  список паролей пуст");
}

+ (NSString *)alertMessagePasswordCopied
{
    return NSLocalizedStringWithDefaultValue(@"alert.passwordCopied.message",
                                             @"PasswordsList",
                                             [NSBundle mainBundle],
                                             @"Password copied to clipboard",
                                             @"Сообщение алерта о том, что пароль скопирован в буфер обмена");
}

+ (NSString *)alertMessageUsernameCopied
{
    return NSLocalizedStringWithDefaultValue(@"alert.usernameCopied.message",
                                             @"PasswordsList",
                                             [NSBundle mainBundle],
                                             @"Username copied to clipboard",
                                             @"Сообщение алерта о том, что имя пользователя скопированно в буфер обмена");
}

+ (NSString *)alertMessageAddedToFavorite
{
    return NSLocalizedStringWithDefaultValue(@"alert.addedToFavorite.message",
                                             @"PasswordsList",
                                             [NSBundle mainBundle],
                                             @"Password added to favorites",
                                             @"Сообщение алерта о том, что пароль добавлен в избранное");
}

+ (NSString *)alertMessageRemovedFromFavorites
{
    return NSLocalizedStringWithDefaultValue(@"alert.removedFromFavorites.message",
                                             @"PasswordsList",
                                             [NSBundle mainBundle],
                                             @"Password removed from favorites",
                                             @"Сообщение алерта о том, что пароль удален из избранного");
}

+ (NSString *)sectionTitleFavorite
{
    return NSLocalizedStringWithDefaultValue(@"section.favorite.title",
                                             @"PasswordsList",
                                             [NSBundle mainBundle],
                                             @"Favorite passwords",
                                             @"Заголовок секции списка с избранными паролями");
}

+ (NSString *)sectionTitleOther
{
    return NSLocalizedStringWithDefaultValue(@"section.other.title",
                                             @"PasswordsList",
                                             [NSBundle mainBundle],
                                             @"Other passwords",
                                             @"Заголовок секции списка с паролями не вошедшими в избранное");
}

@end
