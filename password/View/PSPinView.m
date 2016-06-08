//
//  PSPinView.m
//  password
//
//  Created by Alexander Gomzyakov on 12.01.14.
//  Copyright (c) 2014 Alexander Gomzyakov. All rights reserved.
//

#import "PSPinView.h"

const CGFloat PSPinViewDiameter = 20.0;

@implementation PSPinView

- (PSPinView *)init
{
    return [[PSPinView alloc] initWithFrame:CGRectMake(0.0, 0.0, PSPinViewDiameter, PSPinViewDiameter)];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}

- (void)setSelected:(BOOL)selected
{
    _selected = selected;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    //// Color Declarations
    UIColor *color = [UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1];

    //// Oval Drawing
    UIBezierPath *ovalPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0.5, 0.5, 19, 19)];

    if (_selected) {
        [ovalPath fill];
    }

    [color setStroke];
    ovalPath.lineWidth = 1;
    [ovalPath stroke];
}

+ (CGFloat)diameter
{
    return PSPinViewDiameter;
}

@end
