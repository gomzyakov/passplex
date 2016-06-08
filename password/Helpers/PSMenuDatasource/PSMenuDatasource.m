//
//  PCMenuDatasource.m
//  imopc
//
//  Created by Alexander Gomzyakov on 21.01.14.
//  Copyright (c) 2014 ABAK PRESS. All rights reserved.
//

#import "PSMenuDatasource.h"

@interface PSMenuDatasource ()

@property (nonatomic, strong) NSMutableArray      *sectionKeys;
@property (nonatomic, strong) NSMutableDictionary *sectionRowTitles;
@property (nonatomic, strong) NSMutableDictionary *sectionIconFilenames;
@property (nonatomic, strong) NSMutableDictionary *sectionViewControllers;

@end

@implementation PSMenuDatasource

- (id)init
{
    self = [super init];
    if (self) {
        NSMutableArray      *keys                   = [NSMutableArray array];
        NSMutableDictionary *contents               = [NSMutableDictionary dictionary];
        NSMutableDictionary *sectionIconFilenames   = [NSMutableDictionary dictionary];
        NSMutableDictionary *sectionViewControllers = [NSMutableDictionary dictionary];

        self.sectionKeys            = keys;
        self.sectionRowTitles       = contents;
        self.sectionIconFilenames   = sectionIconFilenames;
        self.sectionViewControllers = sectionViewControllers;
    }
    return self;
}

- (NSUInteger)numberOfSections
{
    return self.sectionKeys.count;
}

- (NSUInteger)numberOfRowsInSectionWithTitle:(NSString *)sectionTitle
{
    if ([self.sectionRowTitles objectForKey:sectionTitle]) {
        NSMutableArray *sectionContent = [self.sectionRowTitles objectForKey:sectionTitle];
        return sectionContent.count;
    } else {
        return NSNotFound;
    }
}

- (NSUInteger)numberOfRowsInSectionWithIndex:(NSUInteger)sectionIndex
{
    NSString *sectionTitle = [self titleForSectionWithIndex:sectionIndex];
    return [self numberOfRowsInSectionWithTitle:sectionTitle];
}

- (BOOL)insertSectionWithHeaderTitle:(NSString *)sectionTitle
{
    if (sectionTitle != nil && sectionTitle.length > 0 && sectionTitle.length < 256) {
        [self.sectionKeys addObject:sectionTitle];
        return YES;
    }
    return NO;
}

- (BOOL)insertRowWithTitle:(NSString *)rowTitle iconFilename:(NSString *)iconFilename viewController:(UIViewController *)viewController inSectionWithIndex:(NSUInteger)sectionIndex
{
    NSString *sectionTitle = [self titleForSectionWithIndex:sectionIndex];
    return [self insertRowWithTitle:rowTitle iconFilename:iconFilename viewController:viewController inSectionWithTitle:sectionTitle];
}

- (BOOL)insertRowWithTitle:(NSString *)rowTitle iconFilename:(NSString *)iconFilename viewController:(UIViewController *)viewController inSectionWithTitle:(NSString *)sectionTitle
{
    if ([self validateRowTitle:rowTitle]
        && [self validateIconFilename:iconFilename]
        && [self validateViewController:viewController]
        && [self validateSectionTitle:sectionTitle]) {
        // Добавляем заголовки элементов меню
        NSMutableArray *sectionContent = [self.sectionRowTitles objectForKey:sectionTitle];
        if (sectionContent == nil) {
            sectionContent = [NSMutableArray array];
        }
        [sectionContent addObject:rowTitle];
        [self.sectionRowTitles setObject:sectionContent forKey:sectionTitle];

        // Добавляем сопоставленные элементам меню указатели на контроллеры представлений
        NSMutableArray *sectionViewController = [self.sectionViewControllers objectForKey:sectionTitle];
        if (sectionViewController == nil) {
            sectionViewController = [NSMutableArray array];
        }
        [sectionViewController addObject:viewController];
        [self.sectionViewControllers setObject:sectionViewController forKey:sectionTitle];

        // Добавляем названия файлов с иконками элементов меню
        NSMutableArray *sectionIconFilename = [self.sectionIconFilenames objectForKey:sectionTitle];
        if (sectionIconFilename == nil) {
            sectionIconFilename = [NSMutableArray array];
        }
        [sectionIconFilename addObject:iconFilename];
        [self.sectionIconFilenames setObject:sectionIconFilename forKey:sectionTitle];

        return YES;
    }

    return NO;
}

- (NSString *)titleForSectionWithIndex:(NSUInteger)sectionIndex
{
    NSString *title = nil;
    if (self.sectionKeys.count > sectionIndex && [self.sectionKeys objectAtIndex:sectionIndex]) {
        title = [self.sectionKeys objectAtIndex:sectionIndex];
    }
    return title;
}

- (NSString *)titleForRowWithIndex:(NSUInteger)rowIndex inSectionWithIndex:(NSUInteger)sectionIndex
{
    NSString       *sectionTitle   = [self titleForSectionWithIndex:sectionIndex];
    NSMutableArray *sectionContent = [self.sectionRowTitles objectForKey:sectionTitle];
    return [sectionContent objectAtIndex:rowIndex];
}

- (NSString *)iconFilenameForRowWithIndex:(NSUInteger)rowIndex inSectionWithIndex:(NSUInteger)sectionIndex
{
    NSString *iconFilename = nil;
    if (self.sectionKeys.count > sectionIndex && [self.sectionKeys objectAtIndex:sectionIndex]) {
        NSString       *sectionTitle  = [self titleForSectionWithIndex:sectionIndex];
        NSMutableArray *iconFilenames = [self.sectionIconFilenames objectForKey:sectionTitle];
        if (iconFilenames.count > rowIndex && [iconFilenames objectAtIndex:rowIndex]) {
            iconFilename = [iconFilenames objectAtIndex:rowIndex];
        }
    }
    return iconFilename;
}

- (UIViewController *)viewControllerForIndexPath:(NSIndexPath *)indexPath
{
    return [self viewControllerForRowWithIndex:indexPath.row inSectionWithIndex:indexPath.section];
}

- (UIViewController *)viewControllerForRowWithIndex:(NSUInteger)rowIndex inSectionWithIndex:(NSUInteger)sectionIndex
{

    UIViewController *returnVC = nil;

    if (self.sectionKeys.count > sectionIndex && [self.sectionKeys objectAtIndex:sectionIndex]) {
        NSString       *sectionTitle           = [self titleForSectionWithIndex:sectionIndex];
        NSMutableArray *sectionViewControllers = [self.sectionViewControllers objectForKey:sectionTitle];
        if (sectionViewControllers.count > rowIndex && [sectionViewControllers objectAtIndex:rowIndex]) {
            returnVC = [sectionViewControllers objectAtIndex:rowIndex];
        }
    }
    return returnVC;
}

- (NSIndexPath *)indexPathForViewController:(UIViewController *)viewController
{
    NSIndexPath *returnIndexPath = nil;

    for (NSUInteger section = 0; section < self.sectionViewControllers.count; section++) {
        NSString       *sectionTitle           = [self titleForSectionWithIndex:section];
        NSMutableArray *sectionViewControllers = [self.sectionViewControllers objectForKey:sectionTitle];
        for (NSUInteger row = 0; row < sectionViewControllers.count; row++) {
            UIViewController *tempVC = [sectionViewControllers objectAtIndex:row];
            if (tempVC == viewController) {
                returnIndexPath = [NSIndexPath indexPathForRow:row inSection:section];
            }
        }
    }

    return returnIndexPath;
}

- (void)clear
{
    self.sectionKeys            = nil;
    self.sectionRowTitles       = nil;
    self.sectionIconFilenames   = nil;
    self.sectionViewControllers = nil;

    NSMutableArray      *keys            = [NSMutableArray array];
    NSMutableDictionary *contents        = [NSMutableDictionary dictionary];
    NSMutableDictionary *iconFilenames   = [NSMutableDictionary dictionary];
    NSMutableDictionary *viewControllers = [NSMutableDictionary dictionary];

    self.sectionKeys            = keys;
    self.sectionRowTitles       = contents;
    self.sectionIconFilenames   = iconFilenames;
    self.sectionViewControllers = viewControllers;
}

#pragma mark - Validation

- (BOOL)validateRowTitle:(NSString *)rowTitle
{
    return (rowTitle != nil && rowTitle.length > 0 && rowTitle.length < 256);
}

- (BOOL)validateIconFilename:(NSString *)iconFilename
{
    return (iconFilename != nil && iconFilename.length > 0 && iconFilename.length < 256);
}

- (BOOL)validateViewController:(UIViewController *)viewController
{
    return (viewController != nil && [viewController isKindOfClass:[UIViewController class]]);
}

- (BOOL)validateSectionTitle:(NSString *)sectionTitle
{
    if ([self.sectionKeys indexOfObject:sectionTitle] == NSNotFound) {
        return NO;
    }
    return YES;
}

@end
