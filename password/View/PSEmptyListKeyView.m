//
//  PSEmptyListKeyView.m
//  password
//
//  Created by Gomzyakov on 04.02.14.
//  Copyright (c) 2014 Alexander Gomzyakov. All rights reserved.
//

#import "PSEmptyListKeyView.h"

@implementation PSEmptyListKeyView

+ (PSEmptyListKeyView *)keyView
{
    const CGFloat kSize = 75.0f;
    CGRect        frame = CGRectMake(0.0, 0.0, kSize, kSize);
    return [[PSEmptyListKeyView alloc] initWithFrame:frame];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor                           = [UIColor clearColor];
        self.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    //// Color Declarations
    UIColor *color0 = [UIColor colorWithRed:0.633 green:0.633 blue:0.633 alpha:1];
    UIColor *color2 = [UIColor colorWithRed:1 green:1 blue:1 alpha:1];

    //// Group 4
    {
        //// Group 2
        {
            //// Bezier 4 Drawing
            UIBezierPath *bezier4Path = [UIBezierPath bezierPath];
            [bezier4Path moveToPoint:CGPointMake(37.5, 0.5)];
            [bezier4Path addCurveToPoint:CGPointMake(74.5, 37.5) controlPoint1:CGPointMake(57.9, 0.5) controlPoint2:CGPointMake(74.5, 17.1)];
            [bezier4Path addCurveToPoint:CGPointMake(37.5, 74.5) controlPoint1:CGPointMake(74.5, 57.9) controlPoint2:CGPointMake(57.9, 74.5)];
            [bezier4Path addCurveToPoint:CGPointMake(0.5, 37.5) controlPoint1:CGPointMake(17.1, 74.5) controlPoint2:CGPointMake(0.5, 57.9)];
            [bezier4Path addCurveToPoint:CGPointMake(37.5, 0.5) controlPoint1:CGPointMake(0.5, 17.1) controlPoint2:CGPointMake(17.1, 0.5)];
            [bezier4Path closePath];
            [bezier4Path moveToPoint:CGPointMake(37.5, 0)];
            [bezier4Path addCurveToPoint:CGPointMake(0, 37.5) controlPoint1:CGPointMake(16.79, 0) controlPoint2:CGPointMake(0, 16.79)];
            [bezier4Path addCurveToPoint:CGPointMake(37.5, 75) controlPoint1:CGPointMake(0, 58.21) controlPoint2:CGPointMake(16.79, 75)];
            [bezier4Path addCurveToPoint:CGPointMake(75, 37.5) controlPoint1:CGPointMake(58.21, 75) controlPoint2:CGPointMake(75, 58.21)];
            [bezier4Path addCurveToPoint:CGPointMake(37.5, 0) controlPoint1:CGPointMake(75, 16.79) controlPoint2:CGPointMake(58.21, 0)];
            [bezier4Path addLineToPoint:CGPointMake(37.5, 0)];
            [bezier4Path closePath];
            bezier4Path.miterLimit = 10;

            [color0 setFill];
            [bezier4Path fill];
        }


        //// Group 3
        {
            //// Bezier 5 Drawing
            UIBezierPath *bezier5Path = [UIBezierPath bezierPath];
            [bezier5Path moveToPoint:CGPointMake(51.44, 58.25)];
            [bezier5Path addLineToPoint:CGPointMake(50.69, 57.5)];
            [bezier5Path addLineToPoint:CGPointMake(50.69, 51.98)];
            [bezier5Path addLineToPoint:CGPointMake(45.1, 51.98)];
            [bezier5Path addLineToPoint:CGPointMake(44.34, 51.23)];
            [bezier5Path addLineToPoint:CGPointMake(44.34, 45.71)];
            [bezier5Path addLineToPoint:CGPointMake(38.76, 45.71)];
            [bezier5Path addLineToPoint:CGPointMake(34.27, 41.27)];
            [bezier5Path addLineToPoint:CGPointMake(34.12, 41.33)];
            [bezier5Path addCurveToPoint:CGPointMake(29.59, 42.12) controlPoint1:CGPointMake(32.64, 41.85) controlPoint2:CGPointMake(31.12, 42.12)];
            [bezier5Path addCurveToPoint:CGPointMake(16.25, 28.93) controlPoint1:CGPointMake(22.24, 42.12) controlPoint2:CGPointMake(16.25, 36.21)];
            [bezier5Path addCurveToPoint:CGPointMake(29.59, 15.75) controlPoint1:CGPointMake(16.25, 21.66) controlPoint2:CGPointMake(22.24, 15.75)];
            [bezier5Path addCurveToPoint:CGPointMake(42.93, 28.93) controlPoint1:CGPointMake(36.95, 15.75) controlPoint2:CGPointMake(42.93, 21.66)];
            [bezier5Path addCurveToPoint:CGPointMake(42.12, 33.42) controlPoint1:CGPointMake(42.93, 30.45) controlPoint2:CGPointMake(42.66, 31.95)];
            [bezier5Path addLineToPoint:CGPointMake(42.07, 33.57)];
            [bezier5Path addLineToPoint:CGPointMake(59.24, 50.54)];
            [bezier5Path addLineToPoint:CGPointMake(59.24, 57.5)];
            [bezier5Path addLineToPoint:CGPointMake(58.48, 58.25)];
            [bezier5Path addLineToPoint:CGPointMake(51.44, 58.25)];
            [bezier5Path closePath];
            [bezier5Path moveToPoint:CGPointMake(25.51, 20.63)];
            [bezier5Path addCurveToPoint:CGPointMake(21.18, 24.91) controlPoint1:CGPointMake(23.12, 20.63) controlPoint2:CGPointMake(21.18, 22.55)];
            [bezier5Path addCurveToPoint:CGPointMake(25.51, 29.2) controlPoint1:CGPointMake(21.18, 27.27) controlPoint2:CGPointMake(23.12, 29.2)];
            [bezier5Path addCurveToPoint:CGPointMake(29.84, 24.91) controlPoint1:CGPointMake(27.9, 29.2) controlPoint2:CGPointMake(29.84, 27.27)];
            [bezier5Path addCurveToPoint:CGPointMake(25.51, 20.63) controlPoint1:CGPointMake(29.84, 22.55) controlPoint2:CGPointMake(27.9, 20.63)];
            [bezier5Path closePath];
            bezier5Path.miterLimit = 10;

            [color2 setFill];
            [bezier5Path fill];


            //// Bezier 6 Drawing
            UIBezierPath *bezier6Path = [UIBezierPath bezierPath];
            [bezier6Path moveToPoint:CGPointMake(29.59, 16)];
            [bezier6Path addCurveToPoint:CGPointMake(42.68, 28.93) controlPoint1:CGPointMake(36.81, 16) controlPoint2:CGPointMake(42.68, 21.8)];
            [bezier6Path addCurveToPoint:CGPointMake(41.89, 33.33) controlPoint1:CGPointMake(42.68, 30.42) controlPoint2:CGPointMake(42.41, 31.9)];
            [bezier6Path addLineToPoint:CGPointMake(41.78, 33.63)];
            [bezier6Path addLineToPoint:CGPointMake(42, 33.86)];
            [bezier6Path addLineToPoint:CGPointMake(58.99, 50.65)];
            [bezier6Path addLineToPoint:CGPointMake(58.99, 57.4)];
            [bezier6Path addLineToPoint:CGPointMake(58.38, 58)];
            [bezier6Path addLineToPoint:CGPointMake(51.55, 58)];
            [bezier6Path addLineToPoint:CGPointMake(50.94, 57.4)];
            [bezier6Path addLineToPoint:CGPointMake(50.94, 52.23)];
            [bezier6Path addLineToPoint:CGPointMake(50.94, 51.73)];
            [bezier6Path addLineToPoint:CGPointMake(50.43, 51.73)];
            [bezier6Path addLineToPoint:CGPointMake(45.21, 51.73)];
            [bezier6Path addLineToPoint:CGPointMake(44.6, 51.13)];
            [bezier6Path addLineToPoint:CGPointMake(44.6, 45.96)];
            [bezier6Path addLineToPoint:CGPointMake(44.6, 45.46)];
            [bezier6Path addLineToPoint:CGPointMake(44.09, 45.46)];
            [bezier6Path addLineToPoint:CGPointMake(38.86, 45.46)];
            [bezier6Path addLineToPoint:CGPointMake(34.56, 41.21)];
            [bezier6Path addLineToPoint:CGPointMake(34.33, 40.98)];
            [bezier6Path addLineToPoint:CGPointMake(34.03, 41.09)];
            [bezier6Path addCurveToPoint:CGPointMake(29.59, 41.87) controlPoint1:CGPointMake(32.58, 41.61) controlPoint2:CGPointMake(31.09, 41.87)];
            [bezier6Path addCurveToPoint:CGPointMake(16.51, 28.93) controlPoint1:CGPointMake(22.38, 41.87) controlPoint2:CGPointMake(16.51, 36.07)];
            [bezier6Path addCurveToPoint:CGPointMake(29.59, 16) controlPoint1:CGPointMake(16.51, 21.8) controlPoint2:CGPointMake(22.38, 16)];
            [bezier6Path closePath];
            [bezier6Path moveToPoint:CGPointMake(25.51, 29.45)];
            [bezier6Path addCurveToPoint:CGPointMake(30.1, 24.91) controlPoint1:CGPointMake(28.04, 29.45) controlPoint2:CGPointMake(30.1, 27.41)];
            [bezier6Path addCurveToPoint:CGPointMake(25.51, 20.38) controlPoint1:CGPointMake(30.1, 22.41) controlPoint2:CGPointMake(28.04, 20.38)];
            [bezier6Path addCurveToPoint:CGPointMake(20.93, 24.91) controlPoint1:CGPointMake(22.98, 20.38) controlPoint2:CGPointMake(20.93, 22.41)];
            [bezier6Path addCurveToPoint:CGPointMake(25.51, 29.45) controlPoint1:CGPointMake(20.93, 27.41) controlPoint2:CGPointMake(22.98, 29.45)];
            [bezier6Path closePath];
            [bezier6Path moveToPoint:CGPointMake(29.59, 15.5)];
            [bezier6Path addCurveToPoint:CGPointMake(16, 28.93) controlPoint1:CGPointMake(22.09, 15.5) controlPoint2:CGPointMake(16, 21.51)];
            [bezier6Path addCurveToPoint:CGPointMake(29.59, 42.37) controlPoint1:CGPointMake(16, 36.36) controlPoint2:CGPointMake(22.09, 42.37)];
            [bezier6Path addCurveToPoint:CGPointMake(34.2, 41.56) controlPoint1:CGPointMake(31.21, 42.37) controlPoint2:CGPointMake(32.76, 42.08)];
            [bezier6Path addLineToPoint:CGPointMake(38.65, 45.96)];
            [bezier6Path addLineToPoint:CGPointMake(44.09, 45.96)];
            [bezier6Path addLineToPoint:CGPointMake(44.09, 51.34)];
            [bezier6Path addLineToPoint:CGPointMake(45, 52.23)];
            [bezier6Path addLineToPoint:CGPointMake(50.43, 52.23)];
            [bezier6Path addLineToPoint:CGPointMake(50.43, 57.61)];
            [bezier6Path addLineToPoint:CGPointMake(51.34, 58.5)];
            [bezier6Path addLineToPoint:CGPointMake(58.59, 58.5)];
            [bezier6Path addLineToPoint:CGPointMake(59.49, 57.61)];
            [bezier6Path addLineToPoint:CGPointMake(59.49, 50.44)];
            [bezier6Path addLineToPoint:CGPointMake(42.36, 33.5)];
            [bezier6Path addCurveToPoint:CGPointMake(43.18, 28.93) controlPoint1:CGPointMake(42.88, 32.07) controlPoint2:CGPointMake(43.18, 30.54)];
            [bezier6Path addCurveToPoint:CGPointMake(29.59, 15.5) controlPoint1:CGPointMake(43.18, 21.51) controlPoint2:CGPointMake(37.1, 15.5)];
            [bezier6Path addLineToPoint:CGPointMake(29.59, 15.5)];
            [bezier6Path closePath];
            [bezier6Path moveToPoint:CGPointMake(25.51, 28.95)];
            [bezier6Path addCurveToPoint:CGPointMake(21.43, 24.91) controlPoint1:CGPointMake(23.26, 28.95) controlPoint2:CGPointMake(21.43, 27.14)];
            [bezier6Path addCurveToPoint:CGPointMake(25.51, 20.88) controlPoint1:CGPointMake(21.43, 22.68) controlPoint2:CGPointMake(23.26, 20.88)];
            [bezier6Path addCurveToPoint:CGPointMake(29.59, 24.91) controlPoint1:CGPointMake(27.77, 20.88) controlPoint2:CGPointMake(29.59, 22.68)];
            [bezier6Path addCurveToPoint:CGPointMake(25.51, 28.95) controlPoint1:CGPointMake(29.59, 27.14) controlPoint2:CGPointMake(27.77, 28.95)];
            [bezier6Path addLineToPoint:CGPointMake(25.51, 28.95)];
            [bezier6Path closePath];
            bezier6Path.miterLimit = 10;

            [color0 setFill];
            [bezier6Path fill];
        }
    }
}

@end
