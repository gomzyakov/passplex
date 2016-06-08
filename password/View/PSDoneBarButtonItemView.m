//
//  PSDoneBarButtonItemView.m
//  password
//
//  Created by Gomzyakov on 04.01.14.
//  Copyright (c) 2014 Alexander Gomzyakov. All rights reserved.
//

#import "PSDoneBarButtonItemView.h"

@implementation PSDoneBarButtonItemView

+ (PSDoneBarButtonItemView *)buttonWithTarget:(id)target action:(SEL)action
{
    CGRect                  frame       = CGRectMake(0.0, 0.0, 40.0, 40.0);
    PSDoneBarButtonItemView *buttonView = [[PSDoneBarButtonItemView alloc] initWithFrame:frame];

    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:target
                                                                                 action:action];
    [buttonView addGestureRecognizer:tapGesture];

    return buttonView;
}

- (instancetype)initWithFrame:(CGRect)frame
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
    [bezierPath moveToPoint:CGPointMake(28.03, 14.5)];
    [bezierPath addLineToPoint:CGPointMake(18.31, 24.5)];
    [bezierPath addLineToPoint:CGPointMake(12.97, 19)];
    [bezierPath addLineToPoint:CGPointMake(12, 20)];
    [bezierPath addLineToPoint:CGPointMake(18.31, 26.5)];
    [bezierPath addLineToPoint:CGPointMake(29, 15.5)];
    [bezierPath addLineToPoint:CGPointMake(28.03, 14.5)];
    [bezierPath closePath];
    bezierPath.miterLimit = 4;

    [color0 setFill];
    [bezierPath fill];
}

@end
