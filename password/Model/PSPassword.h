//
//  Password.h
//  password
//
//  Created by Alexander Gomzyakov on 04.06.13.
//  Copyright (c) 2013 Alexander Gomzyakov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface PSPassword : NSManagedObject

@property (nonatomic, retain) NSString *username;
@property (nonatomic, retain) NSString *password;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *siteUrl;
@property (nonatomic, retain) NSNumber *isFavorite;
@property (nonatomic, retain) NSDate   *created;
@property (nonatomic, retain) NSString *note;

@end
