//
//  PCMenuDatasourceTests.m
//  imopc
//
//  Created by Alexander Gomzyakov on 22.01.14.
//  Copyright (c) 2014 ABAK PRESS. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PSMenuDatasource.h"

@interface PSMenuDatasourceTests : XCTestCase
{
	UIViewController *sectionOneRowOneVC;
	UIViewController *sectionOneRowTwoVC;
	UIViewController *sectionTwoVC;
	
	NSString *rowOneTitle;
	NSString *rowTwoTitle;
	
	NSString *iconFilenameOne;
	NSString *iconFilenameTwo;
}

@property (nonatomic, strong) PSMenuDatasource *menuDatasource;

@end

NSString *const kSectionOneTitle = @"First Header";
NSString *const kSectionTwoTitle = @"Second Header";

@implementation PSMenuDatasourceTests

- (void)setUp
{
    [super setUp];
	
	self.menuDatasource = [[PSMenuDatasource alloc] init];
	
	sectionOneRowOneVC = [[UIViewController alloc] init];
	sectionOneRowTwoVC = [[UIViewController alloc] init];
	sectionTwoVC = [[UIViewController alloc] init];
	
	rowOneTitle = @"Row One Title";
	rowTwoTitle = @"Row Two Title";
	
	iconFilenameOne = @"iconOne.png";
	iconFilenameTwo = @"iconTwo.png";
	
	[self.menuDatasource insertSectionWithHeaderTitle:kSectionOneTitle];
	[self.menuDatasource insertRowWithTitle:rowOneTitle iconFilename:iconFilenameOne viewController:sectionOneRowOneVC inSectionWithTitle:kSectionOneTitle];
	[self.menuDatasource insertRowWithTitle:rowTwoTitle iconFilename:iconFilenameTwo viewController:sectionOneRowTwoVC inSectionWithTitle:kSectionOneTitle];
	[self.menuDatasource insertSectionWithHeaderTitle:kSectionTwoTitle];
	[self.menuDatasource insertRowWithTitle:@"Title 2-1" iconFilename:@"2-1.png" viewController:sectionTwoVC inSectionWithTitle:kSectionTwoTitle];
	[self.menuDatasource insertRowWithTitle:@"Title 2-2" iconFilename:@"2-2.png" viewController:sectionTwoVC inSectionWithTitle:kSectionTwoTitle];
	[self.menuDatasource insertRowWithTitle:@"Title 2-3" iconFilename:@"2-3.png" viewController:sectionTwoVC inSectionWithTitle:kSectionTwoTitle];
	[self.menuDatasource insertRowWithTitle:@"Title 2-4" iconFilename:@"2-4.png" viewController:sectionTwoVC inSectionWithTitle:kSectionTwoTitle];
}

- (void)tearDown
{
	sectionOneRowOneVC = nil;
	sectionOneRowTwoVC = nil;
	sectionTwoVC = nil;
	
	iconFilenameOne = nil;
	iconFilenameTwo = nil;
	
    self.menuDatasource = nil;
    [super tearDown];
}

- (void)testThatMenuDatasourceExists
{
	XCTAssertNotNil(self.menuDatasource, @"Не удается создать экземпляр PCMenuDatasource");
}

#pragma mark - numberOfSections

- (void)testNumberOfSections
{
	NSUInteger numberOfSections = [self.menuDatasource numberOfSections];
	XCTAssert(numberOfSections == 2, @"Некорректно возвращается количество секций");
}

#pragma mark - numberOfRowsInSectionWithTitle:

- (void)testNumberOfRowsInSectionWithTitle
{
	NSUInteger numberOfRow = [self.menuDatasource numberOfRowsInSectionWithTitle:kSectionOneTitle];
	XCTAssert(numberOfRow == 2, @"Некорректно возвращается количество ячеек для секций с заголовком 'First Header'");
}

- (void)testNumberOfRowsInSectionWithNonexistentTitle
{
	NSUInteger numberOfRow = [self.menuDatasource numberOfRowsInSectionWithTitle:@"Nonexistent Title"];
	XCTAssert(numberOfRow == NSNotFound, @"В случае, если передан некорректный заголовок, метод должен вернуть NSNotFound");
}

- (void)testNumberOfRowsInSectionWithNilTitle
{
	NSUInteger numberOfRow = [self.menuDatasource numberOfRowsInSectionWithTitle:nil];
	XCTAssert(numberOfRow == NSNotFound, @"В случае, если передан nil вместо заголовка секции, метод должен вернуть NSNotFound");
}

#pragma mark - numberOfRowsInSectionWithIndex:

- (void)testNumberOfRowsInSectionWithIndex
{
	NSUInteger numberOfRow = [self.menuDatasource numberOfRowsInSectionWithIndex:0];
	XCTAssert(numberOfRow == 2, @"Некорректно возвращается количество ячеек для секций с индексов 0");
}

- (void)testNumberOfRowsInSectionWithNonexistentIndex
{
	NSUInteger numberOfRow = [self.menuDatasource numberOfRowsInSectionWithIndex:13];
	XCTAssert(numberOfRow == NSNotFound, @"В случае, если передан некорректный индекс секции, метод должен вернуть NSNotFound");
}

#pragma mark - addSectionWithHeaderTitle:

- (void)testAddSectionWithHeaderTitle
{
	NSString *newSectionTitle = @"Third Header";
	[self.menuDatasource insertSectionWithHeaderTitle:newSectionTitle];
	NSString *sectionTitle = [self.menuDatasource titleForSectionWithIndex:2];
	XCTAssertEqual(sectionTitle, newSectionTitle, @"Некорректно добавляется заголовок секции");
}

- (void)testAddSectionWithEmptyHeaderTitle
{
	BOOL isAdded = [self.menuDatasource insertSectionWithHeaderTitle:@""];
	XCTAssertFalse(isAdded, @"Заголовок секции не может быть пустым");
}

- (void)testAddSectionWithUnacceptablyLongHeaderTitle
{
	NSString *unacceptablyLongTitle = @"DM7fVFE8kuvbHUOtx7VUhPL4Np1v4kgz4zmg5yYt5HIfHt75UMu19v8VC3OWXAAOnFFRDr0rCKsXHTdV47OPUOMRz80vuIxGl4Co5anrvijVSzeyqjgXZ2JWDrRW6uMw1BfQC8r8HOuoldH0ZUupxZ9aW6znIP9fHMOVAPHcPh5d4UciZLRDyu5xCmJi4rSuF2c09mokIB9SKOzmZIV6iXMWYCCJYekzZW9yZ5DZ17cAHTEhgV9NgtQkh4LNc55D";
	BOOL isAdded = [self.menuDatasource insertSectionWithHeaderTitle:unacceptablyLongTitle];
	XCTAssertFalse(isAdded, @"Заголовок секции не может иметь длинну более 255 символов");
}

- (void)testAddSectionWithNilHeaderTitle
{
	BOOL isAdded = [self.menuDatasource insertSectionWithHeaderTitle:nil];
	XCTAssertFalse(isAdded, @"Заголовок секции не может быть nil");
}

#pragma mark - addRowWithTitle:iconFilename:viewController:inSectionWithIndex:

- (void)testAddRowInSectionWithIndex
{
	NSString *paramRowTitle = @"New Row Title";
	NSString *paramIconFilename = @"ico.png";
	UIViewController *paramVC = [[UIViewController alloc] init];

	[self.menuDatasource insertRowWithTitle:paramRowTitle iconFilename:paramIconFilename viewController:paramVC inSectionWithIndex:0];
	
	NSString *rowTitle = [self.menuDatasource titleForRowWithIndex:2 inSectionWithIndex:0];
	XCTAssertEqualObjects(rowTitle, paramRowTitle, @"Некорректно добавляется заголовок ячейки");
	
	NSString *iconFilename = [self.menuDatasource iconFilenameForRowWithIndex:2 inSectionWithIndex:0];
	XCTAssertEqualObjects(iconFilename, paramIconFilename, @"Некорректно добавляется имя файла иконки ячейки");
	
	UIViewController *vc = [self.menuDatasource viewControllerForRowWithIndex:2 inSectionWithIndex:0];
	XCTAssertEqualObjects(vc, paramVC, @"Некорректно добавляется контроллер представления");
}

- (void)testAddRowInSectionWithNonexistentIndex
{
	NSUInteger nonexistentSectionIndex = 13;
	UIViewController *vc = [[UIViewController alloc] init];
	BOOL isInserted = [self.menuDatasource insertRowWithTitle:@"New Row Title" iconFilename:@"ico.png" viewController:vc inSectionWithIndex:nonexistentSectionIndex];
	XCTAssertFalse(isInserted, @"Ячейчка не может быть добавлена в секцию с несуществующим заголовком");
}

- (void)testAddRowWithEmptyTitle
{
	UIViewController *vc = [[UIViewController alloc] init];
	BOOL isInserted = [self.menuDatasource insertRowWithTitle:@"" iconFilename:@"ico.png" viewController:vc inSectionWithIndex:0];
	XCTAssertFalse(isInserted, @"Заголовок ячейки не может быть пустым");
}

- (void)testAddRowWithNilTitle
{
	UIViewController *vc = [[UIViewController alloc] init];
	BOOL isInserted = [self.menuDatasource insertRowWithTitle:nil iconFilename:@"ico.png" viewController:vc inSectionWithIndex:0];
	XCTAssertFalse(isInserted, @"Заголовок ячейки не может быть nil");
}

- (void)testAddRowWithUnacceptablyLongTitle
{
	NSString *unacceptablyLongTitle = @"DM7fVFE8kuvbHUOtx7VUhPL4Np1v4kgz4zmg5yYt5HIfHt75UMu19v8VC3OWXAAOnFFRDr0rCKsXHTdV47OPUOMRz80vuIxGl4Co5anrvijVSzeyqjgXZ2JWDrRW6uMw1BfQC8r8HOuoldH0ZUupxZ9aW6znIP9fHMOVAPHcPh5d4UciZLRDyu5xCmJi4rSuF2c09mokIB9SKOzmZIV6iXMWYCCJYekzZW9yZ5DZ17cAHTEhgV9NgtQkh4LNc55D";
	UIViewController *vc = [[UIViewController alloc] init];
	BOOL isInserted = [self.menuDatasource insertRowWithTitle:unacceptablyLongTitle iconFilename:@"ico.png" viewController:vc inSectionWithIndex:0];
	XCTAssertFalse(isInserted, @"Заголовок ячейки не может иметь длинну более 255 символов");
}

- (void)testAddRowWithEmptyIconFilename
{
	UIViewController *vc = [[UIViewController alloc] init];
	BOOL isInserted = [self.menuDatasource insertRowWithTitle:@"RowTitle" iconFilename:@"" viewController:vc inSectionWithIndex:0];
	XCTAssertFalse(isInserted, @"Имя файла с иконкой ячейки не может быть пустым");
}

- (void)testAddRowWithNilIconFilename
{
	UIViewController *vc = [[UIViewController alloc] init];
	BOOL isInserted = [self.menuDatasource insertRowWithTitle:@"RowTitle" iconFilename:nil viewController:vc inSectionWithIndex:0];
	XCTAssertFalse(isInserted, @"Имя файла с иконкой ячейки не может быть nil");
}

- (void)testAddRowWithUnacceptablyLongIconFilename
{
	NSString *unacceptablyLongIconFilename = @"DM7fVFE8kuvbHUOtx7VUhPL4Np1v4kgz4zmg5yYt5HIfHt75UMu19v8VC3OWXAAOnFFRDr0rCKsXHTdV47OPUOMRz80vuIxGl4Co5anrvijVSzeyqjgXZ2JWDrRW6uMw1BfQC8r8HOuoldH0ZUupxZ9aW6znIP9fHMOVAPHcPh5d4UciZLRDyu5xCmJi4rSuF2c09mokIB9SKOzmZIV6iXMWYCCJYekzZW9yZ5DZ17cAHTEhgV9NgtQkh4LNc55D.png";
	UIViewController *vc = [[UIViewController alloc] init];
	BOOL isInserted = [self.menuDatasource insertRowWithTitle:@"RowTitle" iconFilename:unacceptablyLongIconFilename viewController:vc inSectionWithIndex:0];
	XCTAssertFalse(isInserted, @"Имя файла с иконкой ячейки не может иметь длинну более 255 символов");
}

- (void)testAddRowWithNilViewController
{
	BOOL isInserted = [self.menuDatasource insertRowWithTitle:@"RowTitle" iconFilename:@"ico.png" viewController:nil inSectionWithIndex:0];
	XCTAssertFalse(isInserted, @"Конроллер представления, передаваемый ячейке, не может быть nil");
}

#pragma mark - addRowWithTitle:iconFilename:viewController:inSectionWithTitle:

- (void)testAddRowInSectionWithTitle
{
	NSString *paramRowTitle = @"New Row Title";
	NSString *paramIconFilename = @"ico.png";
	UIViewController *paramVC = [[UIViewController alloc] init];
	
	[self.menuDatasource insertRowWithTitle:paramRowTitle iconFilename:paramIconFilename viewController:paramVC inSectionWithTitle:kSectionOneTitle];
	
	NSString *rowTitle = [self.menuDatasource titleForRowWithIndex:2 inSectionWithIndex:0];
	XCTAssertEqualObjects(rowTitle, paramRowTitle, @"Некорректно добавляется заголовок ячейки");
	
	NSString *iconFilename = [self.menuDatasource iconFilenameForRowWithIndex:2 inSectionWithIndex:0];
	XCTAssertEqualObjects(iconFilename, paramIconFilename, @"Некорректно добавляется имя файла иконки ячейки");
	
	UIViewController *vc = [self.menuDatasource viewControllerForRowWithIndex:2 inSectionWithIndex:0];
	XCTAssertEqualObjects(vc, paramVC, @"Некорректно добавляется контроллер представления");
}

- (void)testAddRowInSectionWithNonexistentTitle
{
	NSString *nonexistentSectionTitle = @"XXX";
	UIViewController *vc = [[UIViewController alloc] init];
	BOOL isInserted = [self.menuDatasource insertRowWithTitle:@"New Row Title" iconFilename:@"ico.png" viewController:vc inSectionWithTitle:nonexistentSectionTitle];
	XCTAssertFalse(isInserted, @"Ячейчка не может быть добавлена в секцию с несуществующим заголовком");
}

- (void)testAddRowWithEmptyTitleInSectionWithTitle
{
	UIViewController *vc = [[UIViewController alloc] init];
	BOOL isInserted = [self.menuDatasource insertRowWithTitle:@"" iconFilename:@"ico.png" viewController:vc inSectionWithTitle:kSectionOneTitle];
	XCTAssertFalse(isInserted, @"Заголовок ячейки не может быть пустым");
}

- (void)testAddRowWithNilTitleInSectionWithTitle
{
	UIViewController *vc = [[UIViewController alloc] init];
	BOOL isInserted = [self.menuDatasource insertRowWithTitle:nil iconFilename:@"ico.png" viewController:vc inSectionWithTitle:kSectionOneTitle];
	XCTAssertFalse(isInserted, @"Заголовок ячейки не может быть nil");
}

- (void)testAddRowWithUnacceptablyLongTitleInSectionWithTitle
{
	NSString *unacceptablyLongTitle = @"DM7fVFE8kuvbHUOtx7VUhPL4Np1v4kgz4zmg5yYt5HIfHt75UMu19v8VC3OWXAAOnFFRDr0rCKsXHTdV47OPUOMRz80vuIxGl4Co5anrvijVSzeyqjgXZ2JWDrRW6uMw1BfQC8r8HOuoldH0ZUupxZ9aW6znIP9fHMOVAPHcPh5d4UciZLRDyu5xCmJi4rSuF2c09mokIB9SKOzmZIV6iXMWYCCJYekzZW9yZ5DZ17cAHTEhgV9NgtQkh4LNc55D";
	UIViewController *vc = [[UIViewController alloc] init];
	BOOL isInserted = [self.menuDatasource insertRowWithTitle:unacceptablyLongTitle iconFilename:@"ico.png" viewController:vc inSectionWithTitle:kSectionOneTitle];
	XCTAssertFalse(isInserted, @"Заголовок ячейки не может иметь длинну более 255 символов");
}

- (void)testAddRowWithEmptyIconFilenameInSectionWithTitle
{
	UIViewController *vc = [[UIViewController alloc] init];
	BOOL isInserted = [self.menuDatasource insertRowWithTitle:@"RowTitle" iconFilename:@"" viewController:vc inSectionWithTitle:kSectionOneTitle];
	XCTAssertFalse(isInserted, @"Имя файла с иконкой ячейки не может быть пустым");
}

- (void)testAddRowWithNilIconFilenameInSectionWithTitle
{
	UIViewController *vc = [[UIViewController alloc] init];
	BOOL isInserted = [self.menuDatasource insertRowWithTitle:@"RowTitle" iconFilename:nil viewController:vc inSectionWithTitle:kSectionOneTitle];
	XCTAssertFalse(isInserted, @"Имя файла с иконкой ячейки не может быть nil");
}

- (void)testAddRowWithUnacceptablyLongIconFilenameInSectionWithTitle
{
	NSString *unacceptablyLongIconFilename = @"DM7fVFE8kuvbHUOtx7VUhPL4Np1v4kgz4zmg5yYt5HIfHt75UMu19v8VC3OWXAAOnFFRDr0rCKsXHTdV47OPUOMRz80vuIxGl4Co5anrvijVSzeyqjgXZ2JWDrRW6uMw1BfQC8r8HOuoldH0ZUupxZ9aW6znIP9fHMOVAPHcPh5d4UciZLRDyu5xCmJi4rSuF2c09mokIB9SKOzmZIV6iXMWYCCJYekzZW9yZ5DZ17cAHTEhgV9NgtQkh4LNc55D.png";
	UIViewController *vc = [[UIViewController alloc] init];
	BOOL isInserted = [self.menuDatasource insertRowWithTitle:@"RowTitle" iconFilename:unacceptablyLongIconFilename viewController:vc inSectionWithTitle:kSectionOneTitle];
	XCTAssertFalse(isInserted, @"Имя файла с иконкой ячейки не может иметь длинну более 255 символов");
}

- (void)testAddRowWithNilViewControllerInSectionWithTitle
{
	BOOL isInserted = [self.menuDatasource insertRowWithTitle:@"RowTitle" iconFilename:@"ico.png" viewController:nil inSectionWithTitle:kSectionOneTitle];
	XCTAssertFalse(isInserted, @"Конроллер представления, передаваемый ячейке, не может быть nil");
}

#pragma mark - titleForSectionWithIndex:

- (void)testSectionTitle
{
	NSString *sectionTitle = [self.menuDatasource titleForSectionWithIndex:0];
	XCTAssertEqual(sectionTitle, kSectionOneTitle, @"Некорректно возвращается заголовок секции");
}

- (void)testSectionTitleWithOutOfOrderIndexForNil
{
	NSString *sectionTitle = [self.menuDatasource titleForSectionWithIndex:2];
	XCTAssertNil(sectionTitle, @"Заголовок секции с индексом большим, чем количество элементов, должен возвращать nil");
}

#pragma mark - titleForRowWithIndex:inSectionWithIndex:

- (void)testRowTitle
{
	NSString *rowTitle = [self.menuDatasource titleForRowWithIndex:0 inSectionWithIndex:0];
	XCTAssertEqualObjects(rowTitle, rowOneTitle, @"Некорректно возвращается заголовок ячейки");
}

- (void)testRowTitleWithOutOfOrderIndexForNil
{
	NSString *rowTitle = [self.menuDatasource titleForRowWithIndex:999 inSectionWithIndex:999];
	XCTAssertNil(rowTitle, @"Заголовок ячейки с индексом большим, чем количество элементов, должен возвращать nil");
}

#pragma mark - iconFilenameForRowWithIndex:inSectionWithIndex:

- (void)testIconFilename
{
	NSString *iconFilename = [self.menuDatasource iconFilenameForRowWithIndex:0 inSectionWithIndex:0];
	XCTAssertEqualObjects(iconFilename, iconFilenameOne, @"Некорректно возвращается имя файла с иконкой");
}

- (void)testIconFilenameWithNonexistentIndex
{
	NSUInteger nonexistentIndex = 13;
	NSString *iconFilename = [self.menuDatasource iconFilenameForRowWithIndex:nonexistentIndex inSectionWithIndex:0];
	XCTAssertNil(iconFilename, @"Метод должен вернуть nil, если переданны некорректные значения индексов");
}

#pragma mark - clear

- (void)testNumberOfSectionsAfterClear
{
	[self.menuDatasource clear];
	NSUInteger numberOfSections = [self.menuDatasource numberOfSections];
	XCTAssert(numberOfSections == 0, @"После очистки экземпляра класса, метод numberOfSections должен вернуть NSNotFound");
}

- (void)testRowTitleAfterClear
{
	[self.menuDatasource clear];
	NSString *rowTitle = [self.menuDatasource titleForRowWithIndex:0 inSectionWithIndex:0];
	XCTAssertNil(rowTitle, @"Заголовок ячейки после очистки экземпляр PCMenuDatasource должен быть nil");
}

- (void)testSectionTitleAfterClear
{
	[self.menuDatasource clear];
	NSString *sectionTitle = [self.menuDatasource titleForSectionWithIndex:0];
	XCTAssertNil(sectionTitle, @"Заголовок секции после очистки экземпляр PCMenuDatasource должен быть nil");
}

- (void)testIconFilenameAfterClear
{
	[self.menuDatasource clear];
	NSString *iconFilename = [self.menuDatasource iconFilenameForRowWithIndex:0 inSectionWithIndex:0];
	XCTAssertNil(iconFilename, @"Имя файла с иконкой после очистки экземпляр PCMenuDatasource должно быть nil");
}

- (void)testViewControllerAfterClear
{
	[self.menuDatasource clear];
	UIViewController *returnVC = [self.menuDatasource viewControllerForRowWithIndex:0 inSectionWithIndex:0];
	XCTAssertNil(returnVC, @"Ассоциированный с ячейкой UIViewController после очистки экземпляр PCMenuDatasource должен быть nil");
}

- (void)testViewControllerForIndexPathAfterClear
{
	[self.menuDatasource clear];
	NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
	UIViewController *returnVC = [self.menuDatasource viewControllerForIndexPath:indexPath];
	XCTAssertNil(returnVC, @"Ассоциированный с ячейкой UIViewController после очистки экземпляр PCMenuDatasource должен быть nil");
}

#pragma mark - viewControllerForIndexPath:

- (void)testViewControllerForIndexPath
{
	NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
	UIViewController *returnVC = [self.menuDatasource viewControllerForIndexPath:indexPath];
	XCTAssertEqualObjects(returnVC, sectionOneRowOneVC, @"Некорректно возвращается UIViewController ассоциированный с ячейкой");
}

- (void)testViewControllerWithNonexistentIndexPath
{
	NSIndexPath *indexPath = [NSIndexPath indexPathForRow:13 inSection:0];
	UIViewController *returnVC = [self.menuDatasource viewControllerForIndexPath:indexPath];
	XCTAssertNil(returnVC, @"Метод должен вернуть nil, если переданны некорректное значение NSIndexPath");
}

#pragma mark - viewControllerForRowWithIndex:inSectionWithIndex:

- (void)testViewController
{
	UIViewController *returnVC = [self.menuDatasource viewControllerForRowWithIndex:0 inSectionWithIndex:0];
	XCTAssertEqualObjects(returnVC, sectionOneRowOneVC, @"Некорректно возвращается UIViewController ассоциированный с ячейкой");
}

- (void)testViewControllerWithNonexistentIndex
{
	NSUInteger nonexistentIndex = 13;
	UIViewController *returnVC = [self.menuDatasource viewControllerForRowWithIndex:nonexistentIndex inSectionWithIndex:0];
	XCTAssertNil(returnVC, @"Метод должен вернуть nil, если переданны некорректные значения индексов");
}

#pragma mark - indexPathForViewController:

- (void)testIndexPathForViewController
{
	NSIndexPath *indexPath = [self.menuDatasource indexPathForViewController:sectionOneRowTwoVC];
	XCTAssertEqualObjects(indexPath, [NSIndexPath indexPathForRow:1 inSection:0], @"Некорректно возвращается NSIndexPath для заданного UIViewController");
}

- (void)testIndexPathForNilViewController
{
	NSIndexPath *indexPath = [self.menuDatasource indexPathForViewController:nil];
	XCTAssertNil(indexPath, @"Метод должен вернуть nil, если UIViewController = nil");
}

- (void)testIndexPathForNonexistentViewController
{
	UIViewController *paramVC = [[UIViewController alloc] init];
	NSIndexPath *indexPath = [self.menuDatasource indexPathForViewController:paramVC];
	XCTAssertNil(indexPath, @"Метод должен вернуть nil, если переданный в параметре UIViewController не ассоциирован ни с одной ячейкой");
}

@end
