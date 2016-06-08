//
//  LocalizedSettings.h
//  password
//
//  Created by Alexander Gomzyakov on 11.04.14.
//  Copyright (c) 2014 Alexander Gomzyakov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocalizedSettings : NSObject

+ (NSString *)emailBackupTitle;

+ (NSString *)emailBackupMessage;

+ (NSString *)viewTitle;

+ (NSString *)alertMessageEmailPrepareError;

+ (NSString *)alertMessageRemoveAllPasswords;

+ (NSString *)buttonTitleRemoveAllPasswords;

+ (NSString *)cellTitleChangePin;

+ (NSString *)cellTitleDeleteAllPasswords;

+ (NSString *)cellTitleExportToEmail;

@end
