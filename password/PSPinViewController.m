//
//  EnterPinViewController.h
//  password
//
//  Created by Alexander Gomzyakov on 28.05.13.
//  Copyright (c) 2013 Alexander Gomzyakov. All rights reserved.
//

#import "PSPinViewController.h"
#import "PSPinGroupView.h"
#import "UIAlertView+PresentError.h"
#import "PSPinCode.h"
#import "KeychainWrapper.h"
#import "LocalizedPin.h"

@interface PSPinViewController () <UITextFieldDelegate>
{
    /// Субпредставление отоблажающее pin-точки.
    PSPinGroupView *pinGroupView;
}

/// Фейковое поле для ввода пин-кода.
@property (nonatomic, strong) UITextField *fakePinField;

@end

@implementation PSPinViewController

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self makeUI];
}

/**
 Учитывая то, что экран ввода PIN-кода может отображаться несколько раз, а инициализируется
 единожды в AppDelegate, при каждом его отображении необходимо:
 - Занулит "точки" ввода пин-кода
 - Почистить фейковое поле ввода и сделать его активным
 */
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self resetPinEntering];
}

- (void)resetPinEntering
{
    self.fakePinField.text = @"";
    [pinGroupView fillClear];
    [self.fakePinField becomeFirstResponder];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *passcode = textField.text;
    passcode = [passcode stringByReplacingCharactersInRange:range withString:string];

    // Количество введенных пользователем чисел
    NSInteger enteredPinCount = passcode.length;

    if (enteredPinCount <= 4) {
        [pinGroupView fillPinsBefore:enteredPinCount];

        if (enteredPinCount == 4) {
            // Проверяем введенный пин-код на корректность
            if ([KeychainWrapper compareKeychainValueForMatchingPIN:passcode.integerValue]) {
                [self dismissViewControllerAnimated:YES completion:nil];
            } else {
                [self performSelector:@selector(resetPinEntering) withObject:self afterDelay:0.3];

                NSString    *message = [LocalizedPin alertMessagePasscodeIsEnteredIncorrectly];
                UIAlertView *alert   = [UIAlertView errorAlertWithMessage:message];
                [alert show];
            }
            return NO;

        }
        return YES;
    }
    return NO;
}

#pragma mark - Make UI

- (void)makeUI
{
    CGFloat colorComponente = 240.0 / 256.0;
    self.view.backgroundColor = [UIColor colorWithRed:colorComponente green:colorComponente blue:colorComponente alpha:1.0];

    [self createPinGroup];
    [self createFakeTextField];
}

/**
 Создает группу pin-точек и размещает её на основном представлении.
 */
- (void)createPinGroup
{
    pinGroupView = [PSPinGroupView groupFour];
    CGFloat pinGroupX     = (CGRectGetWidth(self.view.frame) - CGRectGetWidth(pinGroupView.frame)) / 2;
    CGFloat pinGroupY     = 176.0;
    CGRect  pinGroupFrame = CGRectMake(pinGroupX, pinGroupY, pinGroupView.frame.size.width, pinGroupView.frame.size.height);
    pinGroupView.frame = pinGroupFrame;
    [self.view addSubview:pinGroupView];
}

/**
 Создаем поле для ввода PIN-кода. Не отображается на экране.
 */
- (void)createFakeTextField
{
    UITextField *fakePinField = [[UITextField alloc] initWithFrame:CGRectZero];
    fakePinField.delegate        = self;
    fakePinField.hidden          = YES;
    fakePinField.secureTextEntry = YES;
    fakePinField.keyboardType    = UIKeyboardTypeNumberPad;
    self.fakePinField            = fakePinField;
    [self.view addSubview:self.fakePinField];
}

@end
