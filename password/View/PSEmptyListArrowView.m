//
//  PSEmptyListArrowView.m
//  password
//
//  Created by Gomzyakov on 04.02.14.
//  Copyright (c) 2014 Alexander Gomzyakov. All rights reserved.
//

#import "PSEmptyListArrowView.h"

@implementation PSEmptyListArrowView

+ (PSEmptyListArrowView *)arrowView
{
    CGRect frame = CGRectMake(0.0, 0.0, 87.0, 73.0);
    return [[PSEmptyListArrowView alloc] initWithFrame:frame];
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

    CGFloat width  = self.frame.size.width;
    CGFloat height = self.frame.size.height;

    CGFloat arrowHeadSize = 6.0;
    CGFloat offset        = 0.25;

    //// Bezier Drawing
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(width - arrowHeadSize - offset, 0.74)];
    [bezierPath addCurveToPoint:CGPointMake(0, height-offset) controlPoint1:CGPointMake(width - arrowHeadSize - offset, 22.84/73*(height-offset)) controlPoint2:CGPointMake(64.0/87.0*(width - arrowHeadSize - offset), height-offset)];
    bezierPath.miterLimit = 10;
    [color0 setStroke];
    bezierPath.lineWidth = 0.6;
    [bezierPath stroke];

    //// Bezier 2 Drawing
    UIBezierPath *bezier2Path = [UIBezierPath bezierPath];
    [bezier2Path moveToPoint:CGPointMake(width - arrowHeadSize - offset, 0.25)];
    [bezier2Path addLineToPoint:CGPointMake(width - 2*arrowHeadSize - offset, arrowHeadSize)];
    bezier2Path.miterLimit = 10;
    [color0 setStroke];
    bezier2Path.lineWidth = 0.8;
    [bezier2Path stroke];

    //// Bezier 3 Drawing
    UIBezierPath *bezier3Path = [UIBezierPath bezierPath];
    [bezier3Path moveToPoint:CGPointMake(width - arrowHeadSize - offset, 0.25)];
    [bezier3Path addLineToPoint:CGPointMake(width - offset, arrowHeadSize)];
    bezier3Path.miterLimit = 10;
    [color0 setStroke];
    bezier3Path.lineWidth = 0.8;
    [bezier3Path stroke];
}

@end
