//
//  PSPinView.h
//  password
//
//  Created by Alexander Gomzyakov on 12.01.14.
//  Copyright (c) 2014 Alexander Gomzyakov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PSPinView : UIView

@property (nonatomic) BOOL selected;

/**
 Возвращает диаметр представления отображающего точку пин-кода.
 */
+ (CGFloat)diameter;

@end
