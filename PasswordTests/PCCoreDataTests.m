//
//  PCCoreDataTests.m
//  imopc
//
//  Created by Alexander Gomzyakov on 27.02.14.
//  Copyright (c) 2014 ABAK PRESS. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <CoreData/CoreData.h>

/**
 Тестирование работоспособности Core Data с хранением управляемых объектов в памяти.
 */
@interface PCCoreDataTests : XCTestCase
{
    NSManagedObjectModel         *model;
    NSPersistentStoreCoordinator *coordinator;
    NSManagedObjectContext       *context;
    NSPersistentStore            *store;
}


@end

@implementation PCCoreDataTests

- (void)setUp
{
    [super setUp];

    NSArray *bundles = [NSArray arrayWithObject:[NSBundle mainBundle]];
    model       = [NSManagedObjectModel mergedModelFromBundles:bundles];
    coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
    store       = [coordinator addPersistentStoreWithType:NSInMemoryStoreType configuration:nil URL:nil options:nil error:NULL];
    context     = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [context setPersistentStoreCoordinator:coordinator];
}

- (void)tearDown
{
    model       = nil;
    coordinator = nil;
    context     = nil;
    store       = nil;
    [super tearDown];
}

- (void)testModel
{
    XCTAssertNotNil(model, @"error loading model");
}

- (void)testCoordinator
{
    XCTAssertNotNil(coordinator, @"error loading coordinator");
}

- (void)testContext
{
    XCTAssertNotNil(context, @"error loading context");
}

- (void)testStore
{
    XCTAssertNotNil(store, @"Unable to create in-memory store");
}

- (void)testEntitiesCount
{
    NSArray *allEntities = [model entities];
    XCTAssertTrue(allEntities.count > 0, @"no entities in bundle!");
}

@end
