//
//  PCErrorFabricTests.m
//  imopc
//
//  Created by Gomzyakov on 11.02.14.
//  Copyright (c) 2014 ABAK PRESS. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PSErrorFabric.h"

@interface PCErrorFabricTests : XCTestCase
{
	NSInteger errorCode;
	NSString *errorDescription;
	NSError *error;
}

@end

@implementation PCErrorFabricTests

- (void)setUp
{
    [super setUp];
	
	errorCode = 404;
	errorDescription = @"Fatality error!";
	error = [PSErrorFabric errorWithCode:errorCode errorDescription:errorDescription];
}

- (void)tearDown
{
	errorCode = NSIntegerMin;
	errorDescription = nil;
	error = nil;
	
	[super tearDown];
}

- (void)testErrorExists
{
	XCTAssertNotNil(error, @"Не удается создать экземпляр PCMenuDatasource");
}

- (void)testErrorCode
{
	XCTAssertEqual(error.code, errorCode, @"Неверно инициализируется код ошибки");
}

- (void)testErrorString
{
	XCTAssertEqual(error.localizedDescription, errorDescription, @"Неверно инициализируется описание ошибки");
}

- (void)testErrorDomain
{
	XCTAssertEqualObjects([PSErrorFabric errorDomain], @"PSPasswordErrorDomain", @"Неверно возвращается errorDomain");
}

/**
 Если параметр localizedDescription не задан, по дефолту он формируется из domain и кода ошибки,
 например @"PCManagedObjectErrorDomain error 404".
 */
- (void)testNilDescription
{
	errorDescription = nil;
	error = [PSErrorFabric errorWithCode:errorCode errorDescription:errorDescription];
	NSString *expectedReturn = [NSString stringWithFormat:@"%@ error %d", [PSErrorFabric errorDomain], error.code ];
	XCTAssertEqualObjects(error.localizedDescription, expectedReturn, @"Неверно инициализируется описание ошибки при передаче nil");
}


@end
