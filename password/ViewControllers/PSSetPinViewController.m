//
//  SetPinViewController.m
//  password
//
//  Created by Alexander Gomzyakov on 29.05.13.
//  Copyright (c) 2013 Alexander Gomzyakov. All rights reserved.
//

#import "PSSetPinViewController.h"
#import "PSPinGroupView.h"
#import "UIAlertView+PresentError.h"
#import "PSPinCode.h"
#import "KeychainWrapper.h"
#import "LocalizedPin.h"

@interface PSSetPinViewController () <UITextFieldDelegate>
{
    UIView *_scrollView;
    UIView *currentPanel;

    /// Субпредставление отоблажающее pin-точки.
    PSPinGroupView *setPinGroupView;

    /// Субпредставление отоблажающее pin-точки.
    PSPinGroupView *confirmPinGroupView;
}

/// Фейковое поле для ввода пин-кода.
@property (nonatomic, strong) UITextField *fakePinField;

/**
 Введенный PIN-код.
 */
@property (nonatomic, strong) NSNumber *enteredPin;

@end


static CGFloat const kPasscodePanelWidth  = 320.0;
static CGFloat const kPasscodePanelHeight = 120.0;

static CGFloat const kPasscodePanelOne = 0.0;
static CGFloat const kPasscodePanelTwo = -320.0;

@implementation PSSetPinViewController

@synthesize currentPanel;

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self makeUI];

    [self switchPanel:kPasscodePanelOne];
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

    self.fakePinField.text = @"";
    [self.fakePinField becomeFirstResponder];

    [setPinGroupView fillClear];
    [confirmPinGroupView fillClear];
}

#pragma mark - Actions

- (void)actionDone
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Public methods

- (void)switchPanel:(NSInteger)panelTag
{
    CGRect rect = _scrollView.frame;

    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    [_scrollView setFrame:CGRectMake(panelTag, rect.origin.y, rect.size.width, rect.size.height)];
    [UIView commitAnimations];

    currentPanel = (UIView *)[_scrollView viewWithTag:panelTag];

    [setPinGroupView fillClear];
    [confirmPinGroupView fillClear];
}

- (BOOL)prevPanel
{
    NSInteger tag = [currentPanel tag];
    if (tag != 0) {
        [self switchPanel:tag + kPasscodePanelWidth];
        return TRUE;
    }
    return FALSE;
}

- (BOOL)nextPanel
{
    NSInteger tag = [currentPanel tag];
    if (tag != -640) {
        [self switchPanel:tag - kPasscodePanelWidth];
        return TRUE;
    }
    return FALSE;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *passcode = textField.text;
    passcode = [passcode stringByReplacingCharactersInRange:range withString:string];

    /// Количество введенных пользователем чисел
    NSInteger enteredPinCount = passcode.length;

    if (enteredPinCount <= 4) {
        NSUInteger fillPins = enteredPinCount;
        [setPinGroupView fillPinsBefore:fillPins];

        if (enteredPinCount == 4) {
            // Запоминаем введенный PIN-код и запрашиваем его подтверждение
            self.enteredPin = [NSNumber numberWithInteger:passcode.integerValue];
            NSLog(@"Entered pin: %d", self.enteredPin.integerValue);
            [self nextPanel];
        }
        return YES;
    } else {
        NSUInteger fillPins = enteredPinCount - 4;
        [confirmPinGroupView fillPinsBefore:fillPins];

        if (enteredPinCount == 8) {
            NSString *lastFourChars = [passcode substringWithRange:NSMakeRange(4, passcode.length - 4)];
            NSNumber *confirmedPin  = [NSNumber numberWithInteger:lastFourChars.integerValue];
            NSLog(@"Confirmed pin: %d", confirmedPin.integerValue);

            if (self.enteredPin.integerValue == confirmedPin.integerValue) {
                NSLog(@"User entered PIN");

                // Генерим хэш пин-кода для последующего сохранения в NSUserDefaults
                NSString *pinHashString = [KeychainWrapper securedSHA256DigestHashForPIN:confirmedPin.integerValue];
                NSLog(@"** Password Hash - %@", pinHashString);

                // Сохраняем хэш пин-кода в keychain (NEVER store the direct PIN)
                if ([KeychainWrapper createKeychainValue:pinHashString forIdentifier:PIN_SAVED]) {
                    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:PIN_SAVED];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                    NSLog(@"** Key saved successfully to Keychain!!");
                }

                [self actionDone];
            } else {
                [self prevPanel];

                NSString    *message = [LocalizedPin alertMessageIncorrectPasscodeConfirmation];
                UIAlertView *alert   = [UIAlertView errorAlertWithMessage:message];
                [alert show];
            }

        }
        return YES;
    }

    return NO;
}

#pragma mark - Make UI

- (void)makeUI
{
    self.title = [LocalizedPin viewTitleSetPin];

    CGFloat colorComponente = 240.0 / 256.0;
    self.view.backgroundColor = [UIColor colorWithRed:colorComponente green:colorComponente blue:colorComponente alpha:1.0];

    [self createFakeTextField];

    // Create Panel One
    CGRect setPanelFrame = CGRectMake(0.0, 0.0, kPasscodePanelWidth, kPasscodePanelHeight);
    UIView *setPanelView = [self createSetPanelWithXOffset:0.0 tagIndex:kPasscodePanelOne];

    // Create Panel Two
    CGFloat confirmPanelXOffset = setPanelFrame.size.width;
    UIView  *confirmPanelView   = [self createConfirmPanelWithXOffset:confirmPanelXOffset tagIndex:kPasscodePanelTwo];

    static NSInteger const kPasscodePanelCount = 2;

    CGRect frm = CGRectMake(0.0, 32.0, kPasscodePanelWidth * kPasscodePanelCount, kPasscodePanelHeight);
    _scrollView = [[UILabel alloc] initWithFrame:frm];
    [_scrollView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:_scrollView];

    [_scrollView addSubview:setPanelView];
    [_scrollView addSubview:confirmPanelView];

    if (self.isVisibleCancelButton) {
        UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(actionDone)];
        self.navigationItem.leftBarButtonItem = cancelButton;
    }
}

- (UIView *)createSetPanelWithXOffset:(CGFloat)offsetX tagIndex:(NSInteger)tagIndex
{
    CGRect rect = CGRectMake(offsetX, 0.0, kPasscodePanelWidth, kPasscodePanelHeight);

    UIView *panelView = [[UIView alloc] initWithFrame:rect];
    [panelView setTag:tagIndex];
    [panelView setBounds:rect];
    panelView.backgroundColor = [UIColor clearColor];

    CGRect  labelFrame = CGRectMake(rect.origin.x, 0.0, CGRectGetWidth(rect), 30.0);
    UILabel *label     = [[UILabel alloc] initWithFrame:labelFrame];
    label.font            = [UIFont systemFontOfSize:17.0];
    label.textAlignment   = NSTextAlignmentCenter;
    label.textColor       = [UIColor colorWithRed:66.0 / 255.0 green:85.0 / 255.0 blue:102.0 / 255.0 alpha:1.0];
    label.backgroundColor = [UIColor clearColor];
    [panelView addSubview:label];

    label.text = [LocalizedPin viewTitleEnterPin];

    setPinGroupView = [PSPinGroupView groupFour];
    CGFloat pinGroupX     = (CGRectGetWidth(rect) - CGRectGetWidth(setPinGroupView.frame)) / 2;
    CGFloat pinGroupY     = label.frame.origin.y + label.frame.size.height + 24.0;
    CGRect  pinGroupFrame = CGRectMake(pinGroupX, pinGroupY, setPinGroupView.frame.size.width, setPinGroupView.frame.size.height);
    setPinGroupView.frame = pinGroupFrame;

    [panelView addSubview:setPinGroupView];

    return panelView;
}

- (UIView *)createConfirmPanelWithXOffset:(CGFloat)offsetX tagIndex:(NSInteger)tagIndex
{
    CGRect rect = CGRectMake(offsetX, 0.0, kPasscodePanelWidth, kPasscodePanelHeight);

    UIView *panelView = [[UIView alloc] initWithFrame:rect];
    [panelView setTag:tagIndex];
    [panelView setBounds:rect];
    panelView.backgroundColor = [UIColor clearColor];

    CGRect  labelFrame = CGRectMake(rect.origin.x, 0.0, CGRectGetWidth(rect), 30.0);
    UILabel *label     = [[UILabel alloc] initWithFrame:labelFrame];
    label.font            = [UIFont systemFontOfSize:17.0];
    label.textAlignment   = NSTextAlignmentCenter;
    label.textColor       = [UIColor colorWithRed:66.0 / 255.0 green:85.0 / 255.0 blue:102.0 / 255.0 alpha:1.0];
    label.backgroundColor = [UIColor clearColor];
    [panelView addSubview:label];

    label.text = [LocalizedPin viewTitleConfirmPin];

    confirmPinGroupView = [PSPinGroupView groupFour];
    CGFloat pinGroupX     = (3*CGRectGetWidth(rect) - CGRectGetWidth(confirmPinGroupView.frame)) / 2;
    CGFloat pinGroupY     = label.frame.origin.y + label.frame.size.height + 24.0;
    CGRect  pinGroupFrame = CGRectMake(pinGroupX, pinGroupY, confirmPinGroupView.frame.size.width, confirmPinGroupView.frame.size.height);
    confirmPinGroupView.frame = pinGroupFrame;
    [panelView addSubview:confirmPinGroupView];

    return panelView;
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

#pragma mark - Memory management

- (void)viewDidUnload
{
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;

    _scrollView = nil;
}

@end
