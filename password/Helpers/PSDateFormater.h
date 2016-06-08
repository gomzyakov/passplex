//
//  PCDateFormater.h
//  imopc
//
//  Created by Alexander Gomzyakov on 20.01.14.
//  Copyright (c) 2014 ABAK PRESS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PSDateFormater : NSObject

+ (NSDate *)dateFromString:(NSString *)string error:(NSError * *)error;

+ (NSString *)stringFromDiscountExpiration:(NSString *)discountExpiration;

@end
