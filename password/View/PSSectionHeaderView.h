//
//  CompaniesTableSectionHeader.h
//  imopc
//
//  Created by Alexander Gomzyakov on 14.08.13.
//  Copyright (c) 2013 ABAK PRESS. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
   Кастомное представление заголовка секции таблицы.
 */
@interface PSSectionHeaderView : UIView

@property (nonatomic) NSTextAlignment textAlignment;

+ (PSSectionHeaderView *)sectionWithTitle:(NSString *)title;

/**
   Возвращает высоту представления заголовка секции таблицы.
   @return Высота преставления заголовка секции таблицы.
 */
+ (CGFloat)sectionHeight;

@end
