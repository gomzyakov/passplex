//
//  PSPinCode.h
//  password
//
//  Created by Gomzyakov on 16.02.14.
//  Copyright (c) 2014 Alexander Gomzyakov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PSPinCode : NSObject

/**
 Возвращает PIN-код.

 @return PIN-код.
 */
+ (NSNumber *)passcode;

/**
 Устанавливает PIN-код.

 @param passcode PIN-код.
 */
+ (void)setPasscode:(NSNumber *)passcode;

/**
 Возвращает YES, если PIN-код корректно установлен.
 
 @return YES, если PIN-код корректно установлен.
 */
+ (BOOL)isSet;

/**
 Очищает находящиеся под управлением враппера PCCommonSearchResults поля NSUserDefaults.
 */
+ (void)clear;

@end
