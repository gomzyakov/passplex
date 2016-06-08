//
//  PSSlideCellEditButton.m
//  password
//
//  Created by Alexander Gomzyakov on 26.12.13.
//  Copyright (c) 2013 Alexander Gomzyakov. All rights reserved.
//

#import "PSSlideCellButton.h"
#import "PSSlideCell.h"

@implementation PSSlideCellButton

+ (instancetype)buttonWithType:(PSSlideCellButtonType)type target:(id)target action:(SEL)action;
{
    PSSlideCellButton *button = [PSSlideCellButton buttonWithType:UIButtonTypeCustom];
    
    CGFloat const PSButtonHeight = [PSSlideCell cellHeight];
    button.frame = CGRectMake(0.0f, 0.0f, PSButtonHeight, PSButtonHeight);
    button.type  = type;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];

    switch (button.type) {
    case PSSlideCellButtonTypeEdit:
        button.backgroundColor = [UIColor colorWithRed:109.0/256.0
                                                 green:177.0/256.0
                                                  blue:83.0/256.0
                                                 alpha:1.0f];
        break;
    case PSSlideCellButtonTypeFavorite:
        button.backgroundColor = [UIColor colorWithRed:229.0/256.0
                                                 green:171.0/256.0
                                                  blue:71.0/256.0
                                                 alpha:1.0f];
        break;
    case PSSlideCellButtonTypeDelete:
        button.backgroundColor = [UIColor colorWithRed:202.0/256.0
                                                 green:39.0/256.0
                                                  blue:39.0/256.0
                                                 alpha:1.0f];
        break;
    }


    return button;
}

- (void)drawRect:(CGRect)rect
{
    switch (self.type) {
    case PSSlideCellButtonTypeEdit:
        [self drawEditIcon];
        break;
    case PSSlideCellButtonTypeFavorite:
        [self drawFavoriteIcon];
        break;
    case PSSlideCellButtonTypeDelete:
        [self drawDeleteIcon];
        break;
    default:
        // Быть не может, т.к. свойство self.type задается через перечисление.
        break;
    }
}

- (void)drawEditIcon
{
    //// Color Declarations
    UIColor *color0 = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1];

    //// Group
    {
        //// Bezier Drawing
        UIBezierPath *bezierPath = [UIBezierPath bezierPath];
        [bezierPath moveToPoint:CGPointMake(32.35, 23.06)];
        [bezierPath addLineToPoint:CGPointMake(22.03, 33.39)];
        [bezierPath addLineToPoint:CGPointMake(21, 37)];
        [bezierPath addLineToPoint:CGPointMake(24.61, 35.97)];
        [bezierPath addLineToPoint:CGPointMake(34.94, 25.65)];
        [bezierPath addLineToPoint:CGPointMake(32.35, 23.06)];
        [bezierPath closePath];
        bezierPath.miterLimit = 4;

        [color0 setFill];
        [bezierPath fill];


        //// Bezier 2 Drawing
        UIBezierPath *bezier2Path = [UIBezierPath bezierPath];
        [bezier2Path moveToPoint:CGPointMake(34.94, 21)];
        [bezier2Path addLineToPoint:CGPointMake(34.42, 21)];
        [bezier2Path addLineToPoint:CGPointMake(32.87, 22.55)];
        [bezier2Path addLineToPoint:CGPointMake(35.42, 25.19)];
        [bezier2Path addLineToPoint:CGPointMake(37, 23.58)];
        [bezier2Path addLineToPoint:CGPointMake(37, 23.06)];
        [bezier2Path addLineToPoint:CGPointMake(34.94, 21)];
        [bezier2Path closePath];
        bezier2Path.miterLimit = 4;

        [color0 setFill];
        [bezier2Path fill];
    }
}

- (void)drawFavoriteIcon
{
    //// Color Declarations
    UIColor *color0 = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1];

    //// Bezier Drawing
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(37, 26.87)];
    [bezierPath addLineToPoint:CGPointMake(30.9, 26.87)];
    [bezierPath addLineToPoint:CGPointMake(29, 21)];
    [bezierPath addLineToPoint:CGPointMake(28.5, 21)];
    [bezierPath addLineToPoint:CGPointMake(26.79, 26.87)];
    [bezierPath addLineToPoint:CGPointMake(21, 26.87)];
    [bezierPath addLineToPoint:CGPointMake(21, 27.4)];
    [bezierPath addLineToPoint:CGPointMake(25.61, 30.94)];
    [bezierPath addLineToPoint:CGPointMake(24, 36.47)];
    [bezierPath addLineToPoint:CGPointMake(24.5, 37)];
    [bezierPath addLineToPoint:CGPointMake(29, 33.54)];
    [bezierPath addLineToPoint:CGPointMake(33.5, 37)];
    [bezierPath addLineToPoint:CGPointMake(34, 36.47)];
    [bezierPath addLineToPoint:CGPointMake(32.25, 31.05)];
    [bezierPath addLineToPoint:CGPointMake(37, 27.4)];
    [bezierPath addLineToPoint:CGPointMake(37, 26.87)];
    [bezierPath closePath];
    bezierPath.miterLimit = 4;

    [color0 setFill];
    [bezierPath fill];
}

- (void)drawDeleteIcon
{
    //// Color Declarations
    UIColor *color0 = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1];

    //// Bezier Drawing
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(30.41, 29)];
    [bezierPath addLineToPoint:CGPointMake(37, 22.41)];
    [bezierPath addLineToPoint:CGPointMake(35.59, 21)];
    [bezierPath addLineToPoint:CGPointMake(29, 27.59)];
    [bezierPath addLineToPoint:CGPointMake(22.41, 21)];
    [bezierPath addLineToPoint:CGPointMake(21, 22.41)];
    [bezierPath addLineToPoint:CGPointMake(27.59, 29)];
    [bezierPath addLineToPoint:CGPointMake(21, 35.59)];
    [bezierPath addLineToPoint:CGPointMake(22.41, 37)];
    [bezierPath addLineToPoint:CGPointMake(29, 30.41)];
    [bezierPath addLineToPoint:CGPointMake(35.59, 37)];
    [bezierPath addLineToPoint:CGPointMake(37, 35.59)];
    [bezierPath addLineToPoint:CGPointMake(30.41, 29)];
    [bezierPath closePath];
    bezierPath.miterLimit = 4;

    [color0 setFill];
    [bezierPath fill];
}

@end
