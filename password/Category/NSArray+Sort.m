//
//  NSArray+Sort.h
//  imopc
//
//  Created by Alexander Gomzyakov on 04.03.14.
//  Copyright (c) 2014 ABAK PRESS. All rights reserved.
//

#import "NSArray+Sort.h"

@implementation NSArray (Sort)

- (NSArray *)arraySortedByTitleProperty
{
    NSArray *unsortedArray = self;

    NSSortDescriptor *sortOrderDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"title"
                                                                          ascending:YES
                                                                           selector:@selector(localizedCaseInsensitiveCompare:)];
    NSArray *sortedArray = [unsortedArray sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortOrderDescriptor]];

    return sortedArray;
}

@end
