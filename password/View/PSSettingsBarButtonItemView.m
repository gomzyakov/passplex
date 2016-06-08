//
//  PSSettingsBarButtonItemView.m
//  password
//
//  Created by Alexander Gomzyakov on 24.12.13.
//  Copyright (c) 2013 Alexander Gomzyakov. All rights reserved.
//

#import "PSSettingsBarButtonItemView.h"

@implementation PSSettingsBarButtonItemView

+ (PSSettingsBarButtonItemView *)buttonWithTarget:(id)target action:(SEL)action
{
    CGRect                      frame       = CGRectMake(0.0, 0.0, 31.0, 31.0);
    PSSettingsBarButtonItemView *buttonView = [[PSSettingsBarButtonItemView alloc] initWithFrame:frame];

    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:target
                                                                                 action:action];
    [buttonView addGestureRecognizer:tapGesture];

    return buttonView;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    //// Color Declarations
    UIColor *color0 = [UIColor colorWithRed:66.0/256.0 green:118.0/256.0 blue:245.0/256.0 alpha:1];

    //// Bezier Drawing
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(25, 15.87)];
    [bezierPath addLineToPoint: CGPointMake(25, 14.13)];
    [bezierPath addLineToPoint: CGPointMake(22.61, 14.13)];
    [bezierPath addCurveToPoint: CGPointMake(21.29, 10.94) controlPoint1: CGPointMake(22.46, 12.94) controlPoint2: CGPointMake(21.99, 11.85)];
    [bezierPath addLineToPoint: CGPointMake(22.98, 9.25)];
    [bezierPath addLineToPoint: CGPointMake(21.75, 8.02)];
    [bezierPath addLineToPoint: CGPointMake(20.06, 9.71)];
    [bezierPath addCurveToPoint: CGPointMake(16.87, 8.39) controlPoint1: CGPointMake(19.15, 9.01) controlPoint2: CGPointMake(18.06, 8.54)];
    [bezierPath addLineToPoint: CGPointMake(16.87, 6)];
    [bezierPath addLineToPoint: CGPointMake(15.13, 6)];
    [bezierPath addLineToPoint: CGPointMake(15.13, 8.39)];
    [bezierPath addCurveToPoint: CGPointMake(11.94, 9.71) controlPoint1: CGPointMake(13.94, 8.54) controlPoint2: CGPointMake(12.85, 9.01)];
    [bezierPath addLineToPoint: CGPointMake(10.25, 8.02)];
    [bezierPath addLineToPoint: CGPointMake(9.02, 9.25)];
    [bezierPath addLineToPoint: CGPointMake(10.71, 10.94)];
    [bezierPath addCurveToPoint: CGPointMake(9.39, 14.13) controlPoint1: CGPointMake(10.01, 11.85) controlPoint2: CGPointMake(9.54, 12.94)];
    [bezierPath addLineToPoint: CGPointMake(7, 14.13)];
    [bezierPath addLineToPoint: CGPointMake(7, 15.87)];
    [bezierPath addLineToPoint: CGPointMake(9.39, 15.87)];
    [bezierPath addCurveToPoint: CGPointMake(10.71, 19.06) controlPoint1: CGPointMake(9.54, 17.06) controlPoint2: CGPointMake(10.01, 18.15)];
    [bezierPath addLineToPoint: CGPointMake(9.02, 20.75)];
    [bezierPath addLineToPoint: CGPointMake(10.25, 21.98)];
    [bezierPath addLineToPoint: CGPointMake(11.94, 20.29)];
    [bezierPath addCurveToPoint: CGPointMake(15.13, 21.61) controlPoint1: CGPointMake(12.85, 20.99) controlPoint2: CGPointMake(13.94, 21.46)];
    [bezierPath addLineToPoint: CGPointMake(15.13, 24)];
    [bezierPath addLineToPoint: CGPointMake(16.87, 24)];
    [bezierPath addLineToPoint: CGPointMake(16.87, 21.61)];
    [bezierPath addCurveToPoint: CGPointMake(20.06, 20.29) controlPoint1: CGPointMake(18.06, 21.46) controlPoint2: CGPointMake(19.15, 20.99)];
    [bezierPath addLineToPoint: CGPointMake(21.75, 21.98)];
    [bezierPath addLineToPoint: CGPointMake(22.98, 20.75)];
    [bezierPath addLineToPoint: CGPointMake(21.29, 19.06)];
    [bezierPath addCurveToPoint: CGPointMake(22.61, 15.87) controlPoint1: CGPointMake(21.99, 18.15) controlPoint2: CGPointMake(22.46, 17.06)];
    [bezierPath addLineToPoint: CGPointMake(25, 15.87)];
    [bezierPath closePath];
    [bezierPath moveToPoint: CGPointMake(16, 19.94)];
    [bezierPath addCurveToPoint: CGPointMake(11.06, 15) controlPoint1: CGPointMake(13.27, 19.94) controlPoint2: CGPointMake(11.06, 17.73)];
    [bezierPath addCurveToPoint: CGPointMake(16, 10.06) controlPoint1: CGPointMake(11.06, 12.27) controlPoint2: CGPointMake(13.27, 10.06)];
    [bezierPath addCurveToPoint: CGPointMake(20.94, 15) controlPoint1: CGPointMake(18.73, 10.06) controlPoint2: CGPointMake(20.94, 12.27)];
    [bezierPath addCurveToPoint: CGPointMake(16, 19.94) controlPoint1: CGPointMake(20.94, 17.73) controlPoint2: CGPointMake(18.73, 19.94)];
    [bezierPath closePath];
    bezierPath.miterLimit = 4;

    [color0 setFill];
    [bezierPath fill];
}

@end
