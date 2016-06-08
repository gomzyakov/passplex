//
//  PCDateFormater.m
//  imopc
//
//  Created by Alexander Gomzyakov on 20.01.14.
//  Copyright (c) 2014 ABAK PRESS. All rights reserved.
//

#import "PSDateFormater.h"

@implementation PSDateFormater

+ (NSDate *)dateFromString:(NSString *)string error:(NSError * *)error
{
    NSDateFormatter *dateFormater = [[NSDateFormatter alloc] init];
    [dateFormater setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];

    NSDate *date;
    [dateFormater getObjectValue:&date forString:string range:nil error:error];

    return date;
}

+ (NSString *)stringFromDiscountExpiration:(NSString *)discountExpiration
{
    NSDate          *tmpDate       = [[NSDate alloc] init];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-mm-dd"];
    tmpDate = [dateFormatter dateFromString:discountExpiration];
    [dateFormatter setDateFormat:@"dd.mm.YYYY"];

    return [dateFormatter stringFromDate:tmpDate];
}

@end
