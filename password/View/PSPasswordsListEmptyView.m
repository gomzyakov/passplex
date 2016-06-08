//
//  PSEmptyListView.m
//  password
//
//  Created by Gomzyakov on 04.02.14.
//  Copyright (c) 2014 Alexander Gomzyakov. All rights reserved.
//

#import "PSPasswordsListEmptyView.h"
#import "PSEmptyListKeyView.h"
#import "PSEmptyListArrowView.h"

@interface PSPasswordsListEmptyView ()

/// Метка отображающая по центру заголовок секции.
@property (nonatomic, weak) UILabel *titleLabel;

@property (nonatomic, strong) PSEmptyListKeyView *keyView;

@property (nonatomic, strong) PSEmptyListArrowView *arrowView;

@end

@implementation PSPasswordsListEmptyView

static CGFloat const kTitleFontSize = 17.0;

+ (PSPasswordsListEmptyView *)viewWithTitle:(NSString *)title
{
    return [[PSPasswordsListEmptyView alloc] initWithTitle:title];

}

- (PSPasswordsListEmptyView *)initWithTitle:(NSString *)title
{
    self = [super initWithFrame:CGRectMake(0.0, 0.0, 320.0, 320.0)];
    if (self) {
        [self makeView];
        self.titleLabel.text = title;
    }
    return self;
}

- (void)makeView
{
    self.backgroundColor = [UIColor clearColor];

    [self createKeyView];
    [self createArrowView];
    [self createTitleLabel];

    [self constraintKeyView];
    [self constraintArrowView];
    [self constraintTitleLabel];
}

#pragma mark - Create View

- (void)createTitleLabel
{
    CGFloat const kColorComponente = 162.0/255.0;

    UILabel *label = [[UILabel alloc] init];
    label.opaque                                    = NO;
    label.textAlignment                             = NSTextAlignmentCenter;
    label.font                                      = [UIFont fontWithName:@"HelveticaNeue-Light" size:kTitleFontSize];
    label.textColor                                 = [UIColor colorWithRed:kColorComponente green:kColorComponente blue:kColorComponente alpha:1.0];
    label.backgroundColor                           = [UIColor clearColor];
    label.highlightedTextColor                      = [UIColor whiteColor];
    label.lineBreakMode                             = NSLineBreakByTruncatingTail;
    label.translatesAutoresizingMaskIntoConstraints = NO;

    self.titleLabel = label;
    [self addSubview:self.titleLabel];
}

- (void)createKeyView
{
    self.keyView = [PSEmptyListKeyView keyView];
    [self addSubview:self.keyView];
}

- (void)createArrowView
{
    self.arrowView = [PSEmptyListArrowView arrowView];
    [self addSubview:self.arrowView];
}

#pragma mark - Constraint View

- (void)constraintKeyView
{
    // Высота фиксированная
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.keyView
                                                     attribute:NSLayoutAttributeHeight
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:nil
                                                     attribute:NSLayoutAttributeNotAnAttribute
                                                    multiplier:1.0f
                                                      constant:75.0]];

    // Ширина фиксированная
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.keyView
                                                     attribute:NSLayoutAttributeWidth
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:nil
                                                     attribute:NSLayoutAttributeNotAnAttribute
                                                    multiplier:1.0f
                                                      constant:75.0]];

    // Отступаем от верхнего края
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.keyView
                                                     attribute:NSLayoutAttributeTop
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeTop
                                                    multiplier:1.0f
                                                      constant:90.0]];

    // Выравниваем по Y-центру
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.keyView
                                                     attribute:NSLayoutAttributeCenterX
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterX
                                                    multiplier:1.0f
                                                      constant:0.0]];
}

- (void)constraintArrowView
{
    // Высота фиксированная
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.arrowView
                                                     attribute:NSLayoutAttributeHeight
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:nil
                                                     attribute:NSLayoutAttributeNotAnAttribute
                                                    multiplier:1.0f
                                                      constant:(90.0+75.0/2-10.0)]];

    // Отступаем от верхнего края
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.arrowView
                                                     attribute:NSLayoutAttributeTop
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeTop
                                                    multiplier:1.0f
                                                      constant:10.0]];

    // Отступаем от правого края
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.arrowView
                                                     attribute:NSLayoutAttributeTrailing
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeTrailing
                                                    multiplier:1.0f
                                                      constant:-18.0]];

    // Отступаем от ключика
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.arrowView
                                                     attribute:NSLayoutAttributeLeading
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self.keyView
                                                     attribute:NSLayoutAttributeTrailing
                                                    multiplier:1.0f
                                                      constant:0.0]];
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
                                                      constant:1.5*kTitleFontSize]];

    // Отступаем от верхнего края
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.titleLabel
                                                     attribute:NSLayoutAttributeTop
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeTop
                                                    multiplier:1.0f
                                                      constant:(90.0+75.0+20.0)]];

    // Отступаем от левого края
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.titleLabel
                                                     attribute:NSLayoutAttributeLeading
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeLeading
                                                    multiplier:1.0f
                                                      constant:10]];

    // Отступаем от правого края
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.titleLabel
                                                     attribute:NSLayoutAttributeTrailing
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeTrailing
                                                    multiplier:1.0f
                                                      constant:-10]];
}

@end
