//
//  PSCancelBarButtonItemView.h
//  password
//
//  Created by Gomzyakov on 04.01.14.
//  Copyright (c) 2014 Alexander Gomzyakov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PSCancelBarButtonItemView : UIView

/**
 Возвращает простое представление для инициализиции кнопки "Отмена" на панели навигации.
 */
+ (PSCancelBarButtonItemView *)buttonWithTarget:(id)target action:(SEL)action;

@end
