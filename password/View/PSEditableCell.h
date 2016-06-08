//
//  PSEditableCell.h
//  password
//
//  Created by Gomzyakov on 04.01.14.
//  Copyright (c) 2014 Alexander Gomzyakov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PSEditableCell : UITableViewCell

/// Текстовое поле ячейки
@property (nonatomic) UITextField *textField;

/**
 Возвращает ячейку с полем редактирования и, если необходимо, кнопкой в правой части.
 @param button  Кнопка размещаемая в правой части ячейки или nil, если кнопка не нужна.
 */
+ (PSEditableCell *)cell;

/**
 Возвращает высоту ячейки.
 @return Высота ячейки.
 */
+ (CGFloat)cellHeight;

@end
