//
//  AppDelegate.m
//  password
//
//  Created by Alexander Gomzyakov on 29.04.13.
//  Copyright (c) 2013 Alexander Gomzyakov. All rights reserved.
//

#import "AppDelegate.h"
#import "PSPasswordsTableViewController.h"
#import "PSPinViewController.h"
#import "PSSetPinViewController.h"

// helpers
#import "UIViewController+Utils.h"

// Models
#import "PSPinCode.h"

@implementation AppDelegate

@synthesize managedObjectContext       = _managedObjectContext;
@synthesize managedObjectModel         = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

#pragma mark - Application Lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    UIWindow *window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window = window;
	
    [self customizeAppearance];

    self.importedData = nil;

    self.pinViewController = [[PSPinViewController alloc] init];

#warning Рефакторить
    PSSetPinViewController *setPinViewController = [[PSSetPinViewController alloc] init];
    self.setPinNavigationController                           = [[UINavigationController alloc] initWithRootViewController:setPinViewController];
    self.setPinNavigationController.navigationBar.barStyle    = UIBarStyleDefault;
    self.setPinNavigationController.navigationBar.translucent = NO;

    self.window.rootViewController = [self passwordsListNavigationController];

    // Проверяем, не хочет ли пользователь добавить данные из резервной копии
    NSURL *url = (NSURL *)[launchOptions valueForKey:UIApplicationLaunchOptionsURLKey];
    if (url != nil && [url isFileURL]) {
        NSData *data = [NSData dataWithContentsOfURL:url];
        self.importedData = data;
    }

    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.

    // Если не отображать экран ввода пин-кода при сворачивании приложения, появляется неприятный
    // эффект - после того как приложение стало активно, пин-экран показывается с задержкой в доли секунды,
    // что позволяет потенциальному злоумышленнику увидеть title и username некоторых записей.
    [self presentPinView];
    [self saveContext];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [self presentPinView];
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    //[self performSelector:@selector(requestPasscode) withObject:nil afterDelay:0.2f];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

/**
   Метод вызывается в случае, если приложение (чаще всего Mail App) попросило нас открыть .gpas файл.
 */
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    if (url != nil && [url isFileURL]) {
        NSData *data = [NSData dataWithContentsOfURL:url];
        self.importedData = data;
    }
    return YES;
}

#pragma mark - Make VC

/**
   Возвращает инициализированный контроллер слайд-меню SWRevealViewController.
   @return Инициализированный контроллер  бокового слайд-меню SWRevealViewController.
 */
- (UINavigationController *)passwordsListNavigationController
{
    PSPasswordsTableViewController *passwordsListViewController       = [[PSPasswordsTableViewController alloc] init];
    UINavigationController         *passwordsListNavigationController = [[UINavigationController alloc] initWithRootViewController:passwordsListViewController];

    return passwordsListNavigationController;
}

#pragma mark - Core Data

- (void)saveContext
{
    NSError                *error                = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Failed to save to data store: %@", [error localizedDescription]);
            NSArray *detailedErrors = [[error userInfo] objectForKey:NSDetailedErrorsKey];
            if (detailedErrors != nil && [detailedErrors count] > 0) {
                for (NSError *detailedError in detailedErrors) {
                    NSLog(@"  DetailedError: %@", [detailedError userInfo]);
                }
            } else {
                NSLog(@"  %@", [error userInfo]);
            }
        }
        NSLog(@"Context saved");
    }
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }

    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"password" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }

    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"password.sqlite"];

    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
           Replace this implementation with code to handle the error appropriately.

           abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

           Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
           Check the error message to determine what the actual problem was.


           If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.

           If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
           [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]

         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
           @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}

           Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.

         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }

    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

#pragma mark - UI Appearance

/**
   Настраиваем внешний вид основных UI-элементов приложения.
 */
- (void)customizeAppearance
{
    //[[UINavigationBar appearance] setBarTintColor:[UIColor yellowColor]];

    [[UINavigationBar appearance] setTitleTextAttributes:@{
//															NSForegroundColorAttributeName : [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1.0],
         NSFontAttributeName : [UIFont fontWithName:@"Helvetica-Light" size:18.0]
     }];

    // Выставляем цвет подсветки активных элементов (синий, по умолчанию)
    //[[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
}

#pragma mark - Helpers

/**
 Показываем экран ввода или установки PIN-кода.
 */
- (void)presentPinView
{
    if ([PSPinCode isSet]) {
        if (![self.pinViewController isVisible]) {
            [self.window.rootViewController presentViewController:self.pinViewController animated:NO completion:nil];
        }
    } else {
        if (![self.setPinNavigationController isVisible]) {
            [self.window.rootViewController presentViewController:self.setPinNavigationController animated:NO completion:nil];
        }
    }
}

@end
