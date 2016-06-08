//
//  NSArray+Sort.h
//  imopc
//
//  Created by Alexander Gomzyakov on 04.03.14.
//  Copyright (c) 2014 ABAK PRESS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Sort)

/**
 Возвращает массив элементов сортированный по параметру "title".
 @return Массив элементов сортированный по параметру "title".
 */
- (NSArray *)arraySortedByTitleProperty;

@end
