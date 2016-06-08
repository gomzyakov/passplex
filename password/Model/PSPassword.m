//
//  Password.m
//  password
//
//  Created by Alexander Gomzyakov on 04.06.13.
//  Copyright (c) 2013 Alexander Gomzyakov. All rights reserved.
//

#import "PSPassword.h"
#import "KeychainWrapper.h"
#import "NSString+AESCrypt.h"

@implementation PSPassword

@dynamic username;
@dynamic password;
@dynamic title;
@dynamic siteUrl;
@dynamic isFavorite;
@dynamic created;
@dynamic note;

/**
 Неявно храним имя пользователя в зашифрованном виде.
 Шифруем с помощью AES-256, в качестве ключа используем хеш пин-кода.
 */
- (void)setUsername:(NSString *)username
{
    NSString *hashedPin = [KeychainWrapper keychainStringFromMatchingIdentifier:PIN_SAVED];

    NSString *encodedUsername = [username AES256EncryptWithKey:hashedPin];
    NSLog(@"Encoded username: %@", encodedUsername);

    [self willChangeValueForKey:@"username"];
    [self setPrimitiveValue:encodedUsername forKey:@"username"];
    [self didChangeValueForKey:@"username"];
}

- (NSString *)username
{
    NSString *hashedPin = [KeychainWrapper keychainStringFromMatchingIdentifier:PIN_SAVED];

    NSString *encodedUsername = [self primitiveValueForKey:@"username"];
    NSString *decodedUsername = [encodedUsername AES256DecryptWithKey:hashedPin];

    return decodedUsername;
}

/**
 Неявно храним пароль в зашифрованном виде.
 Шифруем с помощью AES-256, в качестве ключа используем хеш пин-кода.
 */
- (void)setPassword:(NSString *)password
{
    NSString *hashedPin = [KeychainWrapper keychainStringFromMatchingIdentifier:PIN_SAVED];

    NSString *encodedPassword = [password AES256EncryptWithKey:hashedPin];
    NSLog(@"Encoded password: %@", encodedPassword);

    [self willChangeValueForKey:@"password"];
    [self setPrimitiveValue:encodedPassword forKey:@"password"];
    [self didChangeValueForKey:@"password"];
}

- (NSString *)password
{
    NSString *hashedPin = [KeychainWrapper keychainStringFromMatchingIdentifier:PIN_SAVED];

    NSString *encodedPassword = [self primitiveValueForKey:@"password"];
    NSString *decodedPassword = [encodedPassword AES256DecryptWithKey:hashedPin];

    return decodedPassword;
}

@end
