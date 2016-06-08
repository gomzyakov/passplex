//
//  PSSettingsBarButtonItemView.h
//  password
//
//  Created by Alexander Gomzyakov on 24.12.13.
//  Copyright (c) 2013 Alexander Gomzyakov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PSSettingsBarButtonItemView : UIView

/**
 Возвращает простое представление для инициализиции кнопки "Настройки" на панели навигации.
 */
+ (PSSettingsBarButtonItemView *)buttonWithTarget:(id)target action:(SEL)action;

@end
