//
//  UIViewController+Utils.m
//  password
//
//  Created by Gomzyakov on 31.01.14.
//  Copyright (c) 2014 Alexander Gomzyakov. All rights reserved.
//

#import "UIViewController+Utils.h"

@implementation UIViewController (Utils)

- (BOOL)isVisible
{
    return [self isViewLoaded] && self.view.window;
}

@end
