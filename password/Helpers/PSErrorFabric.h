//
//  PCErrorFabric.h
//  imopc
//
//  Created by Gomzyakov on 11.02.14.
//  Copyright (c) 2014 ABAK PRESS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PSErrorFabric : NSObject

/**
 Возвращает экземпляр простой ошибки NSError с заданным кодом и описанием.
 @param errorCode        Код ошибки.
 @param errorDescription Описание ошибки.
 @return Экземпляр простой ошибки NSError с заданным кодом и описанием.
 */
+ (NSError *)errorWithCode:(NSInteger)errorCode errorDescription:(NSString *)errorDescription;

/**
 Возвращает домен ошибки в рамках которого она возникла.
 @return Домен ошибки в рамках которого она возникла.
 */
+ (NSString *)errorDomain;

@end
