//
//  SettingsViewController.m
//  password
//
//  Created by Alexander Gomzyakov on 03.06.13.
//  Copyright (c) 2013 Alexander Gomzyakov. All rights reserved.
//

#import "PSSettingsTableViewController.h"
#import <MessageUI/MessageUI.h>
#import "AppDelegate.h"
#import "PSSetPinViewController.h"
#import "LocalizedSettings.h"
#import "PSCancelBarButtonItemView.h"
#import "PSPassword+CRUD.h"
#import "LocalizedCommon.h"

@interface PSSettingsTableViewController () <UITableViewDataSource, UITableViewDelegate, UIActionSheetDelegate, MFMailComposeViewControllerDelegate>
{
    /// Массив содержащий все элементы необходимые для отображения детализированного представления (состоит из нескольких субмассивов).
    NSMutableArray *tableCells;

    /// Субмассив ячеек основной секции
    NSMutableArray *commonSectionCells;

    /// Субмассив ячеек секции резервного копирования списка паролей
    NSMutableArray *backupSectionCells;

    UITableViewCell *changePasscodeCell;
    UITableViewCell *deleteAllItemsCell;
    UITableViewCell *exportToMailCell;
}

/// Указатель на контроллер представления установки PIN-кода.
@property (nonatomic, strong) UINavigationController *setPinNavigationController;

@end

static NSUInteger const PSAlertButtonDeleteAllItemsIndex = 1;

@implementation PSSettingsTableViewController

static NSString *cellIdentifier;

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self makeUI];

    [self initArrayOfCells];
}

#pragma mark - Actions

- (void)actionDone
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)actionChangePasscode
{
    [self presentViewController:self.setPinNavigationController animated:YES completion:nil];
}

- (void)actionDeleteAllItems
{
    AppDelegate            *appDelegate = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context     = appDelegate.managedObjectContext;

    [PSPassword deleteAllPasswordsInContext:context];

    // Если пользователь удалил все пароли, скорее всего он не хочет больше
    // капаться в настройках, поэтому закрываем экран Settings.
    [self actionDone];
}

- (void)actionExport
{
    AppDelegate            *appDelegate = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context     = appDelegate.managedObjectContext;

    NSData *exportData = [PSPassword dataToExportInContext:context];
    if (!exportData) {
        NSLog(@"Export fail!");
        return;
    }

    // Формируем название файла бэкапа вида passwords-backup-04072014.pplx
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMddyyyy"];
    NSString        *stringFromDate = [formatter stringFromDate:[NSDate date]];
    NSString *const kExportFilename = [NSString stringWithFormat:@"passplex-%@.pplx", stringFromDate];

    if ([MFMailComposeViewController canSendMail]) {

        MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
        [picker setSubject:[LocalizedSettings emailBackupTitle]];
        [picker addAttachmentData:exportData mimeType:@"application/passwords-backup" fileName:kExportFilename];
        [picker setToRecipients:[NSArray array]];
        [picker setMessageBody:[LocalizedSettings emailBackupMessage] isHTML:NO];
        [picker setMailComposeDelegate:self];
        [self presentViewController:picker animated:YES completion:nil];
    } else {
        NSString    *alertTitle    = [LocalizedCommon alertTitleWarning];
        NSString    *alertMessage  = [LocalizedSettings alertMessageEmailPrepareError];
        NSString    *okButtonTitle = [LocalizedCommon buttonTitleOK];
        UIAlertView *message       = [[UIAlertView alloc] initWithTitle:alertTitle message:alertMessage delegate:nil cancelButtonTitle:okButtonTitle otherButtonTitles:nil];
        [message show];
    }
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITableViewDataSource

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
    if ([[tableCells objectAtIndex:section] isEqual:commonSectionCells]) {
        return commonSectionCells.count;
    } else if ([[tableCells objectAtIndex:section] isEqual:backupSectionCells]) {
        return backupSectionCells.count;
    }

    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];

    if ([cell isEqual:exportToMailCell]) {
        [self actionExport];
    } else if ([cell isEqual:deleteAllItemsCell]) {
        NSString *title                = [LocalizedCommon alertTitleWarning];
        NSString *message              = [LocalizedSettings alertMessageRemoveAllPasswords];
        NSString *removeAllButtonTitle = [LocalizedSettings buttonTitleRemoveAllPasswords];
        NSString *cancelButtonTitle    = [LocalizedCommon buttonTitleCancel];

        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:cancelButtonTitle otherButtonTitles:removeAllButtonTitle, nil];
        [alert show];
    } else if ([cell isEqual:changePasscodeCell]) {
        [self actionChangePasscode];
    }
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == PSAlertButtonDeleteAllItemsIndex) {
        [self actionDeleteAllItems];
    }
}

#pragma mark - Make UI

- (void)makeUI
{
    self.title = [LocalizedSettings viewTitle];

    [self createNavBarButtons];

    PSSetPinViewController *setPinViewController = [[PSSetPinViewController alloc] init];
    setPinViewController.isVisibleCancelButton                = YES;
    self.setPinNavigationController                           = [[UINavigationController alloc] initWithRootViewController:setPinViewController];
    self.setPinNavigationController.navigationBar.barStyle    = UIBarStyleDefault;
    self.setPinNavigationController.navigationBar.translucent = NO;

}

- (void)createNavBarButtons
{
    PSCancelBarButtonItemView *cancelButtonView = [PSCancelBarButtonItemView buttonWithTarget:self action:@selector(actionDone)];
    UIBarButtonItem           *cancelButton     = [[UIBarButtonItem alloc] initWithCustomView:cancelButtonView];
    self.navigationItem.leftBarButtonItem = cancelButton;
}

#pragma mark - Init Static Cells

/**
 Инициализирует массив идентификаторов псевдо-статических ячеек таблицы.
 */
- (void)initArrayOfCells
{
    tableCells = [NSMutableArray array];

    [self initArrayOfCommonCells];
    [self initArrayOfBaskupCells];

    if (commonSectionCells.count) [tableCells addObject:commonSectionCells];
    if (backupSectionCells.count) [tableCells addObject:backupSectionCells];
}

- (void)initArrayOfCommonCells
{
    NSString *changePinRowTitle       = [LocalizedSettings cellTitleChangePin];
    NSString *deleteAllItemsCellTitle = [LocalizedSettings cellTitleDeleteAllPasswords];

    commonSectionCells = [NSMutableArray array];

    changePasscodeCell                = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    changePasscodeCell.textLabel.text = changePinRowTitle;
    [commonSectionCells addObject:changePasscodeCell];

    deleteAllItemsCell                = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    deleteAllItemsCell.textLabel.text = deleteAllItemsCellTitle;
    [commonSectionCells addObject:deleteAllItemsCell];
}

- (void)initArrayOfBaskupCells
{
    NSString *exportToMailCellTitle = [LocalizedSettings cellTitleExportToEmail];

    backupSectionCells = [NSMutableArray array];

    exportToMailCell                = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    exportToMailCell.textLabel.text = exportToMailCellTitle;
    [backupSectionCells addObject:exportToMailCell];
}

#pragma mark - Memory Management

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
