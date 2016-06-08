//
//  PSSlideCellEditButton.h
//  password
//
//  Created by Alexander Gomzyakov on 26.12.13.
//  Copyright (c) 2013 Alexander Gomzyakov. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM (NSUInteger, PSSlideCellButtonType) {
    PSSlideCellButtonTypeEdit,
    PSSlideCellButtonTypeFavorite,
    PSSlideCellButtonTypeDelete
};

@interface PSSlideCellButton : UIButton

/// Флаг определяющий тип кнопки (Править, В избранное или Удалить)
@property (nonatomic) PSSlideCellButtonType type;

/**
 Возвращает кастомную кнопку "Править" для слайд-ячейки.
 @param  target  Целевой объект - объект которому будут отправляться экшны кнопки.
 @param  action  Селектор посылаемого цели сообщения.
 @return Кастомная кнопка "Править" для слайд-ячейки.
 */
+ (instancetype)buttonWithType:(PSSlideCellButtonType)type target:(id)target action:(SEL)action;

@end
