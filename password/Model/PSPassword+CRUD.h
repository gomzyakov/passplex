//
//  Passwords.h
//  password
//
//  Created by Alexander Gomzyakov on 04.06.13.
//  Copyright (c) 2013 Alexander Gomzyakov. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "PSPassword.h"

@interface PSPassword (CRUD)

/**
 Возвращает сущность PSPassword инициализированную JSON-словарем.

 @param dictionary Инициализирующий словарь полученный из JSON-ответа.
 @param isFavorite YES, если пароль находится в списке избранных.
 @param context    Контекст управляемого объекта.

 @return Объект сущности PSPassword или nil, если данные в инициализирующего массива не корректны.
 */
+ (PSPassword *)passwordWithDictionary:(NSDictionary *)dictionary isFavorite:(NSNumber *)isFavorite inContext:(NSManagedObjectContext *)context;

/**
 Возвращает список всех паролей.

 @param context    Контекст управляемого объекта.

 @return Массив паролей или nil, если запрос на выборку выполнить не удалось.
 */
+ (NSArray *)fetchAllPasswordsInContext:(NSManagedObjectContext *)context;

/**
 Возвращает список паролей из заданного списка.

 @param isFavorite YES, если пароль находится в списке избранных.
 @param context    Контекст управляемого объекта.

 @return Массив паролей или nil, если запрос на выборку выполнить не удалось.
 */
+ (NSArray *)fetchPasswordsFavoriteList:(BOOL)isFavorite inContext:(NSManagedObjectContext *)context;

/**
 Удалаяет управляемый объект из заданного контекста.
 @param context    Контекст управляемого объекта.
 */
- (void)deleteInContext:(NSManagedObjectContext *)context;

/**
 Удаляет все пароли.
 */
+ (void)deleteAllPasswordsInContext:(NSManagedObjectContext *)context;

/**
 Импортирует пароли из массива словарей, полученного из JSON-бэкапа.
 @param data Данные файла резервной копии списка паролей.
 */
+ (void)importPasswordsFromData:(NSData *)data inContext:(NSManagedObjectContext *)context;

/**
 Возвращает данные в JSON-формате для экспорта паролей.
 */
+ (NSData *)dataToExportInContext:(NSManagedObjectContext *)context;

@end
