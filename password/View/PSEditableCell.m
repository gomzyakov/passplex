//
//  PSEditableCell.m
//  password
//
//  Created by Gomzyakov on 04.01.14.
//  Copyright (c) 2014 Alexander Gomzyakov. All rights reserved.
//

#import "PSEditableCell.h"

/// Высота ячейки.
static const CGFloat PSEditableCellHeight = 45.0;

/// Стандартный отступ в макетной сетке нашего представления.
static const CGFloat PSEditableCellOffset = 16.0;


@interface PSEditableCell ()

@end


@implementation PSEditableCell

+ (PSEditableCell *)cell
{
    CGRect         frame = CGRectMake(0.0, 0.0, 320.0, PSEditableCellHeight);
    PSEditableCell *cell = [[PSEditableCell alloc] initWithFrame:frame];
    return cell;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = (PSEditableCell *)[super initWithFrame:frame];
    if (self) {
        self.frame             = CGRectMake(0.0, 0.0, self.frame.size.width, PSEditableCellHeight);
        self.contentView.frame = self.frame;

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

    [self createTextField];

    [self addConstraints];
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

    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.textField
                                                     attribute:NSLayoutAttributeTrailing
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeTrailing
                                                    multiplier:1.0f
                                                      constant:-PSEditableCellOffset/2]];

    // Располагаем поле ввода по Y-центру
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.textField
                                                     attribute:NSLayoutAttributeCenterY
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterY
                                                    multiplier:1.0f
                                                      constant:0.0]];
}

@end
