//
//  PSPasswordsTableViewController.m
//  password
//
//  Created by Alexander Gomzyakov on 13.12.13.
//  Copyright (c) 2013 Alexander Gomzyakov. All rights reserved.
//

#import "PSPasswordsTableViewController.h"
#import "AppDelegate.h"
#import "PSPinViewController.h"
#import "PSSettingsTableViewController.h"
#import "PSEditTableViewController.h"
#import "PSSectionHeaderView.h"
#import "PSSlideCell.h"
#import "CopiedView.h"
#import "PSSettingsBarButtonItemView.h"
#import "PSPasswordsListEmptyView.h"
#import "PSPassword+CRUD.h"
#import "PSPassword.h"
#import "UIViewController+Utils.h"
#import "NSArray+Sort.h"
#import "UIAlertView+PresentError.h"
#import "LocalizedPasswordsList.h"
#import "LocalizedCommon.h"

@interface PSPasswordsTableViewController () <UITableViewDelegate, UITableViewDataSource, PSSlideCellDelegate, UIAlertViewDelegate, UISearchDisplayDelegate>
{
    NSMutableArray *searchData;

    UISearchBar               *searchBar;
    UISearchDisplayController *searchDisplayController;
}

/// Список избранных паролей.
@property (strong, nonatomic) NSArray *favoritePasswords;

/// Список паролей не вошедших в избранные.
@property (strong, nonatomic) NSArray *otherPasswords;

/// Плашка с подсказкой, отображаемая если в списке нет ни одного пароля.
@property (nonatomic, strong) PSPasswordsListEmptyView *emptyListView;

@end

static NSUInteger const PSTableViewSectionFavoritePasswords = 0;

static NSUInteger const PSImportAlertButtonIndexImport = 1;

@implementation PSPasswordsTableViewController

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    // если не задан мастер-пароль, запрашиваем его

    // Pop up the 'enter password/pin' thing *only if* they've set a password yet, also keep into account enterfg vs becomeactive
    //if ([Password passwordHasBeenSet]) {
    if (YES) {
        //[self.window.rootViewController dismissModalViewControllerAnimated:NO]; // Close any modals just in case one's already open, because if so then the password entry wouldn't open. I think it's one-modal-at-a-time?
        //[self presentPinEntryModal];
    }

    searchData = [[NSMutableArray alloc] init];

    [self makeUI];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;

    // Если имеются данные для импорта резервной копии и представление ввода пин-кода скрыто,
    // спрашиваем пользователя не хочет ли он эти данные импортировать.
    if ([appDelegate.pinViewController isVisible] && appDelegate.importedData) {
        NSString *title             = [LocalizedCommon alertTitleWarning];
        NSString *message           = [LocalizedPasswordsList alertMessageImport];
        NSString *importButtonTitle = [LocalizedCommon buttonTitleImport];
        NSString *cancelButtonTitle = [LocalizedCommon buttonTitleCancel];

        UIAlertView *importAlertView = [[UIAlertView alloc] initWithTitle:title
                                                                  message:message
                                                                 delegate:self
                                                        cancelButtonTitle:cancelButtonTitle
                                                        otherButtonTitles:importButtonTitle, nil];
        [importAlertView show];
    }

    [self readPasswordsFromCD];
    [self refreshTable];
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == PSImportAlertButtonIndexImport) {
        [self actionImportData];
    }
}

- (void)alertViewCancel:(UIAlertView *)alertView
{
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    appDelegate.importedData = nil;
}

#pragma mark - Actions

- (void)actionPresentSettingsView
{
    PSSettingsTableViewController *settingsViewController = [[PSSettingsTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    UINavigationController        *navController          = [[UINavigationController alloc] initWithRootViewController:settingsViewController];
    [self presentViewController:navController animated:YES completion:nil];
}

- (void)actionPresentAddPasswordView
{
    PSEditTableViewController *editViewController = [[PSEditTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    UINavigationController    *navController      = [[UINavigationController alloc] initWithRootViewController:editViewController];
    [self presentViewController:navController animated:YES completion:nil];
}

/**
   При импорте списка паролей заменяем записи в локальном хранилище и обновляем
   табличное представление списка паролей.
 */
- (void)actionImportData
{
    AppDelegate            *appDelegate = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context     = appDelegate.managedObjectContext;

    [PSPassword importPasswordsFromData:appDelegate.importedData inContext:context];
    appDelegate.importedData = nil;

    [self readPasswordsFromCD];
    [self refreshTable];
}

#pragma mark - UITableView DataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";

    NSUInteger section = [indexPath section];
    NSUInteger row     = [indexPath row];

    PSPassword  *password;
    PSSlideCell *cell;

    if (tableView == self.searchDisplayController.searchResultsTableView) {
        password = searchData[row];

        cell          = [[PSSlideCell alloc] initWithPassword:password reuseIdentifier:CellIdentifier];
        cell.delegate = self;
    } else {
        if (self.favoritePasswords.count && section == PSTableViewSectionFavoritePasswords) {
            password = self.favoritePasswords[row];
        } else {
            password = self.otherPasswords[row];
        }

        cell          = [[PSSlideCell alloc] initWithPassword:password reuseIdentifier:CellIdentifier];
        cell.delegate = self;
    }

    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return 1;
    } else {
        if (self.favoritePasswords.count > 0 && self.otherPasswords.count > 0) {
            return 2;
        } else if (self.otherPasswords.count || self.favoritePasswords.count) {
            return 1;
        } else {
            return 0;
        }
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return searchData.count;
    } else {
        if (self.favoritePasswords.count && section == PSTableViewSectionFavoritePasswords) {
            return self.favoritePasswords.count;
        } else {
            // Имеются только обычные пароли, избранных нет
            return self.otherPasswords.count;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [PSSlideCell cellHeight];
}

#pragma mark - UITableView Delegate


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Нажатия перехватываются самой ячейкой, поэтому ничего не делаем.
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    PSSectionHeaderView *headerView;

    if (self.favoritePasswords.count) {
        if (section == PSTableViewSectionFavoritePasswords) {
            NSString *message = [LocalizedPasswordsList sectionTitleFavorite];
            headerView = [PSSectionHeaderView sectionWithTitle:message];
        } else {
            NSString *message = [LocalizedPasswordsList sectionTitleOther];
            headerView = [PSSectionHeaderView sectionWithTitle:message];
        }
    }

    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.favoritePasswords.count) {
        return [PSSectionHeaderView sectionHeight];
    } else {
        return CGFLOAT_MIN;
    }
}

#pragma mark - UISearchDisplayDelegate

/**
   Выборку по паролям делаем очень простым образом: склеиваем избранные и обычные пароли, пробегаемся по полному списку
   и выбираем удовлетворяющие критерию поискового запроса. Записей врядли будет очень много (в пределах тысячи, чаще всего),
   поэтому полный перебор не даст критичной просадки по скорости.
 */
- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [searchData removeAllObjects];

    NSMutableArray *originalData = [self.favoritePasswords arrayByAddingObjectsFromArray:self.otherPasswords].mutableCopy;

    for (PSPassword *password in originalData) {
        NSString *title    = password.title;
        NSString *username = password.username;

        NSRange rangeInTitle = [title rangeOfString:searchString
                                            options:NSCaseInsensitiveSearch];
        NSRange rangeInUsername = [username rangeOfString:searchString
                                                  options:NSCaseInsensitiveSearch];
        if (rangeInTitle.location != NSNotFound || rangeInUsername.location != NSNotFound) {
            [searchData addObject:password];
        }
    }

    return YES;
}

- (void)searchDisplayController:(UISearchDisplayController *)controller didLoadSearchResultsTableView:(UITableView *)tableView
{
    tableView.rowHeight = [PSSlideCell cellHeight];
}

#pragma mark - PSSlideCellDelegate

/**
   При нажатии на ячейку копируем пароль в буфер обмена и показываем алерт.
 */
- (void)slideCellDidSingleTap:(PSSlideCell *)slideCell
{
    NSString *pas = slideCell.password.password;

    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    [pasteboard setPersistent:YES];
    [pasteboard setString:pas];

    NSString    *message       = [LocalizedPasswordsList alertMessagePasswordCopied];
    NSString    *okButtonTitle = [LocalizedCommon buttonTitleOK];
    UIAlertView *alert         = [[UIAlertView alloc] initWithTitle:nil message:message delegate:nil cancelButtonTitle:okButtonTitle otherButtonTitles:nil];
    [alert show];
}

- (void)slideCellDidDoubleTap:(PSSlideCell *)slideCell
{
    NSString *login = slideCell.password.username;

    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    [pasteboard setPersistent:YES];
    [pasteboard setString:login];

    NSString    *message       = [LocalizedPasswordsList alertMessageUsernameCopied];
    NSString    *okButtonTitle = [LocalizedCommon buttonTitleOK];
    UIAlertView *alert         = [[UIAlertView alloc] initWithTitle:nil message:message delegate:nil cancelButtonTitle:okButtonTitle otherButtonTitles:nil];
    [alert show];
}

/**
   Обрабатывает нажатие на кнопку удаления чейки.
 */
- (void)cellDidSelectDelete:(PSSlideCell *)cell
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    NSLog(@"delete %d %d", indexPath.section, indexPath.row);

#warning рефакторить
    // Удаляем пароль из массива в котором мы его прихранили
    if (self.favoritePasswords.count && self.otherPasswords.count) {
        if (indexPath.section == 0) {
            NSMutableArray *mutableFavoritePasswords = self.favoritePasswords.mutableCopy;
            [mutableFavoritePasswords removeObjectAtIndex:indexPath.row];
            self.favoritePasswords = mutableFavoritePasswords;
        } else {
            NSMutableArray *mutableOtherPasswords = self.otherPasswords.mutableCopy;
            [mutableOtherPasswords removeObjectAtIndex:indexPath.row];
            self.otherPasswords = mutableOtherPasswords;
        }
    } else if (self.favoritePasswords.count == 0 && self.otherPasswords.count) {

        NSMutableArray *mutableOtherPasswords = self.otherPasswords.mutableCopy;
        [mutableOtherPasswords removeObjectAtIndex:indexPath.row];
        self.otherPasswords = mutableOtherPasswords;

    } else if (self.favoritePasswords.count && self.otherPasswords.count == 0) {

        NSMutableArray *mutableFavoritePasswords = self.favoritePasswords.mutableCopy;
        [mutableFavoritePasswords removeObjectAtIndex:indexPath.row];
        self.favoritePasswords = mutableFavoritePasswords;

    }

    // Удалаяем непосредственно управляемый объект пароля
    AppDelegate            *appDelegate = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context     = appDelegate.managedObjectContext;

    PSPassword *password = cell.password;
    [password deleteInContext:context];

    // Визуализируем удаление ячейки с паролем
#warning Вылетает на элементе с IndexPath(0, 0)
//    [self.tableView beginUpdates];
//    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
//    [self.tableView endUpdates];

    [self refreshTable];
}

- (void)cellDidSelectEdit:(PSSlideCell *)cell;
{
    PSEditTableViewController *editViewController = [[PSEditTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    editViewController.password = cell.password;

    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:editViewController];

    [self presentViewController:navController animated:YES completion:nil];
}

- (void)cellDidSelectFavorite:(PSSlideCell *)cell;
{
    PSPassword *password = cell.password;
    NSString   *message;

    if (password.isFavorite.boolValue) {
        password.isFavorite = [NSNumber numberWithBool:NO];
        message             = [LocalizedPasswordsList alertMessageRemovedFromFavorites];
    } else {
        password.isFavorite = [NSNumber numberWithBool:YES];
        message             = [LocalizedPasswordsList alertMessageAddedToFavorite];
    }

    [self readPasswordsFromCD];
    [self.tableView reloadData];

    UIAlertView *alert = [UIAlertView alertWithMessage:message];
    [alert show];
}

#pragma mark - Helpers

/**
   Читает списки паролей из CD и сохраняет их в массивах.
 */
- (void)readPasswordsFromCD
{
    AppDelegate            *appDelegate = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context     = appDelegate.managedObjectContext;

    NSArray *unsortedFavoritePasswords = [PSPassword fetchPasswordsFavoriteList:YES inContext:context];
    self.favoritePasswords = [unsortedFavoritePasswords arraySortedByTitleProperty];

    NSArray *unsortedOtherPasswords = [PSPassword fetchPasswordsFavoriteList:NO inContext:context];
    self.otherPasswords = [unsortedOtherPasswords arraySortedByTitleProperty];
}

/**
 Обновляем таблицу. Если паролей в списке нет, показываем подсказку.
 */
- (void)refreshTable
{
    // Если список паролей пуст, показываем представление-подсказку, предлагающее добавить первый пароль.
    if (self.favoritePasswords.count == 0 && self.otherPasswords.count == 0) {
        self.tableView.separatorColor = [UIColor clearColor];
        self.emptyListView.hidden     = NO;
        [self hideSearchControls];
    } else {
        self.tableView.separatorColor = [UIColor lightGrayColor];
        self.emptyListView.hidden     = YES;
        [self showSearchControls];
    }

    [self.tableView reloadData];
}

- (void)showSearchControls
{
    searchBar.hidden = NO;
//    self.tableView.tableHeaderView = searchBar;
//    [self.tableView setContentOffset:CGPointMake(0, searchBar.frame.size.height)];
}

- (void)hideSearchControls
{
    searchBar.hidden = YES;
//    self.tableView.tableHeaderView = nil;
//    [self.tableView setContentOffset:CGPointZero];
}

#pragma mark - Make UI

- (void)makeUI
{
    self.navigationItem.title = [LocalizedPasswordsList title];

    self.tableView.delegate   = self;
    self.tableView.dataSource = self;

    [self createNavBarButtons];
    [self createSearchDisplayController];

    NSString *emptyPasswordListMessage = [LocalizedPasswordsList tableMessageEmptyPasswordList];
    self.emptyListView = [PSPasswordsListEmptyView viewWithTitle:emptyPasswordListMessage];
    [self.view addSubview:self.emptyListView];
}

- (void)createSearchDisplayController
{
    searchBar = [[UISearchBar alloc] init];

    searchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:searchBar contentsController:self];

    searchDisplayController.delegate                = self;
    searchDisplayController.searchResultsDataSource = self;

    self.tableView.tableHeaderView = searchBar;
}

- (void)createNavBarButtons
{
    // Кнопка настроек
    PSSettingsBarButtonItemView *settingsButtonView = [PSSettingsBarButtonItemView buttonWithTarget:self action:@selector(actionPresentSettingsView)];
    UIBarButtonItem             *settingsButton     = [[UIBarButtonItem alloc] initWithCustomView:settingsButtonView];
    self.navigationItem.leftBarButtonItem = settingsButton;

    // Кнопка навигационной панели для добавления пароля
    UIBarButtonItem *addPasswordButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(actionPresentAddPasswordView)];
    self.navigationItem.rightBarButtonItem = addPasswordButton;
}

#pragma mark - Memory management

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
