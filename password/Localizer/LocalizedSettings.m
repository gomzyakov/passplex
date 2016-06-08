//
//  LocalizedSettings.m
//  password
//
//  Created by Alexander Gomzyakov on 11.04.14.
//  Copyright (c) 2014 Alexander Gomzyakov. All rights reserved.
//

#import "LocalizedSettings.h"

@implementation LocalizedSettings

+ (NSString *)emailBackupTitle
{
    return NSLocalizedStringWithDefaultValue(@"emailBackup.title",
                                             @"Settings",
                                             [NSBundle mainBundle],
                                             @"Passplex Backup",
                                             @"Заголовок email-а с файлом резервной копии паролей");
}

+ (NSString *)emailBackupMessage
{

    return NSLocalizedStringWithDefaultValue(@"emailBackup.message",
                                             @"Settings",
                                             [NSBundle mainBundle],
                                             @"Backup passwords:",
                                             @"Текст email-а с файлом резервной копии паролей");
}

+ (NSString *)viewTitle
{
    return NSLocalizedStringWithDefaultValue(@"title",
                                             @"Settings",
                                             [NSBundle mainBundle],
                                             @"Settings",
                                             @"Заголовок экрана с настройками");

}

+ (NSString *)alertMessageEmailPrepareError
{
    return NSLocalizedStringWithDefaultValue(@"alert.emailPrepareError.message",
                                             @"Settings",
                                             [NSBundle mainBundle],
                                             @"Configure email, then try the export",
                                             @"Сообщение алерта сообщающее о невозможности отправить с файлом резервной копией на e-mail");
}

+ (NSString *)alertMessageRemoveAllPasswords
{
    return NSLocalizedStringWithDefaultValue(@"alert.removeAllPasswords.message",
                                             @"Settings",
                                             [NSBundle mainBundle],
                                             @"Do you want to remove all the passwords?",
                                             @"Сообщение алерта предупреждающее пользователя о удалении всех паролей");
}

+ (NSString *)buttonTitleRemoveAllPasswords
{
    return NSLocalizedStringWithDefaultValue(@"alert.removeAllPasswords.removeButton.title",
                                             @"Settings",
                                             [NSBundle mainBundle],
                                             @"Yes, remove all",
                                             @"Кнопка разрешающая удалить все пароли");
}

+ (NSString *)cellTitleChangePin
{
    return NSLocalizedStringWithDefaultValue(@"row.changePin.title",
                                             @"Settings",
                                             [NSBundle mainBundle],
                                             @"Change Passcode",
                                             @"Заголовок ячейки смены пин-кода");
}

+ (NSString *)cellTitleDeleteAllPasswords
{
    return NSLocalizedStringWithDefaultValue(@"row.deleteAllPasswords.title",
                                             @"Settings",
                                             [NSBundle mainBundle],
                                             @"Delete All Items",
                                             @"Заголовок ячейки удаления всех паролей");
}

+ (NSString *)cellTitleExportToEmail
{
    return NSLocalizedStringWithDefaultValue(@"row.exportToEmail.title",
                                             @"Settings",
                                             [NSBundle mainBundle],
                                             @"Export to Mail",
                                             @"Заголовок ячейки создания резервной копии всех паролей которая будет отправленна на e-mail");
}

@end
