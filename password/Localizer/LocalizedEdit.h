//
//  LocalizedEdit.h
//  password
//
//  Created by Alexander Gomzyakov on 13.04.14.
//  Copyright (c) 2014 Alexander Gomzyakov. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Локализация экрана редактирования (добавления нового) пароля.
 */
@interface LocalizedEdit : NSObject

+ (NSString *)titleEdit;

+ (NSString *)titleAdd;

+ (NSString *)fieldPlaceholderTitle;

+ (NSString *)fieldPlaceholderLogin;

+ (NSString *)fieldPlaceholderSiteUrl;

+ (NSString *)fieldPlaceholderPassword;

+ (NSString *)alertMessageFailedToSavePassword;

+ (NSString *)alertMessageIncorrectlyFilledSomeFields;

@end
