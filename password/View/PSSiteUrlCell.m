//
//  PSSiteUrlCell.m
//  password
//
//  Created by Alexander Gomzyakov on 21.03.14.
//  Copyright (c) 2014 Alexander Gomzyakov. All rights reserved.
//

#import "PSSiteUrlCell.h"

/// Высота ячейки.
static const CGFloat PSSiteUrlCellHeight = 45.0;

/// Стандартный отступ в макетной сетке нашего представления.
static const CGFloat PSSiteUrlCellOffset = 16.0;

@implementation PSSiteUrlCell

#pragma mark - Init

+ (PSSiteUrlCell *)cellWithImage
{
    CGRect        frame = CGRectMake(0.0, 0.0, 320.0, PSSiteUrlCellHeight);
    PSSiteUrlCell *cell = [[PSSiteUrlCell alloc] initWithFrame:frame];
    return cell;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = (PSSiteUrlCell *)[super initWithFrame:frame];
    if (self) {
        self.frame             = CGRectMake(0.0, 0.0, self.frame.size.width, PSSiteUrlCellHeight);
        self.contentView.frame = self.frame;

        [self makeUI];
    }
    return self;
}

#pragma mark - Helpers

+ (CGFloat)cellHeight
{
    return PSSiteUrlCellHeight;
}

#pragma mark - Make UI

- (void)makeUI
{
    self.backgroundColor = [UIColor whiteColor];
    self.selectionStyle  = UITableViewCellSelectionStyleNone;

    [self createFaviconView];
    [self createActivityIndicator];
    [self createTextField];

    [self addConstraints];
}

- (void)createFaviconView
{
    UIImageView *photoView = [[UIImageView alloc] init];
    //photoView.layer.cornerRadius                      = 2.0f;
    photoView.translatesAutoresizingMaskIntoConstraints = NO;
    photoView.contentMode                               = UIViewContentModeScaleAspectFit;

    self.faviconView = photoView;
    [self.contentView addSubview:self.faviconView];
}

- (void)createActivityIndicator
{
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityIndicator.hidesWhenStopped = YES;

    activityIndicator.translatesAutoresizingMaskIntoConstraints = NO;

    self.activityIndicator = activityIndicator;
    [self.contentView addSubview:self.activityIndicator];
}

- (void)createTextField
{
    UITextField *textField = [[UITextField alloc] init];
    textField.borderStyle              = UITextBorderStyleNone;
    textField.keyboardType             = UIKeyboardTypeURL;
    textField.returnKeyType            = UIReturnKeyDone;
    textField.clearButtonMode          = UITextFieldViewModeWhileEditing;
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    textField.autocapitalizationType   = UITextAutocapitalizationTypeNone;
    textField.autocorrectionType       = UITextAutocorrectionTypeNo;
    textField.spellCheckingType        = UITextSpellCheckingTypeNo;

    textField.translatesAutoresizingMaskIntoConstraints = NO;

    self.textField = textField;
    [self addSubview:self.textField];
}

#pragma mark - Constraints

- (void)addConstraints
{
    [self constraintFaviconView];
    [self constraintActivityIndicator];
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
                                                      constant:PSSiteUrlCellOffset]];

    // Отступаем от фавиконки
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.textField
                                                     attribute:NSLayoutAttributeTrailing
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self.faviconView
                                                     attribute:NSLayoutAttributeLeading
                                                    multiplier:1.0f
                                                      constant:-PSSiteUrlCellOffset]];

    // Отступаем от верхнего края
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.textField
                                                     attribute:NSLayoutAttributeCenterY
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterY
                                                    multiplier:1.0f
                                                      constant:0.0]];
}

- (void)constraintFaviconView
{
    // Отступаем от правого края ячейки
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.faviconView
                                                     attribute:NSLayoutAttributeTrailing
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self.contentView
                                                     attribute:NSLayoutAttributeTrailing
                                                    multiplier:1.0f
                                                      constant:-PSSiteUrlCellOffset]];

    // Располагаем фавикон по Y-центру
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.faviconView
                                                     attribute:NSLayoutAttributeCenterY
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self.contentView
                                                     attribute:NSLayoutAttributeCenterY
                                                    multiplier:1.0f
                                                      constant:0.0]];

    const CGFloat kFaviconSize = 16.0;

    // Ширина у миниатюры фото фиксированная.
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.faviconView
                                                     attribute:NSLayoutAttributeWidth
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:nil
                                                     attribute:NSLayoutAttributeNotAnAttribute
                                                    multiplier:1.0f
                                                      constant:kFaviconSize]];
    // Высота у миниатюры фото фиксированная.
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.faviconView
                                                     attribute:NSLayoutAttributeHeight
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:nil
                                                     attribute:NSLayoutAttributeNotAnAttribute
                                                    multiplier:1.0f
                                                      constant:kFaviconSize]];
}

- (void)constraintActivityIndicator
{
    // Отступаем от правого края ячейки
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.activityIndicator
                                                     attribute:NSLayoutAttributeTrailing
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self.contentView
                                                     attribute:NSLayoutAttributeTrailing
                                                    multiplier:1.0f
                                                      constant:-PSSiteUrlCellOffset * 1.5]];

    // Располагаем фавикон по Y-центру
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.activityIndicator
                                                     attribute:NSLayoutAttributeCenterY
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self.contentView
                                                     attribute:NSLayoutAttributeCenterY
                                                    multiplier:1.0f
                                                      constant:0.0]];

}

@end
