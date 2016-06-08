//
//  PSSiteUrlCell.h
//  password
//
//  Created by Alexander Gomzyakov on 21.03.14.
//  Copyright (c) 2014 Alexander Gomzyakov. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 Ячейка с полем редактирования и субпредставлением для отображения фавиконки.
 */
@interface PSSiteUrlCell : UITableViewCell

/// Фавикон сайта, адрес которого введен в текстовое поле.
@property (nonatomic) UIImageView *faviconView;

/// Текстовое поле для ввода адреса сайта.
@property (nonatomic) UITextField *textField;

@property (nonatomic) UIActivityIndicatorView *activityIndicator;

/**
 Возвращает ячейку с полем редактирования и субпредставлением для отображения фавиконки.
 */
+ (PSSiteUrlCell *)cellWithImage;

/**
 Возвращает высоту ячейки.
 @return Высота ячейки.
 */
+ (CGFloat)cellHeight;

@end
