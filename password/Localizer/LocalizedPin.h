//
//  LocalizedPin.h
//  password
//
//  Created by Alexander Gomzyakov on 13.04.14.
//  Copyright (c) 2014 Alexander Gomzyakov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocalizedPin : NSObject

+ (NSString *)alertMessagePasscodeIsEnteredIncorrectly;

+ (NSString *)viewTitleSetPin;

+ (NSString *)viewTitleEnterPin;

+ (NSString *)viewTitleConfirmPin;

+ (NSString *)alertMessageIncorrectPasscodeConfirmation;

@end
