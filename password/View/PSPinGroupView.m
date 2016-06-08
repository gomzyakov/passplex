//
//  PSPinGroupView.m
//  password
//
//  Created by Alexander Gomzyakov on 12.01.14.
//  Copyright (c) 2014 Alexander Gomzyakov. All rights reserved.
//

#import "PSPinGroupView.h"
#import "PSPinView.h"

@interface PSPinGroupView ()
{
    /// Массив представлений-точек.
    NSArray *pinViews;
}

@end


/// Расстояние между точками.
const CGFloat kDistanceBetweenPins = 24.0;


@implementation PSPinGroupView

+ (PSPinGroupView *)groupFour
{
    CGFloat pinDiameter = [PSPinView diameter];
    CGFloat groupWidth  = 4*pinDiameter + 3*kDistanceBetweenPins;
    CGFloat grounHeight = pinDiameter;
    return [[PSPinGroupView alloc] initWithFrame:CGRectMake(0.0, 0.0, groupWidth, grounHeight)];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        pinViews = @[
            [[PSPinView alloc] init],
            [[PSPinView alloc] init],
            [[PSPinView alloc] init],
            [[PSPinView alloc] init]
                   ];

        for (NSUInteger pinIndex = 0; pinIndex < pinViews.count; pinIndex++) {
            PSPinView *pinView     = pinViews[pinIndex];
            CGFloat   pinViewX     = pinIndex * ([PSPinView diameter] + kDistanceBetweenPins);
            CGRect    pinViewFrame = CGRectMake(pinViewX, 0.0, [PSPinView diameter], [PSPinView diameter]);
            pinView.frame = pinViewFrame;
            [self addSubview:pinView];
        }
    }
    return self;
}

- (void)fillPinsBefore:(NSUInteger)pinNumber
{
    for (NSUInteger pinIndex = 0; pinIndex < pinViews.count; pinIndex++) {
        PSPinView *pinView = pinViews[pinIndex];
        pinView.selected = (pinIndex + 1 <= pinNumber) ? YES : NO;
    }
}

- (void)fillClear
{
    [self fillPinsBefore:0];
}

+ (CGFloat)pinGroupHeight
{
    return [PSPinView diameter];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
