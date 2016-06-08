//
//  PCMenuDatasource.h
//  imopc
//
//  Created by Alexander Gomzyakov on 21.01.14.
//  Copyright (c) 2014 ABAK PRESS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PSMenuDatasource : NSObject

/**
 Возвращает количество секций.
 @return Количество секций.
 */
- (NSUInteger)numberOfSections;

/**
 Возвращает количество ячеек в секции с заданным заголовком.
 @param sectionTitle Заголовок секции.
 @return Количество ячеек в секции с заданным заголовком или NSNotFound, если не существует секции с заданным заголовком.
 */
- (NSUInteger)numberOfRowsInSectionWithTitle:(NSString *)sectionTitle;

/**
 Возвращает количество ячеек в секции с заданным индексом.
 @param sectionIndex Индекс секции.
 @return Количество ячеек в секции с заданным индексом или NSNotFound, если не существует секции с заданным индексом.
 */
- (NSUInteger)numberOfRowsInSectionWithIndex:(NSUInteger)sectionIndex;

/**
 Добляет секцию с заданным заголовком.
 @param sectionTitle Заголовок секции.
 @return YES, если секция с заданным заголовком успешно добавлена.
 */
- (BOOL)insertSectionWithHeaderTitle:(NSString *)sectionTitle;

/**
 Добляет ячейку с заданными параметрами.
 @param sectionTitle Заголовок секции.
 @return YES, если секция с заданным заголовком успешно добавлена.
 */
- (BOOL)insertRowWithTitle:(NSString *)rowTitle iconFilename:(NSString *)iconFilename viewController:(UIViewController *)viewController inSectionWithIndex:(NSUInteger)sectionIndex;

- (BOOL)insertRowWithTitle:(NSString *)rowTitle iconFilename:(NSString *)iconFilename viewController:(UIViewController *)viewController inSectionWithTitle:(NSString *)sectionTitle;

- (NSString *)titleForSectionWithIndex:(NSUInteger)sectionIndex;

- (NSString *)titleForRowWithIndex:(NSUInteger)row inSectionWithIndex:(NSUInteger)sectionIndex;

- (NSString *)iconFilenameForRowWithIndex:(NSUInteger)rowIndex inSectionWithIndex:(NSUInteger)sectionIndex;

- (void)clear;

- (UIViewController *)viewControllerForIndexPath:(NSIndexPath *)indexPath;

- (UIViewController *)viewControllerForRowWithIndex:(NSUInteger)rowIndex inSectionWithIndex:(NSUInteger)sectionIndex;

/**
 Возвращает индексный путь ячейки для заданного контроллера представления.
 @param viewController Контроллер представления для которого необходимо узнать индексный путь.
 @return Индексный путь заданного контроллера.
 */
- (NSIndexPath *)indexPathForViewController:(UIViewController *)viewController;

@end
