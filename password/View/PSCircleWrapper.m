//
//  PSCircleWrapper.m
//  password
//
//  Created by Alexander Gomzyakov on 10.04.14.
//  Copyright (c) 2014 Alexander Gomzyakov. All rights reserved.
//

#import "PSCircleWrapper.h"

@implementation PSCircleWrapper

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor        = [UIColor clearColor];
        self.userInteractionEnabled = NO;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    //// Color Declarations
    UIColor *color = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1];

    //// Oval Drawing
    UIBezierPath *ovalPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(20, 15, 30, 30)];
    [[UIColor whiteColor] setFill];
    [ovalPath fill];
    [color setStroke];
    ovalPath.lineWidth = 1;
    [ovalPath stroke];
}

@end
