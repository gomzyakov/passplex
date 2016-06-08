//
//  AppDelegate.h
//  password
//
//  Created by Alexander Gomzyakov on 29.04.13.
//  Copyright (c) 2013 Alexander Gomzyakov. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PSPinViewController;
@class PSSetPinViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

/**
 Данные резервной копии.
 @note Данные приходят в приложение из вне и импортируются в PSPasswordsVC
 после ввода пин-кода (не хорошо как-то алерт накидывать поверх пин-представления)
 */
@property (nonatomic, strong) NSData *importedData;

/// Указатель на контроллер представления ввода PIN-кода.
@property (nonatomic, strong) PSPinViewController *pinViewController;

/// Указатель на контроллер представления установки PIN-кода.
@property (nonatomic, strong) UINavigationController *setPinNavigationController;

// Core Data
@property (readonly, strong, nonatomic) NSManagedObjectContext       *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel         *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)   saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
