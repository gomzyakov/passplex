//
//  PSPasswordCRUDTests.m
//  password
//
//  Created by Gomzyakov on 14.02.14.
//  Copyright (c) 2014 Alexander Gomzyakov. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PSPassword.h"
#import "PSPassword+CRUD.h"

@interface PSPasswordCRUDTests : XCTestCase
{
    NSManagedObjectModel         *model;
    NSPersistentStoreCoordinator *coordinator;
    NSManagedObjectContext       *context;
    NSPersistentStore            *store;

    /// Корректный словарь инициализации, передавайемый в качестве параметра.
    NSDictionary *inDictionary;

    NSString *inTitle;
    NSString *inUsername;
    NSString *inPassword;
    NSNumber *isFavorite;
}

@end

@implementation PSPasswordCRUDTests

- (void)setUp
{
    [super setUp];

    NSArray *bundles = [NSArray arrayWithObject:[NSBundle mainBundle]];
    model       = [NSManagedObjectModel mergedModelFromBundles:bundles];
    coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
    store       = [coordinator addPersistentStoreWithType:NSInMemoryStoreType configuration:nil URL:nil options:nil error:NULL];
    context     = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [context setPersistentStoreCoordinator:coordinator];

    inTitle    = @"Facebook App";
    inUsername = @"georgy@mail.ru";
    inPassword = @"123456qwerty";
    isFavorite = [NSNumber numberWithBool:NO];

    inDictionary = @{ @"title": inTitle,
                      @"username": inUsername,
                      @"password": inPassword };
}

- (void)tearDown
{
    model       = nil;
    coordinator = nil;
    context     = nil;
    store       = nil;

    inTitle    = nil;
    inUsername = nil;
    inPassword = nil;

    [super tearDown];
}

#pragma mark - scheduleWithDictionary: forOffice: forUser:

- (void)testBuilder
{
    PSPassword *password = [PSPassword passwordWithDictionary:inDictionary isFavorite:isFavorite inContext:context];
    XCTAssertNotNil(password, @"Неудается инициализировать сущность PSPassword");
}

#pragma mark - Test for nil params

- (void)testNilContext
{
    context = nil;
    PSPassword *password = [PSPassword passwordWithDictionary:inDictionary isFavorite:isFavorite inContext:context];
    XCTAssertNil(password, @"Нельзя создать управляемый объект с nil-контекстом");
}

- (void)testNilDictionary
{
    inDictionary = nil;
    PSPassword *password = [PSPassword passwordWithDictionary:inDictionary isFavorite:isFavorite inContext:context];
    XCTAssertNil(password, @"Ошибка инициализации");
}

- (void)testTitleEqualNil
{
    inDictionary = @{ @"username": inUsername,
                      @"password": inPassword };
    PSPassword *password = [PSPassword passwordWithDictionary:inDictionary isFavorite:isFavorite inContext:context];
    XCTAssertNil(password, @"Ошибка инициализации");
}

- (void)testUsernameEqualNil
{
    inDictionary = @{ @"title": inTitle,
                      @"password": inPassword };
    PSPassword *password = [PSPassword passwordWithDictionary:inDictionary isFavorite:isFavorite inContext:context];
    XCTAssertNil(password, @"Ошибка инициализации");
}

- (void)testPasswordEqualNil
{
    inDictionary = @{ @"title": inTitle,
                      @"username": inUsername };
    PSPassword *password = [PSPassword passwordWithDictionary:inDictionary isFavorite:isFavorite inContext:context];
    XCTAssertNil(password, @"Ошибка инициализации");
}

#pragma mark - Test for [NSNull null] params

//- (void)testTitleEqualNull
//{
//	inDictionary = @{@"title": [NSNull null],
//					 @"username": inUsername,
//					 @"password": inPassword};
//	PSPassword *password = [PSPassword passwordWithDictionary:inDictionary inContext:context];
//	XCTAssertNil(password, @"Ошибка инициализации");
//}
//
//- (void)testUsernameEqualNull
//{
//	inDictionary = @{@"title": inTitle,
//					 @"username": [NSNull null],
//					 @"password": inPassword};
//	PSPassword *password = [PSPassword passwordWithDictionary:inDictionary inContext:context];
//	XCTAssertNil(password, @"Ошибка инициализации");
//}
//
//- (void)testPasswordEqualNull
//{
//	inDictionary = @{@"title": inTitle,
//					 @"username": inUsername,
//					 @"password": [NSNull null]};
//	PSPassword *password = [PSPassword passwordWithDictionary:inDictionary inContext:context];
//	XCTAssertNil(password, @"Ошибка инициализации");
//}

#pragma mark - Test for empty params

/**
   Учитывая то, что любое свойство сущности может быть пустым, инициализирующий словарь
   также может быть пустым. Да, мы получим сущность с пустыми полями, но сущность корректную.
 */
- (void)testEmptyDictionary
{
    inDictionary = @{};
    PSPassword *password = [PSPassword passwordWithDictionary:inDictionary isFavorite:isFavorite inContext:context];
    XCTAssertNil(password, @"Ошибка инициализации");
}

#pragma mark - Test empty params

- (void)testTitleIsEmpty
{
    inDictionary = @{ @"title": @"",
                      @"username": inUsername,
                      @"password": inPassword };
    PSPassword *password = [PSPassword passwordWithDictionary:inDictionary isFavorite:isFavorite inContext:context];
    XCTAssertNil(password, @"Ошибка инициализации");
}

- (void)testUsernameIsEmpty
{
    inDictionary = @{ @"title": inTitle,
                      @"username": @"",
                      @"password": inPassword };
    PSPassword *password = [PSPassword passwordWithDictionary:inDictionary isFavorite:isFavorite inContext:context];
    XCTAssertNil(password, @"Ошибка инициализации");
}

- (void)testPasswordIsEmpty
{
    inDictionary = @{ @"title": inTitle,
                      @"username": inUsername,
                      @"password": @"" };
    PSPassword *password = [PSPassword passwordWithDictionary:inDictionary isFavorite:isFavorite inContext:context];
    XCTAssertNil(password, @"Ошибка инициализации");
}

#pragma mark - Test for incorrect params

//- (void)testTitleEqualNSNumber
//{
//	inDictionary = @{@"title": @13,
//					 @"username": inUsername,
//					 @"password": inPassword};
//	PSPassword *password = [PSPassword passwordWithDictionary:inDictionary inContext:context];
//	XCTAssertNil(password, @"Ошибка инициализации");
//}
//
//- (void)testUsernameEqualNSNumber
//{
//	inDictionary = @{@"title": inTitle,
//					 @"username": @13,
//					 @"password": inPassword};
//	PSPassword *password = [PSPassword passwordWithDictionary:inDictionary inContext:context];
//	XCTAssertNil(password, @"Ошибка инициализации");
//}
//
//- (void)testPasswordEqualNSNumber
//{
//	inDictionary = @{@"title": inTitle,
//					 @"username": inUsername,
//					 @"password": @13};
//	PSPassword *password = [PSPassword passwordWithDictionary:inDictionary inContext:context];
//	XCTAssertNil(password, @"Ошибка инициализации");
//}


#pragma mark - Test unacceptably long values

//- (void)testUnacceptablyLongTitle
//{
//	inTitle = @"DM7fVFE8kuvbHUOtx7VUhPL4Np1v4kgz4zmg5yYt5HIfHt75UMu19v8VC3OWXAAOnFFRDr0rCKsXHTdV47OPUOMRz80vuIxGl4Co5anrvijVSzeyqjgXZ2JWDrRW6uMw1BfQC8r8HOuoldH0ZUupxZ9aW6znIP9fHMOVAPHcPh5d4UciZLRDyu5xCmJi4rSuF2c09mokIB9SKOzmZIV6iXMWYCCJYekzZW9yZ5DZ17cAHTEhgV9NgtQkh4LNc55D";
//	PSPassword *password = [PSPassword passwordWithDictionary:inDictionary inContext:context];
//	XCTAssertNil(password, @"Ошибка инициализации");
//}
//
//- (void)testUnacceptablyLongUsername
//{
//	inUsername = @"DM7fVFE8kuvbHUOtx7VUhPL4Np1v4kgz4zmg5yYt5HIfHt75UMu19v8VC3OWXAAOnFFRDr0rCKsXHTdV47OPUOMRz80vuIxGl4Co5anrvijVSzeyqjgXZ2JWDrRW6uMw1BfQC8r8HOuoldH0ZUupxZ9aW6znIP9fHMOVAPHcPh5d4UciZLRDyu5xCmJi4rSuF2c09mokIB9SKOzmZIV6iXMWYCCJYekzZW9yZ5DZ17cAHTEhgV9NgtQkh4LNc55D";
//	PSPassword *password = [PSPassword passwordWithDictionary:inDictionary inContext:context];
//	XCTAssertNil(password, @"Ошибка инициализации");
//}
//
//- (void)testUnacceptablyLongPassword
//{
//	inPassword = @"DM7fVFE8kuvbHUOtx7VUhPL4Np1v4kgz4zmg5yYt5HIfHt75UMu19v8VC3OWXAAOnFFRDr0rCKsXHTdV47OPUOMRz80vuIxGl4Co5anrvijVSzeyqjgXZ2JWDrRW6uMw1BfQC8r8HOuoldH0ZUupxZ9aW6znIP9fHMOVAPHcPh5d4UciZLRDyu5xCmJi4rSuF2c09mokIB9SKOzmZIV6iXMWYCCJYekzZW9yZ5DZ17cAHTEhgV9NgtQkh4LNc55D";
//	PSPassword *password = [PSPassword passwordWithDictionary:inDictionary inContext:context];
//	XCTAssertNil(password, @"Ошибка инициализации");
//}

#pragma mark - Test returned values

- (void)testReturnedTitle
{
    PSPassword *password = [PSPassword passwordWithDictionary:inDictionary isFavorite:isFavorite inContext:context];
    NSString   *outTitle = password.title;
    XCTAssertEqual(outTitle, inTitle, @"fail");
}

- (void)testReturnedUsername
{
    PSPassword *password    = [PSPassword passwordWithDictionary:inDictionary isFavorite:isFavorite inContext:context];
    NSString   *outUsername = password.username;
    XCTAssertEqual(outUsername, inUsername, @"fail");
}

- (void)testReturnedPassword
{
    PSPassword *password    = [PSPassword passwordWithDictionary:inDictionary isFavorite:isFavorite inContext:context];
    NSString   *outPassword = password.password;
    XCTAssertEqual(outPassword, inPassword, @"fail");
}

#pragma mark - Test param: isFavorite

#warning  еализовать
@end
