//
//  PSDoneBarButtonItemView.h
//  password
//
//  Created by Gomzyakov on 04.01.14.
//  Copyright (c) 2014 Alexander Gomzyakov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PSDoneBarButtonItemView : UIView

/**
 Возвращает простое представление для инициализиции кнопки "Done" на панели навигации.
 */
+ (PSDoneBarButtonItemView *)buttonWithTarget:(id)target action:(SEL)action;

@end
