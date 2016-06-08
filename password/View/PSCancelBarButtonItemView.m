//
//  PSCancelBarButtonItemView.m
//  password
//
//  Created by Gomzyakov on 04.01.14.
//  Copyright (c) 2014 Alexander Gomzyakov. All rights reserved.
//

#import "PSCancelBarButtonItemView.h"

@implementation PSCancelBarButtonItemView

+ (PSCancelBarButtonItemView *)buttonWithTarget:(id)target action:(SEL)action
{
    CGRect                    frame       = CGRectMake(0.0, 0.0, 40.0, 40.0);
    PSCancelBarButtonItemView *buttonView = [[PSCancelBarButtonItemView alloc] initWithFrame:frame];

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
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(21.82, 19.5)];
    [bezierPath addLineToPoint:CGPointMake(28, 13.32)];
    [bezierPath addLineToPoint:CGPointMake(26.68, 12)];
    [bezierPath addLineToPoint:CGPointMake(20.5, 18.18)];
    [bezierPath addLineToPoint:CGPointMake(14.32, 12)];
    [bezierPath addLineToPoint:CGPointMake(13, 13.32)];
    [bezierPath addLineToPoint:CGPointMake(19.18, 19.5)];
    [bezierPath addLineToPoint:CGPointMake(13, 25.68)];
    [bezierPath addLineToPoint:CGPointMake(14.32, 27)];
    [bezierPath addLineToPoint:CGPointMake(20.5, 20.82)];
    [bezierPath addLineToPoint:CGPointMake(26.68, 27)];
    [bezierPath addLineToPoint:CGPointMake(28, 25.68)];
    [bezierPath addLineToPoint:CGPointMake(21.82, 19.5)];
    [bezierPath closePath];
    bezierPath.miterLimit = 4;

    [color0 setFill];
    [bezierPath fill];
}

@end
