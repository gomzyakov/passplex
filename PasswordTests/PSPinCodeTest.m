//
//  PCCommonSearchResultsTest.m
//  imopc
//
//  Created by Gomzyakov on 28.01.14.
//  Copyright (c) 2014 ABAK PRESS. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PSPinCode.h"

@interface PSPinCodeTest : XCTestCase

@property (nonatomic, strong) PSPinCode *pinCode;

@end

@implementation PSPinCodeTest

- (void)setUp
{
    [super setUp];
    // Put setup code here; it will be run once, before the first test case.
}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}

- (void)testPinCode
{
    NSNumber *inPasscode = [NSNumber numberWithInteger:13];
    [PSPinCode setPasscode:inPasscode];
    NSNumber *retPasscode = [PSPinCode passcode];
    XCTAssert(retPasscode.integerValue == inPasscode.integerValue, @"Некорректно устанавливается или возвращается параметр <passcode>");
}

/**
 PIN-код не может быть пустым.
 */
- (void)testZeroLenghtPinCode
{
    XCTFail(@"PIN-код не может быть пустым.");
}

/**
 PIN-код не может быть длиннее 4х цифр.
 */
- (void)testLongPinCode
{
    XCTFail(@"PIN-код не может быть длиннее 4х цифр.");
}

/**
 Проверяем корректность работы метода isSet.
 */
- (void)testIsSet
{
    NSNumber *paramPasscode = [NSNumber numberWithInteger:13];
    [PSPinCode setPasscode:paramPasscode];

    BOOL returnValue = [PSPinCode isSet];
    XCTAssertTrue(returnValue, @"Некорректно возвращается флаг установлен/не_установлен");
}

- (void)testClear
{
    NSNumber *paramPage = [NSNumber numberWithInteger:13];
    [PSPinCode setPasscode:paramPage];

    [PSPinCode clear];

    NSNumber *returnPasscode = [PSPinCode passcode];
    XCTAssertNil(returnPasscode, @"Некорректно очищается параметр page");
}

@end
