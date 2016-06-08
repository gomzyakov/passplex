//
//  PSPasswordsGenerator.h
//  password
//
//  Created by Alexander Gomzyakov on 11.01.14.
//  Copyright (c) 2014 Alexander Gomzyakov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PSPasswordsGenerator : NSObject

/**
 Возвращает случайным образом сгенерированную строку-пароль.
 @note Строка-пароль состоит из букв латинского алфавита, цифр и спецсимволов. Если
 в параметре заданна длинна пароля менее 4х символов, возвращаем пароль из 4х символов.
 @param len  Длинна генерируемого пароля.
 @return Случайным образом сгенерированная строка-пароль.
 */
+ (NSString *)randomPasswordWithLength:(NSUInteger)len;

@end
