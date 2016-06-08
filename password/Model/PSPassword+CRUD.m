//
//  Passwords.m
//  password
//
//  Created by Alexander Gomzyakov on 04.06.13.
//  Copyright (c) 2013 Alexander Gomzyakov. All rights reserved.
//

#import "PSPassword+CRUD.h"

// helpers
#import "PSDateFormater.h"
#import "PSErrorFabric.h"

// Ключи для импорта/экспорта данных
static NSString *const ExportKeyTitle      = @"title";
static NSString *const ExportKeyUsername   = @"username";
static NSString *const ExportKeyPassword   = @"password";
static NSString *const ExportKeySiteUrl    = @"site_url";
static NSString *const ExportKeyIsFavorite = @"is_favorite";

@implementation PSPassword (CRUD)

+ (PSPassword *)passwordWithDictionary:(NSDictionary *)dictionary isFavorite:(NSNumber *)isFavorite inContext:(NSManagedObjectContext *)context
{
    if (!context) return nil;

    PSPassword *password = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([PSPassword class]) inManagedObjectContext:context];

    NSError *criticalError;

    id title = [dictionary objectForKey:@"title"];
    if ([password validateValue:&title forKey:@"title" error:&criticalError]) {
        [password setValue:(NSString *)title forKey:@"title"];
    }

    id username = [dictionary objectForKey:@"username"];
    if ([password validateValue:&username forKey:@"username" error:&criticalError]) {
        [password setValue:(NSString *)username forKey:@"username"];
    }

    id pas = [dictionary objectForKey:@"password"];
    if ([password validateValue:&pas forKey:@"password" error:&criticalError]) {
        [password setValue:(NSString *)pas forKey:@"password"];
    }

    password.isFavorite = isFavorite;

    id siteUrl = [dictionary objectForKey:@"siteUrl"];
    if ([password validateValue:&siteUrl forKey:@"siteUrl" error:&criticalError]) {
        [password setValue:(NSString *)siteUrl forKey:@"siteUrl"];
    }

//	NSString *note = (NSString *)[dictionary objectForKey:@"note"];
//	if ([password validateValue:&note forKey:@"note" error:&error]) {
//		password.note = note;
//	}

#warning падает
//	NSString *createdDateString = (NSString *)[dictionary objectForKey:@"created"];
//	NSDate *created = [PSDateFormater dateFromString:createdDateString error:&error];
//	if ([self validateValue:&created forKey:@"created" error:&error]) {
//		password.created = created;
//	}

    if (criticalError) {
        NSLog(@"%@ initial validation error: %d %@", NSStringFromClass([PSPassword class]), criticalError.code, criticalError.debugDescription);
        [context deleteObject:password];
        return nil;
    }

    return password;
}

+ (NSArray *)fetchAllPasswordsInContext:(NSManagedObjectContext *)context
{
    NSArray *favoritePasswords = [PSPassword fetchPasswordsFavoriteList:YES inContext:context];
    NSArray *otherPasswords    = [PSPassword fetchPasswordsFavoriteList:NO inContext:context];

    NSArray *resultArray = [favoritePasswords arrayByAddingObjectsFromArray:otherPasswords];
    return resultArray;
}

+ (NSArray *)fetchPasswordsFavoriteList:(BOOL)isFavorite inContext:(NSManagedObjectContext *)context
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:NSStringFromClass([PSPassword class])];
    fetchRequest.includesPropertyValues = YES;
    fetchRequest.includesSubentities    = NO;
    fetchRequest.returnsObjectsAsFaults = NO;

    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"isFavorite = %d", isFavorite];

    NSError *error   = nil;
    NSArray *matches = [context executeFetchRequest:fetchRequest error:&error];

    if (!error) {
        return matches;
    } else {
        NSLog(@"Fetch %@ list error: %d %@", NSStringFromClass([PSPassword class]), error.code, error.debugDescription);
        return nil;
    }
}

- (void)deleteInContext:(NSManagedObjectContext *)context
{
    [context deleteObject:self];
}

+ (void)deleteAllPasswordsInContext:(NSManagedObjectContext *)context
{
    NSArray *matches = [PSPassword fetchAllPasswordsInContext:context];

    if (!matches) {
        NSLog(@"Delete %@ list error", NSStringFromClass([PSPassword class]));
    } else {
        for (NSManagedObject *password in matches) {
            [context deleteObject:password];
        }
    }
}

#warning вынести в отдельный класс
+ (void)importPasswordsFromData:(NSData *)data inContext:(NSManagedObjectContext *)context
{
    NSError *error;
    NSArray *passwordsArray = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];

    if (!error) {
        [PSPassword deleteAllPasswordsInContext:context];

        for (NSDictionary *passwordDict in passwordsArray) {
            NSNumber   *isFavorite = (NSNumber *)[passwordDict objectForKey:ExportKeyIsFavorite];
            PSPassword *password   = [PSPassword passwordWithDictionary:passwordDict
                                                             isFavorite:isFavorite
                                                              inContext:context];
            if (!password) {
                NSLog(@"Fail import password from dictionary: %@", passwordDict);
            }
        }
    } else {
        NSLog(@"JSON parse error: %@", error);
    }

#warning отчитываться о количестве ошибок было бы неплохо
}

+ (NSData *)dataToExportInContext:(NSManagedObjectContext *)context
{
    NSArray *passwords = [PSPassword fetchAllPasswordsInContext:context];

    NSMutableArray *passwordsArray = [NSMutableArray array];
    for (PSPassword *password in passwords) {
        NSDictionary *passwordDict = @{ ExportKeyTitle:      password.title,
                                        ExportKeyUsername:   password.username,
                                        ExportKeyPassword:   password.password,
                                        ExportKeySiteUrl:    password.siteUrl,
                                        ExportKeyIsFavorite: password.isFavorite };
        [passwordsArray addObject:passwordDict];
    }

    NSError *error      = nil;
    NSData  *exportData = [NSJSONSerialization dataWithJSONObject:passwordsArray options:NSJSONWritingPrettyPrinted error:&error];

    if (!error) {
        return exportData;
    } else {
        NSLog(@"Prepare %@ data to export failed with error: %d %@", NSStringFromClass([PSPassword class]), error.code, error.debugDescription);
        return nil;
    }
}

#pragma mark - Data Validation

/**
   Проверяем заголовок парольной записи. Заголовок должен быть заданн, он не может
   быть пустым (0 символов) и не может превышать 255 символов в длинну.
 */
- (BOOL)validateTitle:(id *)ioValue error:(NSError * *)outError
{
    if (!*ioValue) return NO;

    if ([*ioValue isKindOfClass :[NSString self]]) {
        if ([(NSString *)*ioValue respondsToSelector : @selector(length)]) {
            if ([(NSString *)*ioValue length] > 0 && [(NSString *)*ioValue length] < 256) {
                NSLog(@"tit YES");
                return YES;
            }
        }
    }

    if (outError != NULL) {
        NSString *errorString = @"Incorrect <title> property";
        *outError = [PSErrorFabric errorWithCode:0 errorDescription:errorString];
    }

    return NO;
}

/**
   Проверяем свойство username парольной записи.
 */
- (BOOL)validateUsername:(id *)ioValue error:(NSError * *)outError
{
    if ([*ioValue isKindOfClass :[NSString class]]) {
        if ([(NSString *)*ioValue respondsToSelector : @selector(length)]) {
            if ([(NSString *)*ioValue length] > 0 && [(NSString *)*ioValue length] < 256) {
                return YES;
            }
        }
    }

    return NO;
}

/**
   Проверяем свойство password парольной записи.
 */
- (BOOL)validatePassword:(id *)ioValue error:(NSError * *)outError
{
    if ([*ioValue isKindOfClass :[NSString class]]) {
        if ([(NSString *)*ioValue respondsToSelector : @selector(length)]) {
            if ([(NSString *)*ioValue length] > 0 && [(NSString *)*ioValue length] < 256) {
                return YES;
            }
        }
    }

    return NO;
}

/**
   Параметр iconPath опциональный, поэтому ошибку логируем, но инициализироваться продолжаем.
 */
- (BOOL)validateIconPath:(id *)ioValue error:(NSError * *)outError
{
    if ([[NSNull null] isEqual:*ioValue]) *ioValue = nil;
    if ([*ioValue isKindOfClass :[NSDate class]] || *ioValue == nil) {
        return YES;
    }

    //NSLog(@"Fail init property <%@> in managed object %@", @"created", NSStringFromClass([PCCompanyBusinessType class]));

    return NO;
}

@end
