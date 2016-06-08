//
//  PSValidator.h
//  password
//
//  Created by Alexander Gomzyakov on 11.01.14.
//  Copyright (c) 2014 Alexander Gomzyakov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PSValidator : NSObject

+ (BOOL)validateTitle:(id)value;

+ (BOOL)validatePassword:(id)value;

+ (BOOL)validateUsername:(id)value;

+ (BOOL)validateEmail:(NSString *)candidate;

+ (BOOL)validateURLString:(NSString *)url;

@end
