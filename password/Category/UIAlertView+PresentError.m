//
//  UIAlertView+PresentError.m
//  imopc
//
//  Created by Alexander Gomzyakov on 26.11.13.
//  Copyright (c) 2013 ABAK PRESS. All rights reserved.
//

#import "UIAlertView+PresentError.h"
#import "LocalizedCommon.h"

@implementation UIAlertView (PresentError)

+ (UIAlertView *)alertWithMessage:(NSString *)message
{
    return [UIAlertView alertWithTitle:nil message:message];
}

+ (UIAlertView *)errorAlertWithMessage:(NSString *)errorMessage
{
    NSString *title = [LocalizedCommon alertTitleError];
    return [UIAlertView alertWithTitle:title message:errorMessage];
}

+ (UIAlertView *)warningAlertWithMessage:(NSString *)warningMessage
{
    NSString *title = [LocalizedCommon alertTitleWarning];
    return [UIAlertView alertWithTitle:title message:warningMessage];
}

+ (UIAlertView *)alertWithTitle:(NSString *)title message:(NSString *)message
{
    NSString *okButtonTitle = [LocalizedCommon buttonTitleOK];

    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:self
                                          cancelButtonTitle:okButtonTitle
                                          otherButtonTitles:nil];

    [alert performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:NO];
    return alert;
}

@end
