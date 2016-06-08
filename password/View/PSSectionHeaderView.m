//
//  CompaniesTableSectionHeader.m
//  imopc
//
//  Created by Alexander Gomzyakov on 14.08.13.
//  Copyright (c) 2013 ABAK PRESS. All rights reserved.
//

#import "PSSectionHeaderView.h"

@interface PSSectionHeaderView ()

/// Метка отображающая по центру заголовок секции.
@property (nonatomic, weak) UILabel *titleLabel;

@end

@implementation PSSectionHeaderView

/// Ширина представления заголовочной секции таблицы.
const CGFloat kSectionWidth = 320.0f;

/// Высота представления заголовочной секции таблицы.
const CGFloat kSectionHeight = 28.0f;

/// Размер шрифта заголовка секции.
const CGFloat kTitleFontSize = 13.0f;

/// Стандартный отступ в рамках макетной сетки.
const CGFloat kSectionOffset = 8.0f;

+ (PSSectionHeaderView *)sectionWithTitle:(NSString *)title
{
    return [[PSSectionHeaderView alloc] initHeaderWithTitle:title];
}

- (PSSectionHeaderView *)initHeaderWithTitle:(NSString *)title
{
    self = [super initWithFrame:CGRectMake(0.0, 0.0, kSectionWidth, kSectionHeight)];
    if (self) {
        [self makeView];

        self.titleLabel.text = title;
    }
    return self;
}

+ (CGFloat)sectionHeight
{
    return kSectionHeight;
}

#pragma mark - Make View

- (void)makeView
{
    const CGFloat colorComp = 242.0/256.0;
    self.backgroundColor = [UIColor colorWithRed:colorComp green:colorComp blue:colorComp alpha:1.0];

    [self createTitleLabel];
    [self constraintTitleLabel];
}

#pragma mark - Custom Acessors & Mutators

- (void)setTextAlignment:(NSTextAlignment)textAlignment
{
    self.titleLabel.textAlignment = textAlignment;
}

- (NSTextAlignment)textAlignment
{
    return self.titleLabel.textAlignment;
}

#pragma mark - Create View

- (void)createTitleLabel
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.frame                = CGRectMake(kSectionOffset, 0.0f, (kSectionWidth - 2 * kSectionOffset), kSectionHeight);
    label.opaque               = NO;
    label.textAlignment        = NSTextAlignmentCenter;
    label.font                 = [UIFont systemFontOfSize:kTitleFontSize];
    label.textColor            = [UIColor grayColor];
    label.backgroundColor      = [UIColor clearColor];
    label.highlightedTextColor = [UIColor whiteColor];
    label.lineBreakMode        = NSLineBreakByTruncatingTail;

    label.translatesAutoresizingMaskIntoConstraints = NO;

    self.titleLabel = label;
    [self addSubview:self.titleLabel];
}

- (void)constraintTitleLabel
{
    // Высота фиксированная
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.titleLabel
                                                     attribute:NSLayoutAttributeHeight
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:nil
                                                     attribute:NSLayoutAttributeNotAnAttribute
                                                    multiplier:1.0f
                                                      constant:1.5 * kTitleFontSize]];

    // Отступаем от левого края
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.titleLabel
                                                     attribute:NSLayoutAttributeLeading
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeLeading
                                                    multiplier:1.0f
                                                      constant:2 * kSectionOffset]];

    // Отступаем от правого края
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.titleLabel
                                                     attribute:NSLayoutAttributeTrailing
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeTrailing
                                                    multiplier:1.0f
                                                      constant:-2 * kSectionOffset]];

    // Выравниваем метку по Y-центру суперпредставления
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.titleLabel
                                                     attribute:NSLayoutAttributeCenterY
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterY
                                                    multiplier:1.0f
                                                      constant:0.0]];
}

@end
