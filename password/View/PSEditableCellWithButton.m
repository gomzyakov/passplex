//
//  PSEditableCellWithButton.m
//  password
//
//  Created by Alexander Gomzyakov on 08.04.14.
//  Copyright (c) 2014 Alexander Gomzyakov. All rights reserved.
//

#import "PSEditableCellWithButton.h"

/// Высота ячейки.
static const CGFloat PSEditableCellHeight = 45.0;

/// Стандартный отступ в макетной сетке нашего представления.
static const CGFloat PSEditableCellOffset = 16.0;


@interface PSEditableCellWithButton ()

/// Кнопка располагаемая в правой части ячейки.
@property (nonatomic) UIButton *button;

@end


@implementation PSEditableCellWithButton

+ (instancetype)cellWithButton:(UIButton *)button
{
    CGRect                   frame = CGRectMake(0.0, 0.0, 320.0, PSEditableCellHeight);
    PSEditableCellWithButton *cell = [[PSEditableCellWithButton alloc] initWithFrame:frame button:button];
    return cell;
}

- (instancetype)initWithFrame:(CGRect)frame button:(UIButton *)button
{
    self = (PSEditableCellWithButton *)[super initWithFrame:frame];
    if (self) {
        self.frame             = CGRectMake(0.0, 0.0, self.frame.size.width, PSEditableCellHeight);
        self.contentView.frame = self.frame;

        // Кнопку присваиваем раньше, чем создаем представление, т.к. от ее наличия зависит расположение элементов.
        self.button = button;

        [self makeUI];
    }
    return self;
}

#pragma mark - Helpers

+ (CGFloat)cellHeight
{
    return PSEditableCellHeight;
}

#pragma mark - Make UI

- (void)makeUI
{
    self.backgroundColor = [UIColor whiteColor];
    self.selectionStyle  = UITableViewCellSelectionStyleNone;

    [self createButton];
    [self createTextField];

    [self addConstraints];
}

- (void)createButton
{
    if (self.button) {
        self.button.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:self.button];
    }
}

- (void)createTextField
{
    UITextField *textField = [[UITextField alloc] init];
    textField.borderStyle              = UITextBorderStyleNone;
    textField.keyboardType             = UIKeyboardTypeDefault;
    textField.returnKeyType            = UIReturnKeyDone;
    textField.clearButtonMode          = UITextFieldViewModeWhileEditing;
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    textField.autocapitalizationType   = UITextAutocapitalizationTypeNone;
    textField.autocorrectionType       = UITextAutocorrectionTypeNo;
    textField.spellCheckingType        = UITextSpellCheckingTypeNo;

    textField.translatesAutoresizingMaskIntoConstraints = NO;

    self.textField = textField;
    [self.contentView addSubview:self.textField];
}

#pragma mark - Constraints

- (void)addConstraints
{
    [self constraintButton];
    [self constraintTextField];
}

- (void)constraintTextField
{
    // Отступаем от левого края
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.textField
                                                     attribute:NSLayoutAttributeLeading
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeLeading
                                                    multiplier:1.0f
                                                      constant:PSEditableCellOffset]];

    // Отступаем от фавиконки
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.textField
                                                     attribute:NSLayoutAttributeTrailing
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self.button
                                                     attribute:NSLayoutAttributeLeading
                                                    multiplier:1.0f
                                                      constant:0.0]];

    // Располагаем поле ввода по Y-центру
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.textField
                                                     attribute:NSLayoutAttributeCenterY
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterY
                                                    multiplier:1.0f
                                                      constant:0.0]];
}

- (void)constraintButton
{
    if (self.button) {
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.button
                                                         attribute:NSLayoutAttributeTrailing
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self.contentView
                                                         attribute:NSLayoutAttributeTrailing
                                                        multiplier:1.0f
                                                          constant:0.0]];

        // Располагаем кнопку по Y-центру
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.button
                                                         attribute:NSLayoutAttributeCenterY
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self.contentView
                                                         attribute:NSLayoutAttributeCenterY
                                                        multiplier:1.0f
                                                          constant:0.0]];

        const CGFloat kButtonSize = 45.0;

        // Ширина у миниатюры фото фиксированная.
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.button
                                                         attribute:NSLayoutAttributeWidth
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:nil
                                                         attribute:NSLayoutAttributeNotAnAttribute
                                                        multiplier:1.0f
                                                          constant:kButtonSize]];
        // Высота у миниатюры фото фиксированная.
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.button
                                                         attribute:NSLayoutAttributeHeight
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:nil
                                                         attribute:NSLayoutAttributeNotAnAttribute
                                                        multiplier:1.0f
                                                          constant:kButtonSize]];
    }
}

@end
