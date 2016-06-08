//
//  LocalizedCommon.h
//  password
//
//  Created by Alexander Gomzyakov on 11.04.14.
//  Copyright (c) 2014 Alexander Gomzyakov. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Локализация элементов, общих для разных экранов.
 */
@interface LocalizedCommon : NSObject

+ (NSString *)alertTitleError;

+ (NSString *)alertTitleWarning;

+ (NSString *)buttonTitleOK;

+ (NSString *)buttonTitleCancel;

+ (NSString *)buttonTitleImport;

@end
