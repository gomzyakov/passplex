//
//  PSSelectImageButton.m
//  password
//
//  Created by Gomzyakov on 04.01.14.
//  Copyright (c) 2014 Alexander Gomzyakov. All rights reserved.
//

#import "PSSelectImageButton.h"

@implementation PSSelectImageButton

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

    //// Group
    {
        //// Bezier Drawing
        UIBezierPath *bezierPath = [UIBezierPath bezierPath];
        [bezierPath moveToPoint:CGPointMake(13, 12)];
        [bezierPath addLineToPoint:CGPointMake(13, 32)];
        [bezierPath addLineToPoint:CGPointMake(33, 32)];
        [bezierPath addLineToPoint:CGPointMake(33, 12)];
        [bezierPath addLineToPoint:CGPointMake(13, 12)];
        [bezierPath closePath];
        [bezierPath moveToPoint:CGPointMake(31.64, 30.64)];
        [bezierPath addLineToPoint:CGPointMake(14.36, 30.64)];
        [bezierPath addLineToPoint:CGPointMake(14.36, 13.36)];
        [bezierPath addLineToPoint:CGPointMake(31.64, 13.36)];
        [bezierPath addLineToPoint:CGPointMake(31.64, 30.64)];
        [bezierPath closePath];
        bezierPath.miterLimit = 4;

        [color0 setFill];
        [bezierPath fill];


        //// Bezier 2 Drawing
        UIBezierPath *bezier2Path = [UIBezierPath bezierPath];
        [bezier2Path moveToPoint:CGPointMake(30.73, 27.91)];
        [bezier2Path addLineToPoint:CGPointMake(26.64, 23.82)];
        [bezier2Path addLineToPoint:CGPointMake(23.91, 26.55)];
        [bezier2Path addLineToPoint:CGPointMake(19.82, 22.45)];
        [bezier2Path addLineToPoint:CGPointMake(15.27, 27)];
        [bezier2Path addLineToPoint:CGPointMake(15.27, 29.73)];
        [bezier2Path addLineToPoint:CGPointMake(30.73, 29.73)];
        [bezier2Path addLineToPoint:CGPointMake(30.73, 27.91)];
        [bezier2Path closePath];
        bezier2Path.miterLimit = 4;

        [color0 setFill];
        [bezier2Path fill];


        //// Oval Drawing
        UIBezierPath *ovalPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(24, 17, 4, 3)];
        [color0 setFill];
        [ovalPath fill];
    }



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
