//
//  LocalizedPasswordsList.h
//  password
//
//  Created by Alexander Gomzyakov on 13.04.14.
//  Copyright (c) 2014 Alexander Gomzyakov. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Локализация экрана со списком паролей.
 */
@interface LocalizedPasswordsList : NSObject

+ (NSString *)title;

+ (NSString *)alertMessageImport;

+ (NSString *)tableMessageEmptyPasswordList;

+ (NSString *)alertMessagePasswordCopied;

+ (NSString *)alertMessageUsernameCopied;

+ (NSString *)alertMessageAddedToFavorite;

+ (NSString *)alertMessageRemovedFromFavorites;

+ (NSString *)sectionTitleFavorite;

/**
 Заголовок секции списка с паролями не вошедшими в избранное
 */
+ (NSString *)sectionTitleOther;

@end
