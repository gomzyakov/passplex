//
//  SetPinViewController.h
//  password
//
//  Created by Alexander Gomzyakov on 29.05.13.
//  Copyright (c) 2013 Alexander Gomzyakov. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PSSetPinViewController : UIViewController

@property (nonatomic, readonly) UIView *currentPanel;

/**
 YES, если необходимо показывать кнопку Cancel
 @note Кнопка Cancel отображается в случае, если пользователь по собственному
 желанию решил сменить пин-код через настройки.
 */
@property (nonatomic) BOOL isVisibleCancelButton;

- (BOOL)prevPanel;
- (BOOL)nextPanel;

@end
