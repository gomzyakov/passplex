//
//  PSPinGroupView.h
//  password
//
//  Created by Alexander Gomzyakov on 12.01.14.
//  Copyright (c) 2014 Alexander Gomzyakov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PSPinGroupView : UIView

/**
 Возвращает представление с четырьмя элементами-точками.
 */
+ (PSPinGroupView *)groupFour;

/// Количество точек из которого состоит представление.
//@property (nonatomic, readonly) NSUInteger pinCount;

/**
 Зактрашивает первые pinNumber точек.

 @note Если pinNumber больше общего количества точек, закрашивает все точки.
 @param pinNumber Количество точек которое необходимо закрасить (включительно)
 */
- (void)fillPinsBefore:(NSUInteger)pinNumber;

/**
 Чистит заливку всех точек представления, ни одна точка не закрашена.
 */
- (void)fillClear;

+ (CGFloat)pinGroupHeight;

@end
