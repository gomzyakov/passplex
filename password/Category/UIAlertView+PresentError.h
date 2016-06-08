//
//  UIAlertView+PresentError.h
//  imopc
//
//  Created by Alexander Gomzyakov on 26.11.13.
//  Copyright (c) 2013 ABAK PRESS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertView (PresentError)

/**
 Выводит стандартный алерт без заголовка.
 @param message  Основной текст сообщения об ошибке (описательная часть).
 */
+ (UIAlertView *)alertWithMessage:(NSString *)message;

/**
   Выводит стандартный алерт сообщающий об ошибке.
   @note Алерт носит исключительно информационный характер, обработка нажатия на Ok не делегируется во вне.

   @param errorMessage  Основной текст сообщения об ошибке (описательная часть).
 */
+ (UIAlertView *)errorAlertWithMessage:(NSString *)errorMessage;

/**
   Выводит стандартный алерт с предупреждение.
   @note Алерт носит исключительно информационный характер, обработка нажатия на Ok не делегируется во вне.

   @param warningMessage  Основной текст сообщения-предупреждения.
 */
+ (UIAlertView *)warningAlertWithMessage:(NSString *)warningMessage;

/**
   Выводит стандартный алерт с заданным заголовком и текстом.
   @note Алерт носит исключительно информационный характер, обработка нажатия на Ok не делегируется во вне.

   @param title    Заголовок сообщения об ошибке.
   @param message  Основной текст сообщения об ошибке (описательная часть).
 */
+ (UIAlertView *)alertWithTitle:(NSString *)title message:(NSString *)message;

@end
