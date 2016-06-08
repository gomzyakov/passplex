//
//  PSEditableCellWithButton.h
//  password
//
//  Created by Alexander Gomzyakov on 08.04.14.
//  Copyright (c) 2014 Alexander Gomzyakov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PSEditableCellWithButton : UITableViewCell

/// Текстовое поле ячейки
@property (nonatomic) UITextField *textField;

/**
 Возвращает ячейку с полем редактирования и, если необходимо, кнопкой в правой части.
 @param button  Кнопка размещаемая в правой части ячейки или nil, если кнопка не нужна.
 */
+ (instancetype)cellWithButton:(UIButton *)button;

/**
 Возвращает высоту ячейки.
 @return Высота ячейки.
 */
+ (CGFloat)cellHeight;

@end
