//
//  PSSlideCell.h
//  password
//
//  Inspired by https://github.com/TeehanLax/UITableViewCell-Swipe-for-Options
//
//  Created by Alexander Gomzyakov on 24.12.13.
//  Copyright (c) 2013 Alexander Gomzyakov. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PSPassword;
@protocol PSSlideCellDelegate;

extern NSString *const PSSlideCellEnclosingTableViewDidBeginScrollingNotification;


@interface PSSlideCell : UITableViewCell

- (PSSlideCell *)initWithPassword:(PSPassword *)password reuseIdentifier:(NSString *)reuseIdentifier;

/// Делегат слайд-ячейки.
@property (nonatomic, weak) id<PSSlideCellDelegate> delegate;

/// Сущность Пароль, определяющая отображаемую ячейкой информацию.
@property (nonatomic, weak) PSPassword *password;

/**
 Возвращает высоту ячейки.
 @return Высота ячейки.
 */
+ (CGFloat)cellHeight;

@end

@protocol PSSlideCellDelegate <NSObject>

/**
 Метод делегата, вызывается при одиночном тапе на ячейку.
 @note Стандартное событие таблицы tableView:didSelectRowAtIndexPath: отрабатывать не будет, т.к. мы целиком закрыли ячейку свои представлением.
 @param cell Ячейка по которой произвели одиночный тап.
 */
- (void)slideCellDidSingleTap:(PSSlideCell *)slideCell;

/**
 Метод делегата, вызывается при двойном тапе на ячейку.
 @param cell Ячейка по которой произвели двойной тап.
 */
- (void)slideCellDidDoubleTap:(PSSlideCell *)slideCell;

/**
 Метод делегата, вызывается при нажатии на кнопку ячейки "Удалить".
 @param cell Ячейка на кнопку которой было произведено нажатие.
 */
- (void)cellDidSelectDelete:(PSSlideCell *)cell;

/**
 Метод делегата, вызывается при нажатии на кнопку ячейки "Редактировать".
 @param cell Ячейка на кнопку которой было произведено нажатие.
 */
- (void)cellDidSelectEdit:(PSSlideCell *)cell;

/**
 Метод делегата, вызывается при нажатии на кнопку ячейки "В избранное".
 @param cell Ячейка на кнопку которой было произведено нажатие.
 */
- (void)cellDidSelectFavorite:(PSSlideCell *)cell;

@end
