//
//  CopiedView.m
//  password
//
//  Created by Alexander Gomzyakov on 03.06.13.
//  Copyright (c) 2013 Alexander Gomzyakov. All rights reserved.
//

#import "CopiedView.h"

@implementation CopiedView

+ (CopiedView *)createDefaultView
{
    CopiedView *cv = [[CopiedView alloc] initWithFrame:CGRectMake(50, 120, 220, 60)];
    return cv;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor blackColor];
        self.alpha           = 0.0f;

        [self createTitle];
    }
    return self;
}

#pragma mark - Make UI

- (void)createTitle
{
    NSString *passwordsCopiedToClipboardAlertTitle = @"";

    // create Enter PIN label
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    titleLabel.text = passwordsCopiedToClipboardAlertTitle;

    // customize title appearance
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font            = [UIFont boldSystemFontOfSize:18.0f];
    titleLabel.textColor       = [UIColor whiteColor];

    // align title by panel center
    [titleLabel sizeToFit];
    titleLabel.frame = CGRectMake((self.frame.size.width - titleLabel.frame.size.width) / 2, 20.0f, titleLabel.frame.size.width, titleLabel.frame.size.height);
    [self addSubview:titleLabel];
}

#pragma mark - Actions

- (void)show
{
    self.hidden = NO;
    [UIView animateWithDuration:0.3f
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
         self.alpha = 1.0f;
     }

                     completion:^(BOOL finished) {
         [self hide];
     }];
}

- (void)hide
{
    [UIView animateWithDuration:0.3f
                          delay:0.5f
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
         self.alpha = 0.0f;
     }

                     completion:^(BOOL finished) {
         self.hidden = YES;
     }];
}

@end
