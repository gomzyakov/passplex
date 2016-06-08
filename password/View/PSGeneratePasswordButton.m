//
//  PSGeneratePasswordButton.m
//  password
//
//  Created by Alexander Gomzyakov on 11.01.14.
//  Copyright (c) 2014 Alexander Gomzyakov. All rights reserved.
//

#import "PSGeneratePasswordButton.h"

@implementation PSGeneratePasswordButton

@synthesize selected = _selected;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected
{
    if (_selected != selected) {
        _selected = selected;
        [self setNeedsDisplay];
    }
}

- (void)drawRect:(CGRect)rect
{
    //	if (_selected) {
    //// Color Declarations
    UIColor *color0 = [UIColor colorWithRed:0.53 green:0.53 blue:0.53 alpha:1];

    //// Bezier Drawing
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(24.12, 18.37)];
    [bezierPath addCurveToPoint:CGPointMake(24.5, 16.25) controlPoint1:CGPointMake(24.36, 17.71) controlPoint2:CGPointMake(24.5, 17)];
    [bezierPath addCurveToPoint:CGPointMake(18.25, 10) controlPoint1:CGPointMake(24.5, 12.8) controlPoint2:CGPointMake(21.7, 10)];
    [bezierPath addCurveToPoint:CGPointMake(12, 16.25) controlPoint1:CGPointMake(14.8, 10) controlPoint2:CGPointMake(12, 12.8)];
    [bezierPath addCurveToPoint:CGPointMake(18.25, 22.5) controlPoint1:CGPointMake(12, 19.7) controlPoint2:CGPointMake(14.8, 22.5)];
    [bezierPath addCurveToPoint:CGPointMake(20.37, 22.12) controlPoint1:CGPointMake(19, 22.5) controlPoint2:CGPointMake(19.71, 22.36)];
    [bezierPath addLineToPoint:CGPointMake(22.42, 24.17)];
    [bezierPath addLineToPoint:CGPointMake(24.92, 24.17)];
    [bezierPath addLineToPoint:CGPointMake(24.92, 26.67)];
    [bezierPath addLineToPoint:CGPointMake(25.33, 27.08)];
    [bezierPath addLineToPoint:CGPointMake(27.83, 27.08)];
    [bezierPath addLineToPoint:CGPointMake(27.83, 29.58)];
    [bezierPath addLineToPoint:CGPointMake(28.25, 30)];
    [bezierPath addLineToPoint:CGPointMake(31.58, 30)];
    [bezierPath addLineToPoint:CGPointMake(32, 29.58)];
    [bezierPath addLineToPoint:CGPointMake(32, 26.25)];
    [bezierPath addLineToPoint:CGPointMake(24.12, 18.37)];
    [bezierPath closePath];
    [bezierPath moveToPoint:CGPointMake(16.37, 16.25)];
    [bezierPath addCurveToPoint:CGPointMake(14.5, 14.38) controlPoint1:CGPointMake(15.34, 16.25) controlPoint2:CGPointMake(14.5, 15.41)];
    [bezierPath addCurveToPoint:CGPointMake(16.37, 12.5) controlPoint1:CGPointMake(14.5, 13.34) controlPoint2:CGPointMake(15.34, 12.5)];
    [bezierPath addCurveToPoint:CGPointMake(18.25, 14.38) controlPoint1:CGPointMake(17.41, 12.5) controlPoint2:CGPointMake(18.25, 13.34)];
    [bezierPath addCurveToPoint:CGPointMake(16.37, 16.25) controlPoint1:CGPointMake(18.25, 15.41) controlPoint2:CGPointMake(17.41, 16.25)];
    [bezierPath closePath];
    bezierPath.miterLimit = 4;

    [color0 setFill];
    [bezierPath fill];

    //	}
    //	else
    //	{
    //		//// Color Declarations
    //		UIColor* color3 = [UIColor colorWithRed: 0.5 green: 0.5 blue: 0.5 alpha: 1];
    //
    //		//// Bezier 2 Drawing
    //		UIBezierPath* bezier2Path = [UIBezierPath bezierPath];
    //		[bezier2Path moveToPoint: CGPointMake(22.42, 29.85)];
    //		[bezier2Path addLineToPoint: CGPointMake(29.74, 37.17)];
    //		[bezier2Path addLineToPoint: CGPointMake(41.58, 25.33)];
    //		bezier2Path.usesEvenOddFillRule = YES;
    //
    //		[color3 setStroke];
    //		bezier2Path.lineWidth = 1;
    //		[bezier2Path stroke];
    //	}
}

@end
