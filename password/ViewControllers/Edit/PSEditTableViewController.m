//
//  EditViewController.m
//  password
//
//  Created by Alexander Gomzyakov on 03.06.13.
//  Copyright (c) 2013 Alexander Gomzyakov. All rights reserved.
//

#import "PSEditTableViewController.h"
#import "AppDelegate.h"
#import "PSPassword.h"
#import "PSPassword+CRUD.h"
#import "PSCancelBarButtonItemView.h"
#import "PSDoneBarButtonItemView.h"
#import "PSEditableCell.h"
#import "PSSelectImageButton.h"
#import "PSGeneratePasswordButton.h"
#import "PSSiteUrlCell.h"
#import "PSEditableCellWithButton.h"
#import "PSValidator.h"
#import "PSPasswordsGenerator.h"
#import "DSFavIconManager.h"
#import "LocalizedCommon.h"
#import "LocalizedEdit.h"

@interface PSEditTableViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>
{
    /// Массив содержащий все элементы необходимые для отображения детализированного представления (состоит из нескольких субмассивов).
    NSMutableArray *tableCells;

    NSMutableArray *mainSectionCells;
    NSMutableArray *faviconSectionCells;
    NSMutableArray *noteSectionCells;
}

@property (nonatomic, strong) PSEditableCell           *titleCell;
@property (nonatomic, strong) PSEditableCell           *usernameCell;
@property (nonatomic, strong) PSEditableCellWithButton *passwordCell;
@property (nonatomic, strong) PSSiteUrlCell            *cellSiteUrl;
@property (nonatomic, strong) UITableViewCell          *cellNote;

@property (nonatomic, strong) UITextField *titleTextField;
@property (nonatomic, strong) UITextField *usernameTextField;
@property (nonatomic, strong) UITextField *passwordTextField;
@property (nonatomic, strong) UITextField *siteUrlTextField;

@end

@implementation PSEditTableViewController

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self createArrayOfCells];
    [self makeUI];

    self.tableView.delegate   = self;
    self.tableView.dataSource = self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    if (self.password) {
        self.titleCell.textField.text    = self.password.title;
        self.usernameCell.textField.text = self.password.username;
        self.passwordCell.textField.text = self.password.password;
        self.cellSiteUrl.textField.text  = self.password.siteUrl;

        [self renewFaviconWithUrlString:self.password.siteUrl];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    // Если пользователь вводит новый пароль, сразу приступаем к редактированию первого поля. Если осуществляется
    // редактирование, мы не знаем, что будет правиться и никаких полей по умолчанию редактировать не начинаем.
    if (!self.password) {
        [self.titleTextField becomeFirstResponder];
    }
}

#pragma mark - UITableView DataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [[tableCells objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return tableCells.count;
}

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section
{
    NSMutableArray *sectionCells = [tableCells objectAtIndex:section];
    return sectionCells.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[tableCells objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    if ([cell isEqual:self.cellNote]) {
        return 0;
    }

    return [PSEditableCell cellHeight];
}

#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Ячейки не выделяются, выступая лишь в роли контейнера => Ничего не делаем
}

#pragma mark - Actions

- (void)actionDone
{
    // Удаляем пробельные символы в конце и начале полей
    self.titleCell.textField.text    = [self.titleCell.textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    self.usernameCell.textField.text = [self.usernameCell.textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    self.passwordCell.textField.text = [self.passwordCell.textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];

    if ([self isValidData]) {
        if (self.password) {
            self.password.title    = self.titleCell.textField.text;
            self.password.username = self.usernameCell.textField.text;
            self.password.password = self.passwordCell.textField.text;
#warning проверять надо
            self.password.siteUrl = self.cellSiteUrl.textField.text;
        } else {
            AppDelegate            *appDelegate = [UIApplication sharedApplication].delegate;
            NSManagedObjectContext *context     = appDelegate.managedObjectContext;

            NSDictionary *params = @{ @"title":    self.titleCell.textField.text,
                                      @"username": self.usernameCell.textField.text,
                                      @"password": self.passwordCell.textField.text,
                                      @"siteUrl":  self.cellSiteUrl.textField.text };

            PSPassword *password = [PSPassword passwordWithDictionary:params
                                                           isFavorite:[NSNumber numberWithBool:NO]
                                                            inContext:context];
            if (!password) {
                NSString *errorTitle    = [LocalizedCommon alertTitleError];
                NSString *errorMessage  = [LocalizedEdit alertMessageFailedToSavePassword];
                NSString *okAlertButton = [LocalizedCommon buttonTitleOK];

                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:errorTitle
                                                                message:errorMessage
                                                               delegate:nil
                                                      cancelButtonTitle:okAlertButton
                                                      otherButtonTitles:nil];
                [alert show];
            }
        }

        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        NSString *warningTitle  = [LocalizedCommon alertTitleWarning];
        NSString *errorMessage  = [LocalizedEdit alertMessageIncorrectlyFilledSomeFields];
        NSString *okAlertButton = [LocalizedCommon buttonTitleOK];

        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:warningTitle
                                                        message:errorMessage
                                                       delegate:nil
                                              cancelButtonTitle:okAlertButton
                                              otherButtonTitles:nil];
        [alert show];
    }
}

- (void)actionCancel
{
    self.password = nil;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)actionGeneratePassword:(UIButton *)sender
{
    NSUInteger randomPasswordLenght = 8;
    self.passwordCell.textField.text = [PSPasswordsGenerator randomPasswordWithLength:randomPasswordLenght];
}

#pragma mark - UITextFieldDelegate

/**
   При наборе URL-адреса в соответствующем поле, проверяем возможность подгрузить favicon.
 */
- (void)siteUrlTextFieldDidChange:(UITextField *)textField
{
    [self renewFaviconWithUrlString:textField.text];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.titleTextField) {
        [self.titleTextField resignFirstResponder];
        [self.usernameTextField becomeFirstResponder];
    } else if (textField == self.usernameTextField) {
        [self.usernameTextField resignFirstResponder];
        [self.passwordTextField becomeFirstResponder];
    } else if (textField == self.passwordTextField) {
        [self.passwordTextField resignFirstResponder];
        [self.siteUrlTextField becomeFirstResponder];
    } else if (textField == self.siteUrlTextField) {
        [self.siteUrlTextField resignFirstResponder];
        [self actionDone];
    }

    return YES;
}

#pragma mark - Validate

- (BOOL)isValidData
{
#warning проверять URL и примечание
    if ([PSValidator validateTitle:self.titleCell.textField.text]
        && [PSValidator validateUsername:self.usernameCell.textField.text]
        && [PSValidator validatePassword:self.passwordCell.textField.text]) {
        return YES;
    }
    return NO;
}

#pragma mark - Create Cells

/**
   Инициализирует массив идентификаторов псевдо-статических ячеек таблицы.
 */
- (void)createArrayOfCells
{
    tableCells = [NSMutableArray array];

    [self createArrayOfMainCells];
    [self createArrayOfFaviconCells];
    //[self createArrayOfNoteCells];

    if (mainSectionCells.count) {
        [tableCells addObject:mainSectionCells];
    }
    if (faviconSectionCells.count) {
        [tableCells addObject:faviconSectionCells];
    }
    if (noteSectionCells.count) {
        [tableCells addObject:noteSectionCells];
    }
}

#pragma mark - Create Cells: Main

- (void)createArrayOfMainCells
{
    mainSectionCells = [NSMutableArray array];

    [self createTitleCell];
    [self createUsernameCell];
    [self createPasswordCell];
}

- (void)createTitleCell
{
    self.titleCell = [PSEditableCell cell];

    self.titleTextField                        = self.titleCell.textField;
    self.titleTextField.placeholder            = [LocalizedEdit fieldPlaceholderTitle];
    self.titleTextField.returnKeyType          = UIReturnKeyNext;
    self.titleTextField.autocapitalizationType = UITextAutocapitalizationTypeSentences;
    self.titleTextField.autocorrectionType     = UITextAutocorrectionTypeNo;
    self.titleTextField.spellCheckingType      = UITextSpellCheckingTypeNo;
    self.titleTextField.delegate               = self;

    [mainSectionCells addObject:self.titleCell];
}

- (void)createUsernameCell
{
    self.usernameCell = [PSEditableCell cell];

    self.usernameTextField                        = self.usernameCell.textField;
    self.usernameTextField.placeholder            = [LocalizedEdit fieldPlaceholderLogin];
    self.usernameTextField.returnKeyType          = UIReturnKeyNext;
    self.usernameTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.usernameTextField.autocorrectionType     = UITextAutocorrectionTypeNo;
    self.usernameTextField.spellCheckingType      = UITextSpellCheckingTypeNo;
    self.usernameTextField.delegate               = self;

    [mainSectionCells addObject:self.usernameCell];
}

- (void)createPasswordCell
{
    CGFloat buttonHeight = 45.0;
    CGRect  buttonFrame  = CGRectMake(0, 0, buttonHeight, buttonHeight);

    PSGeneratePasswordButton *generatePasswordButton = [[PSGeneratePasswordButton alloc] initWithFrame:buttonFrame];
    [generatePasswordButton addTarget:self action:@selector(actionGeneratePassword:) forControlEvents:UIControlEventTouchUpInside];

    self.passwordCell = [PSEditableCellWithButton cellWithButton:generatePasswordButton];

    self.passwordTextField                        = self.passwordCell.textField;
    self.passwordTextField.placeholder            = [LocalizedEdit fieldPlaceholderPassword];
    self.passwordTextField.returnKeyType          = UIReturnKeyNext;
    self.passwordTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.passwordTextField.autocorrectionType     = UITextAutocorrectionTypeNo;
    self.passwordTextField.spellCheckingType      = UITextSpellCheckingTypeNo;
    self.passwordTextField.delegate               = self;

    [mainSectionCells addObject:self.passwordCell];
}

#pragma mark - Create Cells: Site Url

- (void)createArrayOfFaviconCells
{
    faviconSectionCells = [NSMutableArray array];

    [self createSiteUrlCell];
}

- (void)createSiteUrlCell
{
    self.cellSiteUrl = [PSSiteUrlCell cellWithImage];

    self.siteUrlTextField               = self.cellSiteUrl.textField;
    self.siteUrlTextField.placeholder   = [LocalizedEdit fieldPlaceholderSiteUrl];
    self.siteUrlTextField.returnKeyType = UIReturnKeyDone;
    self.siteUrlTextField.delegate      = self;

    [self.siteUrlTextField addTarget:self action:@selector(siteUrlTextFieldDidChange:) forControlEvents:UIControlEventEditingChanged];

    [faviconSectionCells addObject:self.cellSiteUrl];
}

#pragma mark - Create Cells: Note

//- (void)createArrayOfNoteCells
//{
//    NSString *exportToMailCellTitle = [PSLocalizationHandler stringForKey:@"SETTINGSVIEW_ROW_TITLE_EXPORT_TO_EMAIL"];
//
//    backupSectionCells = [NSMutableArray array];
//
//    exportToMailCell                = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
//    exportToMailCell.textLabel.text = exportToMailCellTitle;
//    [backupSectionCells addObject:exportToMailCell];
//}

#pragma mark - Make UI

- (void)makeUI
{
    NSString *editPasswordTitle = [LocalizedEdit titleEdit];
    NSString *newPasswordTitle  = [LocalizedEdit titleAdd];
    self.title = self.password ? editPasswordTitle : newPasswordTitle;

    [self createNavBarButtons];
}

/**
 Создаем кастомные кнопки Cancel и Done навигационной панели.
 */
- (void)createNavBarButtons
{
    PSCancelBarButtonItemView *cancelButtonView = [PSCancelBarButtonItemView buttonWithTarget:self action:@selector(actionCancel)];
    UIBarButtonItem           *cancelButton     = [[UIBarButtonItem alloc] initWithCustomView:cancelButtonView];
    self.navigationItem.leftBarButtonItem = cancelButton;

    PSDoneBarButtonItemView *doneButtonView = [PSDoneBarButtonItemView buttonWithTarget:self action:@selector(actionDone)];
    UIBarButtonItem         *doneButton     = [[UIBarButtonItem alloc] initWithCustomView:doneButtonView];
    self.navigationItem.rightBarButtonItem = doneButton;
}

#pragma mark - Helpers

/**
   Обновляем фавикон для указанной строки с URL-адресом.

   Зачем проверяем !self.password ? В случае, если мы редактирыем уже существующий пароль, DSFavIconManager предлагает
   нам картинку из кеша, в блок downloadHandler: не попадаем и, соответственно, выключить "змейку" не можем.
   Решение: Не показывать змейку, если производится редактирование уже существующего пароля (да, бага, но менее критичная)
 */
- (void)renewFaviconWithUrlString:(NSString *)urlString
{
    BOOL result = [[urlString lowercaseString] hasPrefix:@"http://"];

    NSString *urlStringWithHTTP;
    if (result) {
        urlStringWithHTTP = urlString;
    } else {
        urlStringWithHTTP = [NSString stringWithFormat:@"http://%@", urlString];
    }

    if ([PSValidator validateURLString:urlStringWithHTTP]) {
        NSURL *url = [NSURL URLWithString:urlStringWithHTTP];
        if ([[DSFavIconManager sharedInstance] cachedIconForURL:url]) {
            [self.cellSiteUrl.activityIndicator stopAnimating];
            self.cellSiteUrl.faviconView.image = [[DSFavIconManager sharedInstance] cachedIconForURL:url];
        } else {
            [self.cellSiteUrl.activityIndicator startAnimating];

            self.cellSiteUrl.faviconView.image = [[DSFavIconManager sharedInstance] iconForURL:url downloadHandler:^(UIImage *icon) {
                                                      [self.cellSiteUrl.activityIndicator stopAnimating];
                                                      self.cellSiteUrl.faviconView.image = icon;
                                                  }];
        }

    } else {
        [self.cellSiteUrl.activityIndicator stopAnimating];
        self.cellSiteUrl.faviconView.image = nil;
    }
}

#pragma mark - Memory management

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
